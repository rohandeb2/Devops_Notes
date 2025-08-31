# 06 - Advanced Kubernetes Concepts

## 🚀 Scaling and Replication

### Why Scaling Matters

Kubernetes was designed to orchestrate multiple containers and replication provides several key benefits:

#### 1. **Reliability**
- **High Availability**: Multiple instances prevent single points of failure
- **Fault Tolerance**: If one pod crashes, others continue serving traffic
- **Disaster Recovery**: Quick recovery from node failures

#### 2. **Load Balancing** 
- **Traffic Distribution**: Multiple instances share the load
- **Performance**: Prevents any single instance from being overwhelmed
- **Better Resource Utilization**: Spread workload across cluster nodes

#### 3. **Scaling**
- **Horizontal Scaling**: Add more instances when load increases
- **Elastic Scaling**: Scale up during peak times, scale down during low usage
- **Cost Optimization**: Use resources efficiently based on demand

#### 4. **Rolling Updates**
- **Zero Downtime**: Update applications without service interruption
- **Gradual Rollout**: Replace pods one by one
- **Easy Rollback**: Quick revert to previous versions if issues occur

## 🔄 Replication Controller

### Overview
A Replication Controller ensures that a specified number of pod replicas are running at any given time.

**Key Features:**
- **Automatic Pod Management**: Creates and deletes pods as needed
- **Self-Healing**: Automatically replaces crashed or failed pods
- **Scaling**: Easy to scale up or down
- **Simple Configuration**: Basic setup for pod replication

### Replication Controller Example
```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx-rc
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.20
        ports:
        - containerPort: 80
```

### When to Use Replication Controller
- **Single Pod Guarantee**: Ensure at least 1 pod is always running
- **System Reboots**: Pod survives system restarts
- **Simple Replication**: Basic scaling needs without complex requirements

**RC Management Commands:**
```bash
# Create replication controller
kubectl create -f nginx-rc.yaml

# Scale replication controller
kubectl scale rc nginx-rc --replicas=5

# Check RC status
kubectl get rc

# Delete RC (keeps pods)
kubectl delete rc nginx-rc --cascade=false

# Delete RC (deletes pods too)
kubectl delete rc nginx-rc
```

## 📋 ReplicaSets

### Evolution from Replication Controller
ReplicaSet is the next-generation Replication Controller with enhanced capabilities:

**Key Improvements:**
- **Set-based Selectors**: More flexible than equality-based selectors
- **Advanced Label Matching**: Supports `in`, `notin`, `exists` operators
- **Used by Deployments**: Modern approach for production workloads

### ReplicaSet Configuration
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend-rs
  labels:
    app: frontend
    tier: frontend
spec:
  # Number of desired pods
  replicas: 3
  
  # Label selector for pods
  selector:
    matchLabels:
      tier: frontend
    matchExpressions:
      - key: tier
        operator: In
        values:
          - frontend
  
  # Pod template
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: gcr.io/google-samples/gb-frontend:v3
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
```

### Set-Based Selectors
```yaml
selector:
  matchLabels:
    component: redis
  matchExpressions:
    - key: tier
      operator: In
      values:
        - cache
    - key: environment
      operator: NotIn
      values:
        - dev
    - key: track
      operator: Exists
    - key: deprecated
      operator: DoesNotExist
```

**Selector Operators:**
- **In**: Label value must be in the given set
- **NotIn**: Label value must not be in the given set  
- **Exists**: Label key must exist (value ignored)
- **DoesNotExist**: Label key must not exist

### ReplicaSet Management
```bash
# Create ReplicaSet
kubectl create -f frontend-rs.yaml

# Get ReplicaSets
kubectl get rs
kubectl get replicaset

# Describe ReplicaSet
kubectl describe rs frontend-rs

# Scale ReplicaSet
kubectl scale rs frontend-rs --replicas=5

# Delete ReplicaSet
kubectl delete rs frontend-rs
```

## 🚢 Deployments and Rollbacks

### Why Deployments Over ReplicaSets?

**Limitations of RC/RS:**
- ❌ No built-in update strategy
- ❌ No rollback capability  
- ❌ No versioning
- ❌ Manual update management

**Deployment Advantages:**
- ✅ **Rolling Updates**: Zero-downtime updates
- ✅ **Rollback Support**: Easy revert to previous versions
- ✅ **Version History**: Track deployment revisions
- ✅ **Update Strategies**: Control how updates are performed
- ✅ **Pause/Resume**: Control update process

### Deployment Architecture
```
Deployment
    ↓
ReplicaSet (v1) → Pods (v1)
    ↓ (Rolling Update)
ReplicaSet (v2) → Pods (v2)
```

### Deployment Configuration
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  
  # Update strategy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1      # Max pods that can be unavailable during update
      maxSurge: 1            # Max pods that can be created above desired replicas
  
  selector:
    matchLabels:
      app: nginx
  
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.20
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits:
            cpu: 200m
            memory: 200Mi
```

### Deployment Strategies

#### 1. **RollingUpdate (Default)**
- Gradually replaces old pods with new ones
- Maintains service availability
- Configurable pace via `maxUnavailable` and `maxSurge`

#### 2. **Recreate**
- Terminates all existing pods before creating new ones
- Causes downtime but ensures no mixed versions
- Useful for applications that can't handle multiple versions

```yaml
spec:
  strategy:
    type: Recreate
```

### Rolling Update Process
1. **Create New ReplicaSet**: New version pods are created
2. **Scale Up New**: Gradually increase new ReplicaSet replicas
3. **Scale Down Old**: Gradually decrease old ReplicaSet replicas  
4. **Complete**: Old ReplicaSet scaled to 0, new ReplicaSet at desired count

### Deployment Management Commands

#### Creating and Managing Deployments
```bash
# Create deployment
kubectl create -f nginx-deployment.yaml
kubectl create deployment nginx --image=nginx:1.20 --replicas=3

# Get deployments
kubectl get deployments
kubectl get deploy

# Check deployment details
kubectl describe deployment nginx-deployment

# Get deployment with additional info
kubectl get deployment nginx-deployment -o wide
```

#### Scaling Deployments
```bash
# Scale deployment
kubectl scale deployment nginx-deployment --replicas=5

# Autoscale deployment
kubectl autoscale deployment nginx-deployment --min=2 --max=10 --cpu-percent=80
```

#### Rolling Updates
```bash
# Update deployment image
kubectl set image deployment/nginx-deployment nginx=nginx:1.21

# Update with record (for rollback history)
kubectl set image deployment/nginx-deployment nginx=nginx:1.21 --record

# Edit deployment directly
kubectl edit deployment nginx-deployment

# Patch deployment
kubectl patch deployment nginx-deployment -p '{"spec":{"template":{"spec":{"containers":[{"name":"nginx","image":"nginx:1.21"}]}}}}'
```

#### Rollback Management
```bash
# Check rollout status
kubectl rollout status deployment nginx-deployment

# View rollout history
kubectl rollout history deployment nginx-deployment

# View specific revision
kubectl rollout history deployment nginx-deployment --revision=2

# Rollback to previous version
kubectl rollout undo deployment nginx-deployment

# Rollback to specific revision
kubectl rollout undo deployment nginx-deployment --to-revision=1

# Pause rollout (useful for canary deployments)
kubectl rollout pause deployment nginx-deployment

# Resume rollout
kubectl rollout resume deployment nginx-deployment
```

### Deployment Status Fields

When you check deployments, you'll see these fields:

- **NAME**: Deployment name
- **READY**: Shows ready/desired replicas (e.g., `3/3`)
- **UP-TO-DATE**: Number of replicas updated to achieve desired state
- **AVAILABLE**: Number of replicas available to users
- **AGE**: How long the deployment has been running

### Deployment Use Cases

#### 1. **Create Deployment to Roll Out ReplicaSet**
- ReplicaSet creates pods in background
- Check rollout status for success/failure

#### 2. **Declare New State of Pods**  
- Update PodTemplateSpec of deployment
- New ReplicaSet created automatically
- Controlled migration from old to new ReplicaSet

#### 3. **Rollback to Earlier Revision**
- Rollback when current state is unstable
- Each rollback updates deployment revision

#### 4. **Scale Up for More Load**
- Handle increased traffic
- Add more pod replicas

#### 5. **Pause Deployment for Multiple Fixes**
- Apply multiple changes to PodTemplateSpec
- Resume to start new rollout with all changes

#### 6. **Clean Up Old ReplicaSets**
- Remove unnecessary older ReplicaSets
- Control revision history limit

### Advanced Deployment Features

#### Revision History Limit
```yaml
spec:
  revisionHistoryLimit: 5  # Keep only 5 old ReplicaSets
```

#### Progress Deadline
```yaml
spec:
  progressDeadlineSeconds: 600  # Fail deployment if not progressed in 10 minutes
```

#### Pod Disruption Budget
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: nginx-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: nginx
```

### Monitoring Deployment Health

#### Check Pod Status
```bash
# Get pods with labels
kubectl get pods -l app=nginx

# Watch pod changes
kubectl get pods -l app=nginx -w

# Get detailed pod info
kubectl describe pods -l app=nginx
```

#### Check Events
```bash
# Get deployment events
kubectl get events --sort-by=.metadata.creationTimestamp

# Get events for specific deployment
kubectl describe deployment nginx-deployment
```

### Troubleshooting Deployments

#### Common Issues
1. **Image Pull Errors**: Incorrect image name or registry issues
2. **Resource Limits**: Insufficient CPU/memory resources
3. **Health Check Failures**: Liveness/readiness probe failures
4. **ConfigMap/Secret Issues**: Missing configuration dependencies

#### Debug Commands
```bash
# Check deployment status
kubectl get deployment nginx-deployment -o yaml

# Check ReplicaSet status  
kubectl get rs -l app=nginx

# Check pod logs
kubectl logs -l app=nginx

# Debug failed pods
kubectl describe pod <pod-name>

# Get deployment conditions
kubectl get deployment nginx-deployment -o jsonpath='{.status.conditions[*].type}'
```

### Best Practices

1. **Always use Deployments** instead of bare ReplicaSets or Pods
2. **Set resource requests and limits** for predictable behavior
3. **Use health checks** (liveness and readiness probes)
4. **Test rollbacks** in staging environment
5. **Monitor deployment metrics** and set up alerts
6. **Use Pod Disruption Budgets** for critical applications
7. **Keep deployment manifests in version control**
8. **Use meaningful labels and annotations** for organization
9. **Set appropriate rollout strategy** based on application requirements
10. **Regular cleanup** of old ReplicaSets and unused resources
