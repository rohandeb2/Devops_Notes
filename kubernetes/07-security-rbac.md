# 07 - Security, RBAC, and Labels

## 🏷️ Labels and Selectors

### Understanding Labels

Labels are **key-value pairs** attached to Kubernetes objects that serve as:
- **Organization mechanism** for Kubernetes objects
- **Identification tags** for quick reference and grouping
- **Selection criteria** for operations and queries
- **Metadata** without predefined meaning that you define as needed

**Similar to:**
- AWS Tags for resource organization
- Git tags for version reference
- Database indexes for quick lookups

### Label Characteristics

**Key Properties:**
- **No predefined meaning**: You define what labels mean for your use case
- **Multiple labels per object**: Single object can have many labels
- **Non-unique**: Many objects can share the same labels
- **Flexible naming**: Use any naming convention that fits your organization

### Label Examples and Use Cases

#### Environment-Based Labels
```yaml
metadata:
  labels:
    environment: production
    environment: staging
    environment: development
    environment: testing
```

#### Application/Component Labels
```yaml
metadata:
  labels:
    app: web-server
    component: frontend
    app: database
    component: backend
    tier: cache
    tier: api
```

#### Organizational Labels
```yaml
metadata:
  labels:
    department: engineering
    team: devops
    owner: platform-team
    cost-center: engineering-dept
    project: mobile-app
```

#### Version and Release Labels
```yaml
metadata:
  labels:
    version: v1.2.0
    release: stable
    track: canary
    build: "12345"
```

#### Complete Label Example
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-server-pod
  labels:
    # Application identification
    app: web-server
    component: frontend
    tier: web
    
    # Environment and deployment
    environment: production
    version: v2.1.0
    release: stable
    
    # Organization
    team: platform
    department: engineering
    cost-center: eng-001
    
    # Operational
    monitoring: enabled
    backup: daily
    criticality: high
spec:
  containers:
  - name: nginx
    image: nginx:1.21
```

### Label Selectors

**Purpose**: Filter and select objects based on their labels

#### Types of Selectors

##### 1. **Equality-Based Selectors**
- Use `=`, `==`, `!=` operators
- Simple key-value matching

```bash
# Command line examples
kubectl get pods -l environment=production
kubectl get pods -l environment!=development  
kubectl get pods -l environment=production,tier=frontend
```

```yaml
# In YAML manifests
selector:
  matchLabels:
    environment: production
    app: web-server
```

##### 2. **Set-Based Selectors**
- Use `in`, `notin`, `exists` operators
- More flexible filtering

```bash
# Command line examples
kubectl get pods -l 'environment in (production,staging)'
kubectl get pods -l 'environment notin (development)'
kubectl get pods -l environment
kubectl get pods -l '!deprecated'
```

```yaml
# In YAML manifests
selector:
  matchExpressions:
  - key: environment
    operator: In
    values:
    - production
    - staging
  - key: tier
    operator: NotIn
    values:
    - cache
  - key: monitoring
    operator: Exists
  - key: deprecated
    operator: DoesNotExist
```

#### Combined Selectors
```yaml
selector:
  matchLabels:
    app: web-server
  matchExpressions:
  - key: environment
    operator: In
    values: ["production", "staging"]
  - key: deprecated
    operator: DoesNotExist
```

### Node Selector

**Use Case**: Constrain pods to run on specific nodes based on node labels

#### Labeling Nodes
```bash
# Add labels to nodes
kubectl label nodes worker-1 disktype=ssd
kubectl label nodes worker-2 disktype=hdd
kubectl label nodes worker-1 zone=us-west-1a
kubectl label nodes worker-2 zone=us-west-1b
kubectl label nodes gpu-node-1 accelerator=nvidia-tesla-k80

# View node labels
kubectl get nodes --show-labels

# View specific labels
kubectl get nodes -l disktype=ssd
```

#### Using Node Selector in Pods
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ssd-pod
spec:
  containers:
  - name: app
    image: nginx
  nodeSelector:
    disktype: ssd
    zone: us-west-1a
```

#### Advanced Node Selection
```yaml
# Using node affinity (more flexible than nodeSelector)
apiVersion: v1
kind: Pod
metadata:
  name: advanced-node-selection
spec:
  containers:
  - name: app
    image: nginx
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        preference:
          matchExpressions:
          - key: zone
            operator: In
            values:
            - us-west-1a
```

### Label Best Practices

#### 1. **Consistent Naming Convention**
```yaml
# Good: Consistent naming
app: web-server
component: frontend
version: v1.2.0
environment: production

# Bad: Inconsistent naming  
App: web-server
comp: frontend
ver: 1.2.0
env: prod
```

#### 2. **Hierarchical Organization**
```yaml
# Use dot notation for hierarchy
app.kubernetes.io/name: mysql
app.kubernetes.io/instance: mysql-abcxzy
app.kubernetes.io/version: "5.7.21"
app.kubernetes.io/component: database
app.kubernetes.io/part-of: wordpress
app.kubernetes.io/managed-by: helm
```

#### 3. **Standard Kubernetes Labels**
```yaml
# Recommended Kubernetes labels
metadata:
  labels:
    app.kubernetes.io/name: guestbook
    app.kubernetes.io/instance: guestbook-1
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: frontend
    app.kubernetes.io/part-of: guestbook-app
    app.kubernetes.io/managed-by: kubectl
```

#### 4. **Environment-Specific Labels**
```yaml
# Environment segregation
metadata:
  labels:
    environment: production
    stage: prod
    datacenter: us-west-2
    cluster: prod-cluster-1
```

#### 5. **Operational Labels**
```yaml
# Operational metadata
metadata:
  labels:
    backup: enabled
    monitoring: prometheus
    logging: fluentd
    network-policy: restricted
    security-scan: passed
```

### Label Management Commands

```bash
# Add labels to existing resources
kubectl label pod nginx-pod environment=production
kubectl label node worker-1 disktype=ssd

# Update labels (overwrite)
kubectl label pod nginx-pod environment=staging --overwrite

# Remove labels
kubectl label pod nginx-pod environment-
kubectl label node worker-1 disktype-

# Show labels
kubectl get pods --show-labels
kubectl get nodes --show-labels

# Filter by labels
kubectl get pods -l environment=production
kubectl get pods -l 'environment in (production,staging)'
kubectl get pods -l environment,app=nginx

# Label multiple resources
kubectl label pods -l app=nginx tier=frontend
```

## 🔒 Kubernetes Security

### Security Fundamentals

**Multi-layered Security Approach:**
1. **Cluster Security**: Secure the Kubernetes control plane and nodes
2. **Pod Security**: Secure individual workloads and containers
3. **Network Security**: Control communication between components
4. **Secret Management**: Protect sensitive information
5. **Access Control**: Implement proper authentication and authorization

### Pod Security

#### Security Contexts
Control security settings for pods and containers:

**Pod-level Security Context:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    # Run as specific user ID
    runAsUser: 1000
    runAsGroup: 3000
    
    # Set file system group
    fsGroup: 2000
    
    # Set file system group change policy
    fsGroupChangePolicy: "OnRootMismatch"
    
    # SELinux options
    seLinuxOptions:
      level: "s0:c123,c456"
      
    # Seccomp profile
    seccompProfile:
      type: RuntimeDefault
      
    # Sysctls
    sysctls:
    - name: kernel.shm_rmid_forced
      value: "0"
```

**Container-level Security Context:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-2
spec:
  containers:
  - name: sec-ctx-demo-2
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      # Prevent privilege escalation
      allowPrivilegeEscalation: false
      
      # Run as non-root user
      runAsNonRoot: true
      runAsUser: 1000
      runAsGroup: 1000
      
      # Read-only root filesystem
      readOnlyRootFilesystem: true
      
      # Linux capabilities
      capabilities:
        drop:
        - ALL
        add:
        - NET_BIND_SERVICE
        
      # Seccomp profile
      seccompProfile:
        type: RuntimeDefault
        
      # AppArmor profile
      appArmorProfile:
        type: RuntimeDefault
```

#### Resource Limits and Requests
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-limited-pod
spec:
  containers:
  - name: app
    image: nginx
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
        ephemeral-storage: "1Gi"
      limits:
        memory: "128Mi"
        cpu: "500m"
        ephemeral-storage: "2Gi"
```

#### Pod Security Standards
```yaml
# Pod Security Standards enforcement
apiVersion: v1
kind: Namespace
metadata:
  name: secure-namespace
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

### Network Security

#### Network Policies
Control traffic flow between pods:

```yaml
# Deny all ingress traffic
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: production
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

```yaml
# Allow specific ingress traffic
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 8080
```

```yaml
# Comprehensive network policy
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: web-app-netpol
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: web-app
  policyTypes:
  - Ingress
  - Egress
  
  ingress:
  # Allow from same namespace
  - from:
    - namespaceSelector:
        matchLabels:
          name: production
    ports:
    - protocol: TCP
      port: 80
  
  # Allow from specific pods
  - from:
    - podSelector:
        matchLabels:
          app: load-balancer
    ports:
    - protocol: TCP
      port: 8080
  
  egress:
  # Allow to database
  - to:
    - podSelector:
        matchLabels:
          app: database
    ports:
    - protocol: TCP
      port: 5432
  
  # Allow DNS
  - to: []
    ports:
    - protocol: UDP
      port: 53
```

### Secret Security

#### Secure Secret Creation
```bash
# Create secret with proper permissions
kubectl create secret generic db-secret \
  --from-literal=username=admin \
  --from-literal=password=secretpass \
  --dry-run=client -o yaml | kubectl apply -f -

# Create TLS secret
kubectl create secret tls tls-secret \
  --cert=path/to/tls.crt \
  --key=path/to/tls.key
```

#### Secure Secret Usage
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-secret-pod
spec:
  containers:
  - name: app
    image: nginx
    env:
    - name: DB_USERNAME
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: username
    volumeMounts:
    - name: secret-volume
      mountPath: "/etc/secrets"
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: db-secret
      defaultMode: 0400  # Read-only for owner only
  serviceAccountName: limited-service-account
```

### RBAC (Role-Based Access Control)

#### Service Accounts
```yaml
# Create service account
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-service-account
  namespace: production
automountServiceAccountToken: false  # Disable automatic token mounting
```

#### Roles and ClusterRoles
```yaml
# Role - namespace-scoped permissions
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: production
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get"]

---
# ClusterRole - cluster-wide permissions
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: node-reader
rules:
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]
```

#### RoleBindings and ClusterRoleBindings
```yaml
# RoleBinding - bind role to subjects in namespace
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: production
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
- kind: ServiceAccount
  name: app-service-account
  namespace: production
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io

---
# ClusterRoleBinding - bind cluster role to subjects cluster-wide
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: read-nodes
subjects:
- kind: User
  name: admin
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: node-reader
  apiGroup: rbac.authorization.k8s.io
```

### Security Best Practices

#### 1. **Container Security**
```yaml
# Secure container configuration
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  containers:
  - name: app
    image: nginx:1.21-alpine
    securityContext:
      runAsNonRoot: true
      runAsUser: 65534
      readOnlyRootFilesystem: true
      allowPrivilegeEscalation: false
      capabilities:
        drop:
        - ALL
    resources:
      limits:
        memory: "128Mi"
        cpu: "100m"
      requests:
        memory: "64Mi"
        cpu: "50m"
```

#### 2. **Image Security**
```bash
# Use specific image tags
# Good
image: nginx:1.21.0-alpine

# Bad  
image: nginx:latest
```

#### 3. **Secrets Management**
```yaml
# Use external secret management
apiVersion: v1
kind: Secret
metadata:
  name: external-secret
  annotations:
    vault.hashicorp.com/agent-inject: "true"
    vault.hashicorp.com/role: "internal-app"
    vault.hashicorp.com/agent-inject-secret-database: "internal/data/database/config"
```

#### 4. **Network Policies**
```yaml
# Default deny-all policy
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

### Security Scanning and Monitoring

#### 1. **Pod Security Standards**
```bash
# Check pod security violations
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{": "}{.status.conditions[?(@.type=="PodSecurityViolation")].message}{"\n"}{end}'
```

#### 2. **RBAC Audit**
```bash
# Check current permissions
kubectl auth can-i get pods --as=system:serviceaccount:production:app-service-account

# Check all permissions
kubectl auth can-i --list --as=system:serviceaccount:production:app-service-account
```

#### 3. **Security Context Validation**
```bash
# Check running containers security context
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{": runAsUser="}{.spec.securityContext.runAsUser}{", runAsNonRoot="}{.spec.securityContext.runAsNonRoot}{"\n"}{end}'
```

### Troubleshooting Security Issues

#### Common Security Problems

**1. Permission Denied Errors:**
```bash
# Check RBAC permissions
kubectl auth can-i create pods --as=system:serviceaccount:default:my-service-account

# Debug RBAC
kubectl describe rolebinding
kubectl describe clusterrolebinding
```

**2. Pod Security Policy Violations:**
```bash
# Check pod events
kubectl describe pod problematic-pod

# Check security context
kubectl get pod problematic-pod -o yaml | grep -A 10 securityContext
```

**3. Network Policy Issues:**
```bash
# Test network connectivity
kubectl exec -it test-pod -- nc -zv target-service 80

# Check network policies
kubectl get networkpolicies
kubectl describe networkpolicy policy-name
```

### Security Checklist

**Pod Security:**
- [ ] Run containers as non-root user
- [ ] Use read-only root filesystem
- [ ] Drop all capabilities, add only necessary ones
- [ ] Disable privilege escalation
- [ ] Set resource limits
- [ ] Use security contexts
- [ ] Enable seccomp profiles

**Secret Management:**
- [ ] Store secrets in Kubernetes Secrets, not in images
- [ ] Use external secret management systems
- [ ] Rotate secrets regularly
- [ ] Limit secret access with RBAC
- [ ] Mount secrets as read-only volumes

**Network Security:**
- [ ] Implement network policies
- [ ] Use TLS for all communications
- [ ] Limit exposed ports
- [ ] Segment namespaces properly

**Access Control:**
- [ ] Implement RBAC
- [ ] Use service accounts for pods
- [ ] Follow principle of least privilege
- [ ] Regular access review and audit

**Image Security:**
- [ ] Use specific image tags, not 'latest'
- [ ] Scan images for vulnerabilities
- [ ] Use minimal base images
- [ ] Sign and verify images
- [ ] Use private registries for sensitive applications
