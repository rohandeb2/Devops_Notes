# 08 - Monitoring and Troubleshooting

## 📊 Pod Lifecycle Management

### Understanding Pod Phases

Kubernetes pods go through several phases during their lifecycle:

#### Pod Phase States

**1. Pending**
- **Description**: Pod has been accepted by Kubernetes but containers are not yet started
- **Common Reasons**: 
  - Image pulling in progress
  - Waiting for node assignment
  - Resource constraints
  - Volume mounting issues

**2. Running** 
- **Description**: At least one container is running, starting, or restarting
- **Healthy State**: All containers are running successfully
- **Transition State**: Some containers may be starting/restarting

**3. Succeeded**
- **Description**: All containers terminated successfully with exit code 0
- **Use Cases**: Batch jobs, one-time tasks, completed migrations
- **Behavior**: Containers will not be restarted

**4. Failed**
- **Description**: One or more containers exited with non-zero status
- **Common Causes**: Application errors, resource limits exceeded, health check failures
- **Investigation**: Check container logs and events

**5. Unknown**
- **Description**: Pod state cannot be determined
- **Common Causes**: Node communication issues, kubelet problems
- **Action Required**: Check node status and network connectivity

### Pod Lifecycle Diagram

```
┌─────────┐    ┌─────────┐    ┌─────────────┐
│ Pending │───▶│ Running │───▶│ Succeeded   │
└─────────┘    └─────────┘    └─────────────┘
      │             │                │
      │             ▼                │
      │        ┌─────────┐           │
      └───────▶│ Failed  │◀──────────┘
               └─────────┘
                    │
                    ▼
               ┌─────────┐
               │ Unknown │
               └─────────┘
```

### Container States

Within each pod phase, individual containers have their own states:

#### **Waiting**
```yaml
state:
  waiting:
    reason: "ImagePullBackOff"
    message: "Back-off pulling image 'nginx:invalid-tag'"
```

#### **Running**
```yaml
state:
  running:
    startedAt: "2023-01-15T10:30:00Z"
```

#### **Terminated**
```yaml
state:
  terminated:
    exitCode: 1
    reason: "Error"
    message: "Application crashed"
    startedAt: "2023-01-15T10:30:00Z"
    finishedAt: "2023-01-15T10:35:00Z"
```

## 🏥 Health Monitoring and Probes

### Types of Health Checks

#### 1. **Liveness Probe**
- **Purpose**: Determines if container is running properly
- **Action**: Kubernetes restarts container if probe fails
- **Use Case**: Detect deadlocks, infinite loops, unresponsive applications

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-probe-pod
spec:
  containers:
  - name: app
    image: nginx:1.21
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
        httpHeaders:
        - name: Custom-Header
          value: Awesome
      initialDelaySeconds: 30
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 3
      successThreshold: 1
```

#### 2. **Readiness Probe**
- **Purpose**: Determines if container is ready to serve traffic
- **Action**: Removes pod from service endpoints if probe fails
- **Use Case**: Prevent traffic to pods that are starting up or temporarily unavailable

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: readiness-probe-pod
spec:
  containers:
  - name: app
    image: nginx:1.21
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
      timeoutSeconds: 3
      failureThreshold: 3
      successThreshold: 1
```

#### 3. **Startup Probe**
- **Purpose**: Determines if container application has started
- **Action**: Other probes are disabled until startup probe succeeds
- **Use Case**: Slow-starting containers, legacy applications

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: startup-probe-pod
spec:
  containers:
  - name: app
    image: nginx:1.21
    startupProbe:
      httpGet:
        path: /startup
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 30  # Allow 5 minutes for startup
      successThreshold: 1
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      periodSeconds: 5
```

### Probe Types

#### **HTTP Probe**
```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
    scheme: HTTP
    httpHeaders:
    - name: Authorization
      value: Bearer token123
  initialDelaySeconds: 30
  periodSeconds: 10
```

#### **TCP Probe**
```yaml
livenessProbe:
  tcpSocket:
    port: 8080
  initialDelaySeconds: 15
  periodSeconds: 20
```

#### **Command/Exec Probe**
```yaml
livenessProbe:
  exec:
    command:
    - cat
    - /tmp/healthy
  initialDelaySeconds: 5
  periodSeconds: 5
```

#### **gRPC Probe**
```yaml
livenessProbe:
  grpc:
    port: 2379
    service: my-service
  initialDelaySeconds: 10
```

### Probe Configuration Parameters

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  
  # How long to wait before performing first probe
  initialDelaySeconds: 30
  
  # How often to perform probe (seconds)
  periodSeconds: 10
  
  # How long to wait for probe response
  timeoutSeconds: 5
  
  # How many failures needed to consider probe failed
  failureThreshold: 3
  
  # How many successes needed to consider probe successful
  successThreshold: 1
  
  # Minimum consecutive successes required after failure
  # (only matters for liveness and startup probes)
```

## 🔍 Troubleshooting Commands and Techniques

### Essential Debugging Commands

#### **Pod Investigation**
```bash
# Get pod status and basic info
kubectl get pods
kubectl get pods -o wide
kubectl get pods --show-labels
kubectl get pods -o yaml pod-name

# Describe pod for detailed info and events
kubectl describe pod pod-name

# Get pod logs
kubectl logs pod-name
kubectl logs pod-name -c container-name  # Multi-container pod
kubectl logs pod-name --previous         # Previous container instance
kubectl logs pod-name --tail=50          # Last 50 lines
kubectl logs pod-name --since=1h         # Last hour
kubectl logs -f pod-name                 # Follow logs

# Execute commands in pod
kubectl exec -it pod-name -- /bin/bash
kubectl exec -it pod-name -c container-name -- /bin/sh
kubectl exec pod-name -- ps aux
kubectl exec pod-name -- netstat -tulpn
```

#### **Service and Networking Debug**
```bash
# Check services
kubectl get svc
kubectl describe svc service-name
kubectl get endpoints

# Check ingress
kubectl get ingress
kubectl describe ingress ingress-name

# Network debugging
kubectl exec -it debug-pod -- nslookup kubernetes.default
kubectl exec -it debug-pod -- curl -I http://service-name:port
kubectl exec -it debug-pod -- telnet service-name port
```

#### **Resource and Performance Debug**
```bash
# Check resource usage
kubectl top pods
kubectl top nodes
kubectl describe node node-name

# Check resource quotas and limits
kubectl describe resourcequota
kubectl get limitrange
kubectl describe limitrange
```

### Advanced Troubleshooting

#### **Events Monitoring**
```bash
# Get events sorted by time
kubectl get events --sort-by=.metadata.creationTimestamp

# Get events for specific object
kubectl get events --field-selector involvedObject.name=pod-name

# Watch events in real-time
kubectl get events --watch

# Events for specific namespace
kubectl get events -n namespace-name
```

#### **Debug Pod Creation**
```yaml
# Debug pod with useful tools
apiVersion: v1
kind: Pod
metadata:
  name: debug-pod
spec:
  containers:
  - name: debug
    image: nicolaka/netshoot  # Contains networking tools
    command: ["/bin/bash"]
    args: ["-c", "sleep 3600"]
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "NET_RAW"]
```

```bash
# Create debug pod
kubectl run debug-pod --image=busybox --rm -it --restart=Never -- /bin/sh

# Debug with specific tools
kubectl run debug-pod --image=nicolaka/netshoot --rm -it --restart=Never
```

#### **Resource Debugging**
```bash
# Check if pod can be scheduled
kubectl describe node node-name | grep -A 5 "Allocated resources"

# Check pod resource usage
kubectl exec pod-name -- cat /sys/fs/cgroup/memory/memory.usage_in_bytes
kubectl exec pod-name -- cat /proc/meminfo
kubectl exec pod-name -- top

# Check disk usage
kubectl exec pod-name -- df -h
kubectl exec pod-name -- du -sh /var/log
```

### Common Issues and Solutions

#### **1. ImagePullBackOff / ErrImagePull**

**Symptoms:**
```bash
kubectl get pods
# NAME       READY   STATUS             RESTARTS   AGE
# my-pod     0/1     ImagePullBackOff   0          5m
```

**Investigation:**
```bash
kubectl describe pod my-pod
# Look for events like:
# Failed to pull image "nginx:invalid-tag": rpc error: code = NotFound
```

**Solutions:**
- Verify image name and tag
- Check image registry accessibility
- Verify pull secrets for private registries
- Check node's ability to reach registry

#### **2. CrashLoopBackOff**

**Symptoms:**
```bash
kubectl get pods
# NAME       READY   STATUS             RESTARTS   AGE
# my-pod     0/1     CrashLoopBackOff   5          10m
```

**Investigation:**
```bash
# Check current logs
kubectl logs my-pod

# Check previous container logs
kubectl logs my-pod --previous

# Check pod events
kubectl describe pod my-pod
```

**Common Causes:**
- Application startup failures
- Liveness probe failures
- Resource limits exceeded
- Missing dependencies

#### **3. Pending Pods**

**Investigation:**
```bash
kubectl describe pod pending-pod
# Look for scheduling issues:
# 0/3 nodes are available: 1 node(s) had taint, 2 Insufficient memory
```

**Common Solutions:**
- Check resource requests vs node capacity
- Verify node selectors and taints/tolerations
- Check PVC availability for storage claims
- Verify image pull secrets

#### **4. Service Connection Issues**

**Debug Steps:**
```bash
# 1. Check if pods are running and ready
kubectl get pods -l app=myapp

# 2. Check service configuration
kubectl describe svc myapp-service

# 3. Check endpoints
kubectl get endpoints myapp-service

# 4. Test service connectivity
kubectl run test-pod --image=busybox --rm -it --restart=Never
# Inside pod:
nslookup myapp-service
wget -qO- http://myapp-service:port/health
```

#### **5. DNS Issues**

**Debug DNS:**
```bash
# Test DNS resolution
kubectl exec -it test-pod -- nslookup kubernetes.default
kubectl exec -it test-pod -- dig @10.96.0.10 kubernetes.default.svc.cluster.local

# Check CoreDNS
kubectl get pods -n kube-system -l k8s-app=kube-dns
kubectl logs -n kube-system deployment/coredns
```

### Monitoring and Observability

#### **Health Check Implementation**

**Application Health Endpoint:**
```go
// Example Go health endpoint
func healthHandler(w http.ResponseWriter, r *http.Request) {
    // Check database connectivity
    if !isDatabaseHealthy() {
        w.WriteHeader(http.StatusServiceUnavailable)
        w.Write([]byte("Database not available"))
        return
    }
    
    // Check external dependencies
    if !areExternalServicesHealthy() {
        w.WriteHeader(http.StatusServiceUnavailable)
        w.Write([]byte("External services not available"))
        return
    }
    
    w.WriteHeader(http.StatusOK)
    w.Write([]byte("OK"))
}
```

#### **Comprehensive Pod Monitoring**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: monitored-app
  labels:
    app: webapp
spec:
  containers:
  - name: webapp
    image: myapp:v1.0
    ports:
    - containerPort: 8080
      name: http
    
    # Resource monitoring
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
    
    # Health monitoring
    livenessProbe:
      httpGet:
        path: /health
        port: 8080
      initialDelaySeconds: 30
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 3
    
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
      timeoutSeconds: 3
      failureThreshold: 3
    
    startupProbe:
      httpGet:
        path: /startup
        port: 8080
      initialDelaySeconds: 10
      periodSeconds: 10
      failureThreshold: 30
    
    # Environment for debugging
    env:
    - name: LOG_LEVEL
      value: "info"
    - name: DEBUG_MODE
      value: "true"
```

### Best Practices for Monitoring

#### **1. Implement Proper Health Checks**
- Use startup probes for slow-starting applications
- Implement meaningful health endpoints
- Set appropriate timeouts and thresholds
- Test health checks during development

#### **2. Resource Monitoring**
- Set resource requests and limits
- Monitor resource usage trends
- Use resource quotas at namespace level
- Implement horizontal pod autoscaling

#### **3. Logging Strategy**
- Use structured logging (JSON)
- Include correlation IDs
- Log at appropriate levels
- Avoid logging sensitive information

#### **4. Observability**
- Implement metrics collection (Prometheus)
- Use distributed tracing
- Set up alerting for critical issues
- Create dashboards for key metrics

### Troubleshooting Checklist

**Pod Issues:**
- [ ] Check pod status and phase
- [ ] Review pod events and logs
- [ ] Verify image availability and tags
- [ ] Check resource requests vs limits
- [ ] Validate environment variables and secrets
- [ ] Test health check endpoints

**Networking Issues:**
- [ ] Verify service configuration and endpoints
- [ ] Test DNS resolution
- [ ] Check network policies
- [ ] Validate ingress configuration
- [ ] Test connectivity between pods

**Performance Issues:**
- [ ] Monitor resource usage (CPU, memory, disk)
- [ ] Check for resource throttling
- [ ] Analyze application metrics
- [ ] Review horizontal pod autoscaler status
- [ ] Check node capacity and health

**Security Issues:**
- [ ] Verify RBAC permissions
- [ ] Check pod security contexts
- [ ] Validate secret access
- [ ] Review network policy effectiveness
- [ ] Audit security configurations
