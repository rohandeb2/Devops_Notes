# 09 - Production Best Practices

## 🚀 Production Deployment Strategies

### Deployment Patterns

#### **1. Rolling Deployment (Default)**
Gradually replaces old version pods with new version pods.

**Characteristics:**
- Zero downtime deployment
- Gradual traffic shift
- Easy rollback capability
- Resource efficient

**Configuration:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-deployment
spec:
  replicas: 6
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1      # Max pods that can be down during update
      maxSurge: 2           # Max extra pods during update
  template:
    metadata:
      labels:
        app: web-app
        version: v2
    spec:
      containers:
      - name: web-app
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
        livenessProbe:
          httpGet:
            path: /health
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
```

**Best Practices:**
- Set appropriate `maxUnavailable` and `maxSurge` values
- Always use readiness probes
- Monitor deployment progress
- Have rollback plan ready

#### **2. Blue-Green Deployment**
Maintains two identical production environments (blue and green).

**Implementation with Services:**
```yaml
# Blue environment (current)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-blue
  labels:
    app: myapp
    version: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: blue
  template:
    metadata:
      labels:
        app: myapp
        version: blue
    spec:
      containers:
      - name: app
        image: myapp:v1.0
        ports:
        - containerPort: 8080

---
# Green environment (new)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-green
  labels:
    app: myapp
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

---
# Service pointing to active version
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: myapp
    version: blue  # Switch to 'green' for deployment
  ports:
  - port: 80
    targetPort: 8080
```

**Deployment Process:**
```bash
# 1. Deploy green environment
kubectl apply -f app-green-deployment.yaml

# 2. Test green environment
kubectl port-forward deployment/app-green 8080:8080

# 3. Switch traffic to green
kubectl patch service app-service -p '{"spec":{"selector":{"version":"green"}}}'

# 4. Verify and cleanup blue environment
kubectl delete deployment app-blue
```

#### **3. Canary Deployment**
Gradually shifts traffic from old to new version.

**Using Multiple Deployments:**
```yaml
# Stable version (90% traffic)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-stable
spec:
  replicas: 9  # 90% of traffic
  selector:
    matchLabels:
      app: myapp
      track: stable
  template:
    metadata:
      labels:
        app: myapp
        track: stable
    spec:
      containers:
      - name: app
        image: myapp:v1.0

---
# Canary version (10% traffic)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-canary
spec:
  replicas: 1  # 10% of traffic
  selector:
    matchLabels:
      app: myapp
      track: canary
  template:
    metadata:
      labels:
        app: myapp
        track: canary
    spec:
      containers:
      - name: app
        image: myapp:v2.0

---
# Service serving both versions
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: myapp  # Matches both stable and canary
  ports:
  - port: 80
    targetPort: 8080
```

**Progressive Canary Rollout:**
```bash
# Phase 1: 5% canary traffic
kubectl scale deployment app-canary --replicas=1
kubectl scale deployment app-stable --replicas=19

# Phase 2: 20% canary traffic  
kubectl scale deployment app-canary --replicas=4
kubectl scale deployment app-stable --replicas=16

# Phase 3: 50% canary traffic
kubectl scale deployment app-canary --replicas=10
kubectl scale deployment app-stable --replicas=10

# Phase 4: Complete rollout
kubectl scale deployment app-canary --replicas=20
kubectl scale deployment app-stable --replicas=0
```

#### **4. A/B Testing Deployment**
Routes traffic based on user attributes or feature flags.

```yaml
# Version A
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-version-a
spec:
  replicas: 5
  selector:
    matchLabels:
      app: myapp
      version: a
  template:
    metadata:
      labels:
        app: myapp
        version: a
    spec:
      containers:
      - name: app
        image: myapp:v1.0
        env:
        - name: FEATURE_FLAG_NEW_UI
          value: "false"

---
# Version B  
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-version-b
spec:
  replicas: 5
  selector:
    matchLabels:
      app: myapp
      version: b
  template:
    metadata:
      labels:
        app: myapp
        version: b
    spec:
      containers:
      - name: app
        image: myapp:v2.0
        env:
        - name: FEATURE_FLAG_NEW_UI
          value: "true"
```

## 🏗️ Production Architecture Patterns

### High Availability Setup

#### **Multi-Master Configuration**
```yaml
# Production cluster with multiple control plane nodes
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
metadata:
  name: prod-cluster
kubernetesVersion: v1.28.0
controlPlaneEndpoint: "prod-lb.company.com:6443"
networking:
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"
etcd:
  external:
    endpoints:
    - https://etcd1.company.com:2379
    - https://etcd2.company.com:2379
    - https://etcd3.company.com:2379
    caFile: "/etc/kubernetes/pki/etcd/ca.crt"
    certFile: "/etc/kubernetes/pki/apiserver-etcd-client.crt"
    keyFile: "/etc/kubernetes/pki/apiserver-etcd-client.key"
```

#### **Pod Disruption Budgets**
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: web-app-pdb
spec:
  minAvailable: 2  # Always keep at least 2 pods running
  selector:
    matchLabels:
      app: web-app

---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: database-pdb
spec:
  maxUnavailable: 1  # Never take down more than 1 database pod
  selector:
    matchLabels:
      app: database
```

### Resource Management

#### **Resource Quotas**
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    requests.cpu: "100"
    requests.memory: 200Gi
    limits.cpu: "200"
    limits.memory: 400Gi
    persistentvolumeclaims: "50"
    pods: "100"
    secrets: "50"
    services: "20"
    services.loadbalancers: "5"
```

#### **Limit Ranges**
```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: production-limits
  namespace: production
spec:
  limits:
  - default:
      cpu: "200m"
      memory: "256Mi"
    defaultRequest:
      cpu: "100m"
      memory: "128Mi"
    type: Container
  - max:
      cpu: "2"
      memory: "4Gi"
    min:
      cpu: "50m"
      memory: "64Mi"
    type: Container
```

#### **Horizontal Pod Autoscaling**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-app-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  minReplicas: 3
  maxReplicas: 50
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
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 60
      policies:
      - type: Percent
        value: 100
        periodSeconds: 15
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
      - type: Percent
        value: 10
        periodSeconds: 60
```

#### **Vertical Pod Autoscaling**
```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: web-app-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  updatePolicy:
    updateMode: "Auto"  # or "Initial" or "Off"
  resourcePolicy:
    containerPolicies:
    - containerName: web-app
      maxAllowed:
        cpu: 1
        memory: 2Gi
      minAllowed:
        cpu: 100m
        memory: 128Mi
```

## 🔒 Production Security

### Security Contexts
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-production-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: app
    image: myapp:v1.0
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
        add:
        - NET_BIND_SERVICE
    volumeMounts:
    - name: tmp-volume
      mountPath: /tmp
    - name: cache-volume
      mountPath: /app/cache
  volumes:
  - name: tmp-volume
    emptyDir: {}
  - name: cache-volume
    emptyDir: {}
```

### Network Policies
```yaml
# Default deny all ingress traffic
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: production
spec:
  podSelector: {}
  policyTypes:
  - Ingress

---
# Allow specific application communication
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
  # Allow from ingress controller
  - from:
    - namespaceSelector:
        matchLabels:
          name: ingress-system
    ports:
    - protocol: TCP
      port: 80
  # Allow from same namespace
  - from:
    - namespaceSelector:
        matchLabels:
          name: production
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
  # Allow HTTPS to external services
  - to: []
    ports:
    - protocol: TCP
      port: 443
```

## 📊 Production Monitoring

### Comprehensive Application Monitoring
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: production-app
  labels:
    app: production-app
    version: v1.0
spec:
  replicas: 5
  selector:
    matchLabels:
      app: production-app
  template:
    metadata:
      labels:
        app: production-app
        version: v1.0
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
        prometheus.io/path: "/metrics"
    spec:
      containers:
      - name: app
        image: production-app:v1.0
        ports:
        - containerPort: 8080
          name: http
        - containerPort: 8090
          name: metrics
        
        # Resource specifications
        resources:
          requests:
            cpu: 200m
            memory: 256Mi
          limits:
            cpu: 500m
            memory: 512Mi
        
        # Health checks
        livenessProbe:
          httpGet:
            path: /health/live
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        
        startupProbe:
          httpGet:
            path: /health/startup
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 30
        
        # Environment configuration
        env:
        - name: LOG_LEVEL
          value: "info"
        - name: METRICS_ENABLED
          value: "true"
        - name: JAEGER_AGENT_HOST
          valueFrom:
            fieldRef:
              fieldPath: status.hostIP
        
        # Configuration from ConfigMap
        envFrom:
        - configMapRef:
            name: app-config
        - secretRef:
            name: app-secrets
        
        # Volume mounts
        volumeMounts:
        - name: config-volume
          mountPath: /etc/config
          readOnly: true
        - name: logs-volume
          mountPath: /var/log/app
      
      volumes:
      - name: config-volume
        configMap:
          name: app-config
      - name: logs-volume
        emptyDir: {}
```

### Service Monitoring
```yaml
apiVersion: v1
kind: Service
metadata:
  name: production-app-service
  labels:
    app: production-app
  annotations:
    prometheus.io/scrape: "true"
    prometheus.io/port: "8080"
spec:
  selector:
    app: production-app
  ports:
  - name: http
    port: 80
    targetPort: 8080
    protocol: TCP
  - name: metrics
    port: 8090
    targetPort: 8090
    protocol: TCP
  type: ClusterIP

---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: production-app-monitor
spec:
  selector:
    matchLabels:
      app: production-app
  endpoints:
  - port: metrics
    interval: 30s
    path: /metrics
```

## 🚨 Disaster Recovery and Backup

### Backup Strategies

#### **etcd Backup**
```bash
#!/bin/bash
# etcd backup script
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-snapshot-$(date +%Y%m%d-%H%M%S).db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key

# Verify backup
ETCDCTL_API=3 etcdctl --write-out=table snapshot status /backup/etcd-snapshot-latest.db
```

#### **Persistent Volume Backups**
```yaml
# Velero backup schedule
apiVersion: velero.io/v1
kind: Schedule
metadata:
  name: production-backup
  namespace: velero
spec:
  schedule: "0 2 * * *"  # Daily at 2 AM
  template:
    includedNamespaces:
    - production
    excludedResources:
    - events
    - events.events.k8s.io
    ttl: 720h0m0s  # 30 days retention
    storageLocation: default
    volumeSnapshotLocations:
    - default
```

### Disaster Recovery Procedures

#### **Cluster Recovery Runbook**
```yaml
# disaster-recovery-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: disaster-recovery-runbook
  namespace: kube-system
data:
  etcd-restore.sh: |
    #!/bin/bash
    # Stop kube-apiserver
    sudo systemctl stop kube-apiserver
    
    # Restore etcd from snapshot
    sudo ETCDCTL_API=3 etcdctl snapshot restore /backup/etcd-snapshot.db \
      --name=master1 \
      --initial-cluster=master1=https://10.0.0.10:2380 \
      --initial-advertise-peer-urls=https://10.0.0.10:2380 \
      --data-dir=/var/lib/etcd
    
    # Start etcd and kube-apiserver
    sudo systemctl start etcd
    sudo systemctl start kube-apiserver
  
  application-recovery.sh: |
    #!/bin/bash
    # Restore application data from backup
    velero restore create production-restore-$(date +%Y%m%d-%H%M%S) \
      --from-backup production-backup-20240115-020000
    
    # Verify restoration
    kubectl get pods -n production
    kubectl get pvc -n production
```

## 🔧 Production Operations

### Maintenance Windows

#### **Node Maintenance**
```bash
#!/bin/bash
# Node maintenance script

NODE_NAME=$1

# Cordon node (prevent new pods)
kubectl cordon $NODE_NAME

# Drain node (move existing pods)
kubectl drain $NODE_NAME \
  --ignore-daemonsets \
  --delete-emptydir-data \
  --force \
  --grace-period=300

# Perform maintenance
echo "Node $NODE_NAME is ready for maintenance"
echo "Perform your maintenance tasks now..."
read -p "Press enter when maintenance is complete..."

# Uncordon node (allow scheduling)
kubectl uncordon $NODE_NAME

echo "Node $NODE_NAME is back in service"
```

#### **Rolling Cluster Updates**
```yaml
# cluster-update-job.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: cluster-update
spec:
  template:
    spec:
      containers:
      - name: updater
        image: kubectl:latest
        command:
        - /bin/bash
        - -c
        - |
          # Update deployments one by one
          for deployment in $(kubectl get deployments -o name); do
            echo "Updating $deployment"
            kubectl patch $deployment -p '{"spec":{"template":{"metadata":{"annotations":{"updatedAt":"'$(date +%s)'"}}}}}'
            kubectl rollout status $deployment --timeout=600s
            sleep 30
          done
      restartPolicy: Never
  backoffLimit: 3
```

### Performance Optimization

#### **Resource Optimization**
```yaml
# Production deployment with optimized resources
apiVersion: apps/v1
kind: Deployment
metadata:
  name: optimized-app
spec:
  replicas: 10
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 2
      maxSurge: 3
  template:
    spec:
      containers:
      - name: app
        image: optimized-app:v1.0
        resources:
          requests:
            cpu: 100m      # Based on profiling
            memory: 128Mi  # Based on actual usage + buffer
          limits:
            cpu: 300m      # Allow bursting for peak loads
            memory: 256Mi  # Prevent OOM kills
        
        # CPU and memory optimization
        env:
        - name: GOMAXPROCS
          valueFrom:
            resourceFieldRef:
              resource: limits.cpu
        - name: GOMEMLIMIT
          valueFrom:
            resourceFieldRef:
              resource: limits.memory
      
      # Node placement optimization
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - optimized-app
              topologyKey: kubernetes.io/hostname
      
      # Topology spread constraints
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: topology.kubernetes.io/zone
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: optimized-app
```

## 📋 Production Checklist

### Pre-Production Deployment

**Infrastructure:**
- [ ] Multi-master setup configured
- [ ] etcd cluster properly configured and backed up
- [ ] Node redundancy across availability zones
- [ ] Load balancer configured for API server
- [ ] Network policies defined and tested
- [ ] Storage classes and persistent volumes ready
- [ ] Monitoring and logging systems deployed

**Security:**
- [ ] RBAC policies implemented and tested
- [ ] Pod security policies/standards configured
- [ ] Secrets management strategy implemented
- [ ] Network segmentation in place
- [ ] Image security scanning integrated
- [ ] Regular security audits scheduled

**Application:**
- [ ] Health checks implemented (liveness, readiness, startup)
- [ ] Resource requests and limits defined
- [ ] Pod disruption budgets configured
- [ ] Horizontal pod autoscaling set up
- [ ] Deployment strategy defined and tested
- [ ] Configuration externalized (ConfigMaps/Secrets)
- [ ] Logging structured and centralized

**Operational:**
- [ ] Backup and disaster recovery procedures documented
- [ ] Monitoring and alerting configured
- [ ] Runbooks and troubleshooting guides created
- [ ] Performance baselines established
- [ ] Capacity planning completed
- [ ] Change management process defined

### Post-Production Monitoring

**Daily Checks:**
- [ ] Cluster health status
- [ ] Node resource utilization
- [ ] Pod failure rates
- [ ] Application response times
- [ ] Error rates and logs
- [ ] Backup completion status

**Weekly Reviews:**
- [ ] Resource usage trends
- [ ] Capacity planning updates
- [ ] Security vulnerability scans
- [ ] Performance optimization opportunities
- [ ] Incident post-mortems
- [ ] Documentation updates

**Monthly Assessments:**
- [ ] Disaster recovery testing
- [ ] Security policy reviews
- [ ] Cost optimization analysis
- [ ] Technology stack updates
- [ ] Team training and knowledge sharing
- [ ] Process improvement initiatives
