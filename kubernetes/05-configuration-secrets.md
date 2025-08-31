# 05 - Configuration and Secrets Management

## 🔐 Kubernetes Secrets

### Overview
Kubernetes Secrets are used to store and manage sensitive information such as:
- Database passwords
- API keys
- TLS certificates
- Authentication tokens
- OAuth tokens

### Key Characteristics

**Security Features:**
- **Namespaced objects**: Secrets exist within the context of a specific namespace
- **Memory storage**: Secret data on nodes is stored in tmpfs volumes (virtual memory filesystem)
- **Temporary nature**: Everything in tmpfs is temporary - no files created on hard drive
- **Size limitation**: Per-secret size limit of 1MB exists
- **API storage**: API server stores secrets as plaintext in etcd

### Secret Creation Methods

#### 1. From Text Files
```bash
# Create secret from individual files
kubectl create secret generic db-secret \
  --from-file=username.txt \
  --from-file=password.txt

# Create secret from directory
kubectl create secret generic app-secret --from-file=./secret-dir/
```

#### 2. From YAML File
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
  namespace: default
type: Opaque
data:
  username: YWRtaW4=  # base64 encoded value of 'admin'
  password: MWYyZDFlMmU2N2Rm  # base64 encoded value
stringData:
  config.yaml: |
    apiUrl: "https://my.api.com/api/v1"
    username: "admin"
    password: "t0p-Secret"
```

#### 3. From Command Line Literals
```bash
kubectl create secret generic literal-secret \
  --from-literal=username=devuser \
  --from-literal=password='S3cur3P@ssw0rd!'
```

### Using Secrets in Applications

#### Method 1: Environment Variables
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: username
      - name: SECRET_PASSWORD
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: password
  restartPolicy: Never
```

#### Method 2: Volume Mounts
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-volume-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    volumeMounts:
    - name: secret-volume
      mountPath: "/etc/secret-volume"
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: mysecret
      items:
      - key: username
        path: my-group/my-username
      - key: password
        path: my-group/my-password
  restartPolicy: Never
```

#### Method 3: All Environment Variables from Secret
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-envfrom-pod
spec:
  containers:
  - name: mycontainer
    image: redis
    envFrom:
    - secretRef:
        name: mysecret
  restartPolicy: Never
```

### Secret Types

```yaml
# Generic/Opaque secrets (default)
type: Opaque

# Docker registry secrets
type: kubernetes.io/dockerconfigjson

# TLS secrets
type: kubernetes.io/tls

# Service account tokens
type: kubernetes.io/service-account-token

# SSH authentication secrets
type: kubernetes.io/ssh-auth

# Basic authentication secrets
type: kubernetes.io/basic-auth
```

### Best Practices for Secrets

1. **Never store secrets in container images**
2. **Use RBAC to limit secret access**
3. **Enable encryption at rest for etcd**
4. **Rotate secrets regularly**
5. **Use external secret management systems in production**
6. **Monitor secret access and usage**

## 📋 ConfigMaps

### Overview
ConfigMaps are used to store non-confidential configuration data in key-value pairs. They allow you to decouple configuration artifacts from image content.

### Creating ConfigMaps

#### From Literal Values
```bash
kubectl create configmap app-config \
  --from-literal=database_url=postgresql://localhost:5432/mydb \
  --from-literal=log_level=info \
  --from-literal=debug=false
```

#### From Files
```bash
# From single file
kubectl create configmap app-config --from-file=app.properties

# From multiple files
kubectl create configmap app-config \
  --from-file=app.properties \
  --from-file=logging.conf

# From directory
kubectl create configmap app-config --from-file=./config-dir/
```

#### From YAML Definition
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: default
data:
  # Simple key-value pairs
  database_url: "postgresql://localhost:5432/mydb"
  log_level: "info"
  debug: "false"
  
  # File-like data
  app.properties: |
    server.port=8080
    server.host=0.0.0.0
    spring.datasource.url=jdbc:postgresql://localhost/mydb
    
  nginx.conf: |
    server {
        listen 80;
        server_name localhost;
        location / {
            proxy_pass http://backend:8080;
        }
    }
```

### Using ConfigMaps

#### As Environment Variables
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-env-pod
spec:
  containers:
  - name: mycontainer
    image: nginx
    env:
    - name: DATABASE_URL
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: database_url
    - name: LOG_LEVEL
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: log_level
```

#### Load All Keys as Environment Variables
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-envfrom-pod
spec:
  containers:
  - name: mycontainer
    image: nginx
    envFrom:
    - configMapRef:
        name: app-config
    - prefix: CONFIG_
      configMapRef:
        name: app-config
```

#### As Volume Mounts
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-volume-pod
spec:
  containers:
  - name: mycontainer
    image: nginx
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
    - name: nginx-config
      mountPath: /etc/nginx/nginx.conf
      subPath: nginx.conf
  volumes:
  - name: config-volume
    configMap:
      name: app-config
      items:
      - key: app.properties
        path: application.properties
  - name: nginx-config
    configMap:
      name: app-config
```

### ConfigMap Update Behavior

- **Environment variables**: Not updated automatically (requires pod restart)
- **Volume mounts**: Updated automatically (with some delay)
- **subPath mounts**: Not updated automatically

### Namespaces

#### Understanding Namespaces
Namespaces provide a mechanism to:
- **Isolate resources**: Group related elements with unique names
- **Apply policies**: Attach authorization and policies to cluster subsections
- **Organize clusters**: Separate different environments or teams

#### Creating Namespaces

**Declarative Approach:**
```yaml
# demo-namespace.yml
apiVersion: v1
kind: Namespace
metadata:
  name: demo-namespace
  labels:
    name: demo-namespace
    environment: development
```

**Imperative Commands:**
```bash
# Create namespace
kubectl create -f demo-namespace.yml

# Or create directly
kubectl create namespace development

# List all namespaces
kubectl get namespaces

# Get namespace details
kubectl get namespaces demo-namespace -o yaml
```

#### Working with Namespaces

**Get Resources from Specific Namespace:**
```bash
# Get pods from specific namespace
kubectl get pods -n demo-namespace
kubectl get pods --namespace=demo-namespace

# Get all resources from namespace
kubectl get all -n demo-namespace
```

**Setting Default Namespace:**
```bash
# Set default namespace for current context
kubectl config set-context $(kubectl config current-context) --namespace=demo-namespace

# Verify current namespace
kubectl config view | grep namespace
```

**Cross-Namespace Communication:**
```bash
# Service discovery across namespaces
service-name.namespace-name.svc.cluster.local

# Example: accessing database service in production namespace
database.production.svc.cluster.local
```

### Environment Variable Sources

#### Multiple Sources in Pod
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-env-pod
spec:
  containers:
  - name: app
    image: nginx
    env:
    # Direct value
    - name: ENVIRONMENT
      value: "production"
    
    # From ConfigMap
    - name: DATABASE_URL
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: database_url
    
    # From Secret
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: password
    
    # From field reference
    - name: NODE_NAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
    
    # From resource reference
    - name: CPU_REQUEST
      valueFrom:
        resourceFieldRef:
          resource: requests.cpu
    
    # Load all from ConfigMap
    envFrom:
    - configMapRef:
        name: app-config
        prefix: CONFIG_
    
    # Load all from Secret
    - secretRef:
        name: app-secret
        prefix: SECRET_
```

### Practical Examples

#### Complete Application Configuration
```yaml
# ConfigMap for application settings
apiVersion: v1
kind: ConfigMap
metadata:
  name: webapp-config
data:
  app.env: "production"
  log.level: "info"
  feature.flags: "new-ui=true,beta-api=false"
  application.yaml: |
    server:
      port: 8080
    database:
      pool-size: 10
      timeout: 30s
    logging:
      level: info
      pattern: "%d{ISO8601} [%thread] %-5level %logger{36} - %msg%n"

---
# Secret for sensitive data
apiVersion: v1
kind: Secret
metadata:
  name: webapp-secret
type: Opaque
data:
  database-password: cGFzc3dvcmQxMjM=
  api-key: YWJjZGVmZ2hpams=
  jwt-secret: bXlzdXBlcnNlY3JldGp3dGtleQ==

---
# Deployment using both ConfigMap and Secret
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: webapp
        image: mywebapp:v1.0
        ports:
        - containerPort: 8080
        env:
        - name: DATABASE_PASSWORD
          valueFrom:
            secretKeyRef:
              name: webapp-secret
              key: database-password
        envFrom:
        - configMapRef:
            name: webapp-config
        volumeMounts:
        - name: config-volume
          mountPath: /etc/config
        - name: secret-volume
          mountPath: /etc/secrets
          readOnly: true
      volumes:
      - name: config-volume
        configMap:
          name: webapp-config
          items:
          - key: application.yaml
            path: application.yaml
      - name: secret-volume
        secret:
          secretName: webapp-secret
```

### Troubleshooting Configuration Issues

**Common Issues:**
1. **Base64 encoding errors**: Ensure secrets are properly encoded
2. **Namespace mismatches**: ConfigMaps and Secrets must be in same namespace as pods
3. **Key not found errors**: Verify key names match exactly
4. **Permission issues**: Check RBAC permissions for secret access
5. **Mount path conflicts**: Ensure volume mount paths don't conflict

**Debugging Commands:**
```bash
# Describe secret/configmap
kubectl describe secret webapp-secret
kubectl describe configmap webapp-config

# Get secret/configmap content
kubectl get secret webapp-secret -o yaml
kubectl get configmap webapp-config -o yaml

# Check environment variables in running pod
kubectl exec -it pod-name -- printenv

# Check mounted files
kubectl exec -it pod-name -- ls -la /etc/config
kubectl exec -it pod-name -- cat /etc/secrets/database-password
```
