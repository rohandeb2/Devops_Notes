# 01 - Kubernetes Fundamentals 🏗️

*Understanding the core concepts and architecture of Kubernetes*

---

## Table of Contents
- [What is Kubernetes?](#what-is-kubernetes)
- [History and Evolution](#history-and-evolution)
- [Key Features](#key-features)
- [Kubernetes Architecture](#kubernetes-architecture)
- [Control Plane Components](#control-plane-components)
- [Worker Node Components](#worker-node-components)
- [Installation and Setup](#installation-and-setup)
- [Basic kubectl Commands](#basic-kubectl-commands)
- [Understanding YAML Manifests](#understanding-yaml-manifests)
- [Practice Exercises](#practice-exercises)

---

## What is Kubernetes?

**Kubernetes (K8s)** is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

### Core Definition
> Kubernetes is a container management tool that automates container deployment, scaling & load balancing. It schedules, runs, and manages isolated containers running on virtual/physical/cloud machines.

### Why "K8s"?
The name "K8s" comes from the 8 letters between 'K' and 's' in "Kubernetes".

### Key Benefits
- **Orchestration**: Clustering of containers across different networks
- **Automation**: Reduces manual intervention in deployment processes
- **Scalability**: Handles growing workloads efficiently
- **Reliability**: Ensures high availability and fault tolerance
- **Portability**: Works across different environments (cloud, on-premise, hybrid)

---

## History and Evolution

### Timeline

| Year | Milestone |
|------|-----------|
| **2003-2004** | Google starts developing **Borg** internally |
| **2013** | Google introduces **Omega** (Borg's successor) |
| **2014** | Google open-sources **Kubernetes** (written in Go) |
| **2015** | Kubernetes v1.0 released, donated to **CNCF** |
| **2016** | Major enterprise adoption begins |
| **2017** | All major cloud providers offer managed K8s |
| **2018** | CNCF graduates Kubernetes |
| **Present** | De facto standard for container orchestration |

### Google's Internal Systems Evolution
```
Borg (2004) → Omega (2013) → Kubernetes (2014)
```

**Key Lessons from Borg/Omega:**
- Container orchestration at scale
- Declarative configuration
- Desired state management
- Resource scheduling algorithms

---

## Key Features

### 1. **Orchestration**
- Clusters containers across multiple nodes
- Manages complex multi-container applications
- Handles inter-container communication

### 2. **Auto-scaling**
- **Horizontal Pod Autoscaling (HPA)**: Scale pods based on CPU/memory
- **Vertical Pod Autoscaling (VPA)**: Adjust resource requests/limits
- **Cluster Autoscaling**: Add/remove nodes based on demand

### 3. **Auto-healing**
- Restarts failed containers
- Replaces unresponsive pods
- Reschedules pods when nodes fail
- Health checks and liveness probes

### 4. **Load Balancing**
- Distributes traffic across healthy pods
- Multiple load balancing algorithms
- Integration with external load balancers

### 5. **Platform Independence**
- Runs on cloud providers (AWS, GCP, Azure)
- Works on virtual machines
- Supports physical servers
- Hybrid and multi-cloud deployments

### 6. **Fault Tolerance**
- Node failure resilience
- Pod failure recovery
- Data persistence across failures
- Geographic distribution support

### 7. **Rollback Capabilities**
- Version control for deployments
- Easy rollback to previous versions
- Blue-green and canary deployments

### 8. **Health Monitoring**
- Container health checks
- Application-level monitoring
- Resource usage tracking
- Performance metrics collection

### 9. **Batch Execution**
- One-time jobs
- Scheduled cron jobs
- Parallel job execution
- Job completion tracking

---

## Kubernetes Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Kubernetes Cluster                        │
├─────────────────────┬───────────────────────────────────────┤
│    Control Plane    │           Worker Nodes                │
│   (Master Nodes)    │                                       │
├─────────────────────┼───────────────┬───────────────────────┤
│                     │    Node 1     │      Node 2           │
│  • API Server       │               │                       │
│  • etcd             │  • kubelet    │    • kubelet          │
│  • Scheduler        │  • kube-proxy │    • kube-proxy       │
│  • Controller Mgr   │  • Container  │    • Container        │
│                     │    Runtime    │      Runtime          │
└─────────────────────┴───────────────┴───────────────────────┘
```

### Core Concepts

#### **Cluster**
- A set of nodes running Kubernetes
- Contains at least one control plane and worker nodes
- Provides the runtime environment for applications

#### **Master vs Worker Architecture**
- **Control Plane (Master)**: Manages the cluster
- **Worker Nodes**: Run application workloads
- **High Availability**: Multiple masters for production

### Working Principle

```yaml
# How Kubernetes Works
1. Create Manifest (.yml) files
   ↓
2. Apply to Cluster (kubectl apply)
   ↓
3. API Server validates & stores in etcd
   ↓
4. Scheduler assigns pods to nodes
   ↓
5. kubelet creates containers
   ↓
6. Monitor and maintain desired state
```

---

## Control Plane Components

### 1. **API Server (kube-apiserver)**

**Role**: Front-end for the Kubernetes control plane

**Responsibilities**:
- Handles all REST operations
- Validates and configures API objects
- Serves as communication hub
- Authentication and authorization
- Admission control

**Key Features**:
- Auto-scales based on load
- RESTful API interface
- Handles all cluster communications
- Stateless component

**Example Interaction**:
```bash
# When you run this command:
kubectl apply -f deployment.yaml

# The flow is:
kubectl → API Server → Validation → etcd storage
```

### 2. **etcd**

**Role**: Distributed key-value store for cluster data

**Characteristics**:
- **Consistent**: Strong consistency guarantees
- **Highly Available**: Distributed across multiple nodes
- **Secure**: Automatic TLS with client certificates
- **Fast**: Benchmarked at 10,000 writes/second

**What it stores**:
- Cluster configuration
- Service discovery information
- Secrets and ConfigMaps
- Node and pod information

**Architecture**:
```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   etcd-1    │◄──►│   etcd-2    │◄──►│   etcd-3    │
│  (Leader)   │    │ (Follower)  │    │ (Follower)  │
└─────────────┘    └─────────────┘    └─────────────┘
```

**Production Best Practices**:
- Run odd number of nodes (3, 5, 7)
- Use SSD storage
- Regular backups
- Monitor performance metrics

### 3. **Scheduler (kube-scheduler)**

**Role**: Decides which node should run which pods

**Scheduling Process**:
1. **Filtering**: Find nodes that can run the pod
2. **Scoring**: Rank suitable nodes
3. **Selection**: Choose the best node
4. **Binding**: Assign pod to selected node

**Scheduling Factors**:
- Resource requirements (CPU, memory)
- Hardware constraints
- Affinity/anti-affinity rules
- Data locality
- Node conditions and taints

**Example Scheduling Decision**:
```yaml
# Pod requesting specific resources
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: app
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 500m
        memory: 256Mi
  nodeSelector:
    disktype: ssd
```

### 4. **Controller Manager**

**Role**: Runs controller processes that regulate cluster state

**Two Types**:
- **kube-controller-manager**: For non-cloud environments
- **cloud-controller-manager**: For cloud environments

**Key Controllers**:

#### **Node Controller**
- Monitors node health
- Updates node status
- Evicts pods from unhealthy nodes

#### **Replication Controller**
- Ensures desired number of pod replicas
- Creates/deletes pods as needed

#### **Endpoints Controller**
- Populates service endpoints
- Manages endpoint objects

#### **Service Account & Token Controllers**
- Creates default service accounts
- Manages API access tokens

**Cloud-Specific Controllers**:
- **Route Controller**: Sets up network routes
- **Service Controller**: Creates cloud load balancers
- **Volume Controller**: Manages cloud storage volumes

---

## Worker Node Components

### 1. **kubelet**

**Role**: Primary node agent that manages pods and containers

**Key Responsibilities**:
- Communicates with API server
- Manages pod lifecycle
- Monitors container health
- Reports node and pod status
- Executes liveness and readiness probes

**Configuration**:
- Listens on port **10255** (read-only) and **10250** (full API)
- Pulls pod specifications from API server
- Uses container runtime to manage containers

**Kubelet Workflow**:
```
API Server → kubelet → Container Runtime → Container Creation
     ↑                     ↓
  Status Reports    ←    Health Checks
```

### 2. **Container Runtime**

**Role**: Software responsible for running containers

**Popular Runtimes**:
- **containerd**: CNCF graduated project
- **CRI-O**: OCI-compliant runtime
- **Docker**: Traditional choice (deprecated in K8s 1.24+)

**Runtime Responsibilities**:
- Pull container images
- Create and start containers
- Stop and delete containers
- Manage container lifecycles
- Provide container logs

**Container Runtime Interface (CRI)**:
```
kubelet ←→ CRI ←→ Container Runtime ←→ Containers
```

### 3. **kube-proxy**

**Role**: Network proxy maintaining network rules for services

**Key Functions**:
- Assigns IP addresses to pods
- Implements service abstraction
- Load balances traffic to pods
- Maintains network rules (iptables/IPVS)

**Proxy Modes**:

#### **iptables Mode** (default)
- Uses Linux iptables rules
- Random load balancing
- Lower overhead

#### **IPVS Mode**
- Uses Linux IP Virtual Server
- More load balancing algorithms
- Better performance for large clusters

**Network Flow**:
```
External Traffic → Service → kube-proxy → Pod IP:Port
```

---

## Installation and Setup

### Prerequisites

**System Requirements**:
- Linux-based OS (Ubuntu 18.04+, CentOS 7+, RHEL 7+)
- 2+ CPU cores
- 4GB+ RAM
- Network connectivity between nodes
- Swap disabled

### Installation Options

#### 1. **Production Clusters**

##### **kubeadm** (Recommended for on-premise)
```bash
# Install Docker/containerd
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker

# Install kubeadm, kubelet, kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize master node
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Configure kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install network plugin (Calico)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

##### **Managed Services** (Recommended for cloud)
```bash
# AWS EKS
eksctl create cluster --name my-cluster --region us-west-2

# Google GKE
gcloud container clusters create my-cluster --zone=us-central1-a

# Azure AKS
az aks create --resource-group myResourceGroup --name myAKSCluster
```

#### 2. **Development/Learning**

##### **Minikube**
```bash
# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube /usr/local/bin/

# Start cluster
minikube start --driver=docker --cpus=4 --memory=8g

# Enable addons
minikube addons enable dashboard
minikube addons enable ingress
```

##### **Kind (Kubernetes in Docker)**
```bash
# Install Kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create cluster
kind create cluster --config kind-config.yaml
```

**kind-config.yaml**:
```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
```

### Verify Installation

```bash
# Check cluster info
kubectl cluster-info

# Check nodes
kubectl get nodes

# Check system pods
kubectl get pods -n kube-system

# Check component status
kubectl get componentstatuses
```

---

## Basic kubectl Commands

### Cluster Information
```bash
# Cluster details
kubectl cluster-info
kubectl cluster-info dump

# Node information
kubectl get nodes
kubectl describe node <node-name>
kubectl top nodes  # Requires metrics-server
```

### Resource Management
```bash
# Get resources
kubectl get pods
kubectl get pods -A  # All namespaces
kubectl get pods -o wide  # Additional info
kubectl get pods -l app=nginx  # Label selector

# Describe resources
kubectl describe pod <pod-name>
kubectl describe svc <service-name>

# Resource creation
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort

# Apply manifests
kubectl apply -f manifest.yaml
kubectl apply -f ./manifests/  # Directory

# Delete resources
kubectl delete pod <pod-name>
kubectl delete -f manifest.yaml
```

### Debugging and Logs
```bash
# Logs
kubectl logs <pod-name>
kubectl logs <pod-name> -f  # Follow logs
kubectl logs <pod-name> -c <container-name>  # Multi-container pod

# Execute commands
kubectl exec <pod-name> -- ls /
kubectl exec -it <pod-name> -- /bin/bash

# Port forwarding
kubectl port-forward pod/<pod-name> 8080:80
kubectl port-forward svc/<service-name> 8080:80
```

### Configuration and Context
```bash
# Current context
kubectl config current-context
kubectl config get-contexts

# Switch context
kubectl config use-context <context-name>

# Set namespace
kubectl config set-context --current --namespace=<namespace>
```

---

## Understanding YAML Manifests

### Basic Structure

Every Kubernetes manifest has four required fields:

```yaml
apiVersion: v1              # API version
kind: Pod                   # Resource type
metadata:                   # Resource metadata
  name: my-pod
  labels:
    app: web
spec:                      # Resource specification
  containers:
  - name: web-container
    image: nginx:1.21
```

### Complete Pod Example

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
  namespace: default
  labels:
    app: web
    environment: production
    version: "1.0"
  annotations:
    description: "Web server pod"
    createdBy: "DevOps Team"
spec:
  containers:
  - name: nginx-container
    image: nginx:1.21-alpine
    ports:
    - containerPort: 80
      name: http
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 500m
        memory: 256Mi
    env:
    - name: ENV_VAR
      value: "production"
    volumeMounts:
    - name: web-content
      mountPath: /usr/share/nginx/html
  volumes:
  - name: web-content
    emptyDir: {}
  restartPolicy: Always
  nodeSelector:
    disktype: ssd
```

### Manifest Validation

```bash
# Validate syntax without applying
kubectl apply --dry-run=client -f manifest.yaml

# Validate against server
kubectl apply --dry-run=server -f manifest.yaml

# Explain resource fields
kubectl explain pod
kubectl explain pod.spec.containers
```

---

## Practice Exercises

### Exercise 1: Cluster Exploration
```bash
# 1. Check cluster information
kubectl cluster-info

# 2. List all nodes with details
kubectl get nodes -o wide

# 3. Check system pods
kubectl get pods -n kube-system

# 4. Describe a system pod
kubectl describe pod -n kube-system <pod-name>
```

### Exercise 2: First Pod Deployment
```yaml
# Create file: my-first-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-first-pod
  labels:
    app: learning
spec:
  containers:
  - name: nginx
    image: nginx:1.21
    ports:
    - containerPort: 80
```

```bash
# Deploy the pod
kubectl apply -f my-first-pod.yaml

# Check pod status
kubectl get pods

# Get detailed information
kubectl describe pod my-first-pod

# Check pod logs
kubectl logs my-first-pod

# Execute command in pod
kubectl exec my-first-pod -- nginx -v

# Clean up
kubectl delete -f my-first-pod.yaml
```

### Exercise 3: Multi-Container Pod
```yaml
# Create file: multi-container-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
  - name: web-server
    image: nginx:1.21
    ports:
    - containerPort: 80
  - name: log-agent
    image: busybox
    command: ['sh', '-c', 'while true; do echo "Log entry: $(date)"; sleep 30; done']
```

```bash
# Deploy and explore
kubectl apply -f multi-container-pod.yaml
kubectl get pods
kubectl logs multi-container-pod -c web-server
kubectl logs multi-container-pod -c log-agent
kubectl exec -it multi-container-pod -c web-server -- /bin/bash
```

### Exercise 4: Resource Management
```yaml
# Create file: resource-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
spec:
  containers:
  - name: app
    image: nginx:1.21
    resources:
      requests:
        cpu: 100m
        memory: 64Mi
      limits:
        cpu: 200m
        memory: 128Mi
```

```bash
# Deploy and monitor
kubectl apply -f resource-pod.yaml
kubectl top pod resource-pod  # Requires metrics-server
kubectl describe pod resource-pod
```

---

## Key Takeaways

### Architecture Understanding ✅
- Kubernetes follows a master-worker architecture
- Control plane manages cluster state
- Worker nodes run application workloads
- All communication goes through the API server

### Core Components ✅
- **API Server**: Central communication hub
- **etcd**: Distributed data store
- **Scheduler**: Pod placement decisions
- **Controller Manager**: Maintains desired state
- **kubelet**: Node agent
- **kube-proxy**: Network proxy

### Manifest Structure ✅
- Every resource has apiVersion, kind, metadata, spec
- YAML is the preferred format
- Labels and selectors enable resource grouping
- Namespaces provide logical separation

### kubectl Mastery ✅
- Essential tool for cluster interaction
- Supports CRUD operations on all resources
- Provides debugging and troubleshooting capabilities
- Configuration management through contexts

---

## Next Steps

Now that you understand Kubernetes fundamentals, proceed to:
- **[02-pods-and-workloads.md](./02-pods-and-workloads.md)**: Learn about Pods, Deployments, and ReplicaSets
- Practice the exercises above
- Explore the Kubernetes dashboard (if available)
- Set up your preferred development environment

---

## Common Troubleshooting

### Pod Not Starting
```bash
# Check pod events
kubectl describe pod <pod-name>

# Common issues:
# - Image pull errors
# - Resource constraints
# - Node selection issues
# - Configuration errors
```

### Node Issues
```bash
# Check node status
kubectl get nodes
kubectl describe node <node-name>

# Common issues:
# - Disk pressure
# - Memory pressure
# - Network unavailable
# - Ready condition false
```

---

**Next**: [02 - Pods and Workloads →](./02-pods-and-workloads.md)
