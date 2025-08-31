# 10 - Kubernetes Interview Preparation

## 🎯 Core Concepts Interview Questions

### **Q1: What is Kubernetes and why do we use it?**

**Answer:**
Kubernetes is an open-source container orchestration platform that automates container deployment, scaling, and management. Originally developed by Google based on their internal "Borg" system, it was donated to CNCF in 2014.

**Key Benefits:**
- **Orchestration**: Manages clusters of containers across multiple hosts
- **Auto-scaling**: Both horizontal and vertical scaling capabilities
- **Self-healing**: Automatically restarts failed containers and replaces unhealthy nodes
- **Load balancing**: Distributes traffic across healthy pods
- **Platform independence**: Runs on cloud, on-premises, or hybrid environments
- **Fault tolerance**: Handles node and pod failures gracefully
- **Rolling updates**: Zero-downtime deployments with easy rollback

### **Q2: Explain Kubernetes Architecture**

**Answer:**
Kubernetes follows a master-worker architecture:

**Control Plane (Master) Components:**
- **kube-apiserver**: Frontend of control plane, handles API requests
- **etcd**: Distributed key-value store for cluster state
- **kube-scheduler**: Assigns pods to nodes based on resource requirements
- **kube-controller-manager**: Runs controller processes (node, replication, endpoints, etc.)
- **cloud-controller-manager**: Integrates with cloud provider APIs

**Worker Node Components:**
- **kubelet**: Agent that runs on each node, communicates with master
- **kube-proxy**: Network proxy for service discovery and load balancing
- **Container Runtime**: Docker, containerd, or CRI-O

### **Q3: What is a Pod and why is it the smallest unit in Kubernetes?**

**Answer:**
A Pod is the smallest deployable unit in Kubernetes that represents a group of one or more containers.

**Key Characteristics:**
- **Shared Network**: All containers share the same IP address and port space
- **Shared Storage**: Containers can share volumes
- **Lifecycle Management**: All containers start and stop together
- **Single Node Deployment**: Pod always runs on a single node
- **Mortal**: Pods are ephemeral and can be created/destroyed as needed

**Why Pods, not Containers?**
- Enables helper containers (sidecars, init containers)
- Provides atomic deployment unit
- Facilitates inter-container communication via localhost
- Allows shared storage between related containers

## 🏗️ Workloads and Controllers

### **Q4: Explain the difference between ReplicationController, ReplicaSet, and Deployment**

**Answer:**

**ReplicationController (Legacy):**
- Ensures specified number of pod replicas
- Uses equality-based selectors only
- Basic scaling and self-healing
- Being replaced by ReplicaSets

**ReplicaSet:**
- Next-generation ReplicationController
- Supports set-based selectors (In, NotIn, Exists)
- More flexible label matching
- Used by Deployments under the hood

**Deployment:**
- Higher-level abstraction over ReplicaSets
- Provides declarative updates and rollbacks
- Rolling update strategies
- Revision history management
- Production-recommended approach

```yaml
# ReplicaSet selector example
selector:
  matchLabels:
    app: frontend
  matchExpressions:
  - key: tier
    operator: In
    values: [frontend]
```

### **Q5: How do Deployments handle rolling updates?**

**Answer:**
Deployments use a controlled rollout process:

**Process:**
1. Create new ReplicaSet with updated pod template
2. Gradually scale up new ReplicaSet
3. Gradually scale down old ReplicaSet
4. Monitor health during transition

**Configuration:**
```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 1    # Max pods down during update
    maxSurge: 1         # Max extra pods during update
```

**Commands:**
```bash
# Start rolling update
kubectl set image deployment/nginx nginx=nginx:1.21

# Check status
kubectl rollout status deployment/nginx

# Rollback
kubectl rollout undo deployment/nginx
```

## 🌐 Services and Networking

### **Q6: Explain different types of Services in Kubernetes**

**Answer:**

**ClusterIP (Default):**
- Internal cluster communication only
- Virtual IP accessible within cluster
- Use case: Database services, internal APIs

**NodePort:**
- Exposes service on each node's IP at static port
- Port range: 30000-32767
- Use case: Development, simple external access

**LoadBalancer:**
- Creates cloud provider load balancer
- Automatically provisions external IP
- Use case: Production web applications

**ExternalName:**
- Maps service to external DNS name
- No proxy involved
- Use case: Database migration, external service mapping

```yaml
# LoadBalancer example
apiVersion: v1
kind: Service
metadata:
  name: web-app
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: web-app
```

### **Q7: How does service discovery work in Kubernetes?**

**Answer:**
Kubernetes provides automatic service discovery through:

**DNS-based Discovery:**
- CoreDNS creates DNS records for services
- Format: `service-name.namespace.svc.cluster.local`
- Pods automatically configured with cluster DNS

**Environment Variables:**
- Kubernetes injects service info as environment variables
- Format: `SERVICE_NAME_SERVICE_HOST` and `SERVICE_NAME_SERVICE_PORT`

**Service Endpoints:**
- kube-proxy watches for service/endpoint changes
- Maintains iptables/IPVS rules for load balancing
- Routes traffic to healthy pods only

### **Q8: What is Ingress and how does it differ from Services?**

**Answer:**

**Services:**
- Layer 4 (TCP/UDP) load balancing
- Internal or basic external access
- Limited routing capabilities

**Ingress:**
- Layer 7 (HTTP/HTTPS) load balancing
- Advanced routing based on host, path, headers
- SSL termination and certificate management
- Single entry point for multiple services

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
spec:
  rules:
  - host: api.company.com
    http:
      paths:
      - path: /users
        pathType: Prefix
        backend:
          service:
            name: user-service
            port:
              number: 80
  - host: admin.company.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: admin-service
            port:
              number: 80
```

## 💾 Storage and Persistence

### **Q9: Explain the difference between Volumes, PersistentVolumes, and PersistentVolumeClaims**

**Answer:**

**Volumes:**
- Pod-level storage that shares lifecycle with pod
- Data persists across container restarts but not pod restarts
- Types: emptyDir, hostPath, configMap, secret

**PersistentVolumes (PV):**
- Cluster-level storage resource
- Independent lifecycle from pods
- Provisioned by admin or dynamically
- Backed by network storage (NFS, cloud disks)

**PersistentVolumeClaims (PVC):**
- User request for storage
- Binds to available PV matching requirements
- Abstraction layer between pod and storage

```yaml
# PVC Example
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: web-storage
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: fast-ssd
```

**Relationship Flow:**
```
Pod → PVC → PV → Actual Storage
```

### **Q10: What are the different volume access modes?**

**Answer:**

**ReadWriteOnce (RWO):**
- Volume mounted as read-write by single node
- Most common for databases
- Example: AWS EBS, Azure Disk

**ReadOnlyMany (ROX):**
- Volume mounted as read-only by many nodes
- Use case: Shared configuration, static content
- Example: NFS (read-only mode)

**ReadWriteMany (RWX):**
- Volume mounted as read-write by many nodes
- Use case: Shared file systems, collaborative apps
- Example: NFS, GlusterFS, CephFS

**ReadWriteOncePod (RWOP):**
- Volume mounted as read-write by single pod
- Kubernetes 1.22+ feature
- Stricter than RWO

## 🔧 Configuration and Secrets

### **Q11: How do ConfigMaps and Secrets differ?**

**Answer:**

**ConfigMaps:**
- Store non-confidential configuration data
- Plain text key-value pairs
- Automatically updated when mounted as volumes
- Size limit: 1MB per ConfigMap

**Secrets:**
- Store sensitive information
- Base64 encoded (not encrypted)
- Stored in tmpfs (memory) on nodes
- Size limit: 1MB per Secret
- Not automatically updated when used as environment variables

**Best Practices:**
```yaml
# ConfigMap for app settings
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_host: "db.example.com"
  log_level: "info"
  
---
# Secret for sensitive data
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  database_password: cGFzc3dvcmQxMjM=  # base64 encoded
```

### **Q12: How would you securely manage secrets in production?**

**Answer:**

**Production Secret Management:**
1. **External Secret Management**: Use HashiCorp Vault, AWS Secrets Manager, Azure Key Vault
2. **Encryption at Rest**: Enable etcd encryption
3. **RBAC**: Limit secret access with proper roles
4. **Secret Rotation**: Implement automated secret rotation
5. **Avoid Environment Variables**: Use volume mounts for better security
6. **Separate Namespaces**: Isolate secrets by environment

```yaml
# External Secrets Operator example
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-backend
spec:
  provider:
    vault:
      server: "https://vault.company.com"
      path: "secret"
      auth:
        kubernetes:
          mountPath: "kubernetes"
          role: "my-role"
```

## 🔒 Security and RBAC

### **Q13: Explain RBAC in Kubernetes**

**Answer:**

**RBAC Components:**
- **Subjects**: Users, groups, service accounts
- **Resources**: Pods, services, deployments, etc.
- **Verbs**: get, list, create, update, delete, etc.
- **Roles/ClusterRoles**: Define permissions
- **RoleBindings/ClusterRoleBindings**: Bind roles to subjects

**Example:**
```yaml
# Role for pod management
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: production
  name: pod-manager
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "create", "delete"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get"]

---
# Bind role to user
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: manage-pods
  namespace: production
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-manager
  apiGroup: rbac.authorization.k8s.io
```

### **Q14: What are Pod Security Policies/Standards?**

**Answer:**

**Pod Security Standards (replacing PSP):**
- **Privileged**: No restrictions (for system workloads)
- **Baseline**: Basic restrictions (prevent privilege escalation)
- **Restricted**: Highly restrictive (production workloads)

**Implementation:**
```yaml
# Namespace with pod security
apiVersion: v1
kind: Namespace
metadata:
  name: secure-namespace
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

**Security Context Best Practices:**
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop: ["ALL"]
```

## 🚀 Scaling and Performance

### **Q15: How does Horizontal Pod Autoscaling work?**

**Answer:**

**HPA Process:**
1. **Metrics Collection**: Metrics server collects resource usage
2. **Target Calculation**: Compare current vs target utilization
3. **Scale Decision**: Calculate desired replica count
4. **Scale Action**: Update deployment replica count

**Formula:**
```
desired_replicas = ceil(current_replicas * (current_metric / target_metric))
```

**Example:**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

### **Q16: Explain Cluster Autoscaling vs Pod Autoscaling**

**Answer:**

**Horizontal Pod Autoscaler (HPA):**
- Scales number of pod replicas
- Based on CPU, memory, or custom metrics
- Works within existing cluster capacity

**Vertical Pod Autoscaler (VPA):**
- Scales pod resource requests/limits
- Right-sizes containers based on usage
- Can restart pods to apply changes

**Cluster Autoscaler:**
- Scales number of nodes in cluster
- Adds nodes when pods can't be scheduled
- Removes nodes when underutilized
- Cloud provider integration required

**Interaction:**
```
Resource Demand → HPA scales pods → 
Insufficient capacity → Cluster Autoscaler adds nodes →
VPA optimizes individual pod resources
```

## 📊 Monitoring and Troubleshooting

### **Q17: How do you troubleshoot a pod that won't start?**

**Answer:**

**Systematic Troubleshooting Approach:**

**1. Check Pod Status:**
```bash
kubectl get pods
kubectl describe pod <pod-name>
```

**2. Common Issues and Solutions:**

**ImagePullBackOff:**
- Check image name and tag
- Verify registry access
- Check imagePullSecrets

**CrashLoopBackOff:**
- Check application logs: `kubectl logs <pod> --previous`
- Verify liveness probe configuration
- Check resource limits

**Pending:**
- Check resource requests vs node capacity
- Verify node selectors and taints
- Check PVC availability

**3. Debug Commands:**
```bash
# Check events
kubectl get events --sort-by=.metadata.creationTimestamp

# Check node resources
kubectl describe node <node-name>

# Debug networking
kubectl exec -it <pod> -- nslookup kubernetes.default
```

### **Q18: What are the different types of probes and when do you use them?**

**Answer:**

**Liveness Probe:**
- **Purpose**: Detect if container is running
- **Action**: Restart container on failure
- **Use Case**: Deadlocks, memory leaks, unresponsive apps
- **Timing**: Throughout container lifecycle

**Readiness Probe:**
- **Purpose**: Detect if container is ready for traffic
- **Action**: Remove from service endpoints
- **Use Case**: Startup delays, temporary unavailability
- **Timing**: Throughout container lifecycle

**Startup Probe:**
- **Purpose**: Detect if application has started
- **Action**: Disable other probes until success
- **Use Case**: Slow-starting applications
- **Timing**: Only during container startup

**Configuration Example:**
```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
  
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
  
startupProbe:
  httpGet:
    path: /startup
    port: 8080
  initialDelaySeconds: 10
  periodSeconds: 10
  failureThreshold: 30  # 5 minutes max startup time
```

## 🏗️ Advanced Scenarios

### **Q19: Design a highly available multi-tier application deployment**

**Answer:**

**Architecture Components:**
```yaml
# Frontend Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: frontend
      tier: frontend
  template:
    metadata:
      labels:
        app: frontend
        tier: frontend
    spec:
      containers:
      - name: frontend
        image: nginx:1.21
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 200m
            memory: 256Mi
      # Anti-affinity for spreading across nodes
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: tier
                  operator: In
                  values:
                  - frontend
              topologyKey: kubernetes.io/hostname

---
# Backend Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 5
  template:
    spec:
      containers:
      - name: backend
        image: myapp:v1.0
        ports:
        - containerPort: 8080
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080

---
# Database StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database
spec:
  serviceName: database
  replicas: 3
  template:
    spec:
      containers:
      - name: postgres
        image: postgres:13
        env:
        - name: POSTGRES_DB
          value: myapp
        volumeMounts:
        - name: postgres-storage
          mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
  - metadata:
      name: postgres-storage
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 20Gi

---
# Pod Disruption Budget
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: frontend-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      tier: frontend
```

### **Q20: How would you implement blue-green deployment?**

**Answer:**

**Blue-Green Deployment Strategy:**

**1. Prepare Green Environment:**
```yaml
# Green deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-green
  labels:
    version: green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: green
  template:
    metadata:
      labels:
        app: myapp
        version: green
    spec:
      containers:
      - name: app
        image: myapp:v2.0
        ports:
        - containerPort: 8080
```

**2. Service Configuration:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: myapp
    version: blue  # Initially pointing to blue
  ports:
  - port: 80
    targetPort: 8080
```

**3. Deployment Process:**
```bash
# 1. Deploy green environment
kubectl apply -f app-green.yaml

# 2. Test green environment
kubectl port-forward deployment/app-green 8080:8080
# Run tests against localhost:8080

# 3. Switch traffic to green
kubectl patch service app-service -p '{"spec":{"selector":{"version":"green"}}}'

# 4. Monitor and rollback if needed
kubectl patch service app-service -p '{"spec":{"selector":{"version":"blue"}}}'

# 5. Clean up old version
kubectl delete deployment app-blue
```

**Benefits:**
- Zero downtime deployment
- Instant rollback capability
- Full environment testing
- Clear separation of versions

## 💡 Best Practices Questions

### **Q21: What are the production best practices for Kubernetes?**

**Answer:**

**Security:**
- Use RBAC with principle of least privilege
- Implement Pod Security Standards
- Enable audit logging
- Use network policies for segmentation
- Scan images for vulnerabilities
- Encrypt etcd at rest

**Resource Management:**
- Set resource requests and limits on all containers
- Use ResourceQuotas and LimitRanges
- Implement horizontal pod autoscaling
- Monitor resource utilization

**High Availability:**
- Multi-master control plane setup
- Spread workloads across availability zones
- Use Pod Disruption Budgets
- Implement proper backup strategies

**Monitoring and Logging:**
- Centralized logging (ELK, Fluentd)
- Metrics collection (Prometheus)
- Health checks on all applications
- Alerting for critical issues

**Configuration Management:**
- Externalize configuration with ConfigMaps
- Use Secrets for sensitive data
- Version control all manifests
- Use GitOps for deployment

### **Q22: How do you handle persistent storage in a multi-zone cluster?**

**Answer:**

**Challenges:**
- Zone affinity requirements
- Data replication across zones
- Backup and disaster recovery

**Solutions:**

**1. Zone-Aware Storage Classes:**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: zone-aware-ssd
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  zones: us-west-2a,us-west-2b,us-west-2c
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
```

**2. StatefulSet with Zone Distribution:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: distributed-database
spec:
  replicas: 3
  template:
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app: database
            topologyKey: topology.kubernetes.io/zone
      containers:
      - name: database
        image: postgres:13
        volumeMounts:
        - name: data
          mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      storageClassName: zone-aware-ssd
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 100Gi
```

## 🎯 Scenario-Based Questions

### **Q23: An application is experiencing intermittent 503 errors. How would you troubleshoot?**

**Answer:**

**Systematic Investigation:**

**1. Check Service and Endpoints:**
```bash
kubectl get svc myapp-service -o yaml
kubectl get endpoints myapp-service
```

**2. Check Pod Health:**
```bash
kubectl get pods -l app=myapp
kubectl describe pods -l app=myapp
```

**3. Review Readiness Probes:**
```yaml
readinessProbe:
  httpGet:
    path: /health/ready
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 3
```

**4. Check Resource Usage:**
```bash
kubectl top pods -l app=myapp
kubectl describe node <node-name>
```

**5. Analyze Logs:**
```bash
kubectl logs -l app=myapp --tail=100
kubectl logs -l app=myapp --previous
```

**Common Root Causes:**
- Readiness probe failures removing pods from endpoints
- Resource constraints causing pod evictions
- Application startup issues
- Database connection problems
- Network policies blocking traffic

### **Q24: How would you migrate a stateful application with zero downtime?**

**Answer:**

**Migration Strategy:**

**1. Prepare Target Environment:**
```yaml
# New StatefulSet with updated configuration
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database-v2
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: postgres
        image: postgres:14
        # Migration-specific configuration
```

**2. Data Replication Setup:**
```bash
# Set up streaming replication
kubectl exec database-0 -- pg_basebackup -h database-v2-0 -D /backup
```

**3. Traffic Migration:**
```yaml
# Service with multiple selectors during migration
apiVersion: v1
kind: Service
metadata:
  name: database-service
spec:
  selector:
    app: database  # Matches both old and new
  ports:
  - port: 5432
```

**4. Gradual Cutover:**
```bash
# 1. Redirect read traffic to new instances
# 2. Sync remaining data
# 3. Switch write traffic
# 4. Verify data consistency
# 5. Decommission old instances
```

## 📚 Quick Reference for Interviews

### **Essential Commands:**
```bash
# Cluster Info
kubectl cluster-info
kubectl get nodes
kubectl get namespaces

# Pod Management
kubectl get pods --all-namespaces
kubectl describe pod <pod-name>
kubectl logs <pod-name> -f
kubectl exec -it <pod-name> -- /bin/bash

# Service Management
kubectl get svc
kubectl expose deployment <name> --port=80 --target-port=8080
kubectl port-forward svc/<service-name> 8080:80

# Troubleshooting
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl top pods
kubectl top nodes
```

### **Common Issues and Solutions:**
| Issue | Symptoms | Solution |
|-------|----------|----------|
| ImagePullBackOff | Pod stuck in ImagePullBackOff | Check image name, registry access, pull secrets |
| CrashLoopBackOff | Pod continuously restarting | Check logs, resource limits, health probes |
| Pending | Pod stuck in Pending state | Check resource requests, node capacity, PVCs |
| Service not accessible | Can't reach service | Check endpoints, selectors, network policies |

### **Performance Optimization:**
- Set resource requests and limits
- Use horizontal pod autoscaling
- Implement proper health checks
- Optimize image sizes
- Use multi-stage Docker builds
- Enable resource monitoring

This comprehensive interview preparation guide covers the essential Kubernetes topics that are commonly asked in DevOps interviews, from basic concepts to advanced production scenarios.
Kubernetes is an open-source container orchestration platform that automates container deployment, scaling, and management. Originally developed by Google based on their internal "Borg" system, it was donated to CNCF in 2014.

**Key Benefits:**
- **Orchestration**: Manages clusters of containers across multiple hosts
- **Auto-scaling**: Both horizontal and vertical scaling capabilities
- **Self-healing**: Automatically restarts failed containers and replaces unhealthy nodes
- **Load balancing**: Distributes traffic across healthy pods
- **Platform independence**: Runs on cloud, on-premises, or hybrid environments
- **Fault tolerance**: Handles node and pod failures gracefully
- **Rolling updates**: Zero-downtime deployments with easy rollback
