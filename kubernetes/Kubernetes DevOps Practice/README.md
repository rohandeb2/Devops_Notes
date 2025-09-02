# Kubernetes DevOps Practice Lab

[![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)
[![Helm](https://img.shields.io/badge/Helm-0F1689?style=for-the-badge&logo=Helm&logoColor=white)](https://helm.sh/)
[![NGINX](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)

A comprehensive Kubernetes DevOps practice environment showcasing container orchestration, service mesh implementation, and automated deployment strategies using Kind (Kubernetes in Docker).

## 🚀 Overview

This repository demonstrates practical Kubernetes implementations including:
- Multi-node cluster setup with Kind
- Microservices deployment and scaling
- Service mesh and ingress configuration  
- Persistent storage management
- Horizontal and Vertical Pod Autoscaling
- Helm chart management
- CI/CD pipeline integration

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Kind Cluster                         │
├─────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │   Ingress   │  │   Services  │  │    Pods     │     │
│  │  Controller │  │             │  │             │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │    HPA      │  │     VPA     │  │  ConfigMaps │     │
│  │             │  │             │  │  & Secrets  │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│  ┌─────────────┐  ┌─────────────┐                      │
│  │ Persistent  │  │    MySQL    │                      │
│  │   Storage   │  │  Database   │                      │
│  └─────────────┘  └─────────────┘                      │
└─────────────────────────────────────────────────────────┘
```

## 🛠️ Prerequisites

- Docker Engine 20.10+
- kubectl v1.25+
- Kind v0.30.0+
- Helm v3.x
- Git

## ⚡ Quick Start

### 1. Environment Setup

```bash
# Install Kind
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Verify installations
kind --version
kubectl version --client
```

### 2. Cluster Creation

```bash
# Create Kind cluster with custom configuration
kind create cluster --config cluster.yml --name tws-cluster

# Verify cluster status
kubectl cluster-info
kubectl get nodes
```

### 3. Deploy Applications

```bash
# Create namespaces
kubectl apply -f k8s_prac/namespace.yml

# Deploy NGINX application
kubectl apply -f k8s_prac/deployment.yml
kubectl apply -f k8s_prac/services.yml

# Deploy online shopping application
kubectl apply -f online_shopping_app/k8s/
```

## 📁 Project Structure

```
├── k8s_prac/
│   ├── cluster.yml              # Kind cluster configuration
│   ├── namespace.yml            # Namespace definitions
│   ├── deployment.yml           # Application deployments
│   ├── services.yml             # Service configurations
│   └── ingress.yml              # Ingress rules
├── online_shopping_app/
│   ├── Dockerfile               # Container image definition
│   └── k8s/
│       ├── deployment.yml       # App deployment manifest
│       ├── service.yml          # Service exposure
│       └── ingress.yml          # Routing configuration
├── mysql/
│   ├── namespace.yml            # Database namespace
│   ├── deployment.yml           # MySQL deployment
│   ├── secrets.yml              # Database credentials
│   ├── configMap.yml            # Configuration data
│   ├── persistent_volume.yml    # Storage volume
│   └── persistentVolumeClaim.yml # Storage claim
├── python-app/                  # Helm chart template
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
└── README.md
```

## 🔧 Configuration Files

### Kind Cluster Configuration
Custom multi-node cluster setup with port mappings for ingress:

```yaml
# cluster.yml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
```

### Application Deployment
Scalable deployment with resource management:

```yaml
# deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: online-shop-deployment
  namespace: online-shop
spec:
  replicas: 3
  selector:
    matchLabels:
      app: online-shop
  template:
    metadata:
      labels:
        app: online-shop
    spec:
      containers:
      - name: online-shop
        image: rohan700/online_shop_app:latest
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 500m
            memory: 512Mi
```

## 🔄 Scaling & Autoscaling

### Horizontal Pod Autoscaler (HPA)

```bash
# Deploy metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Create HPA
kubectl apply -f hpa.yml

# Monitor scaling
kubectl get hpa -n online-shop
```

### Vertical Pod Autoscaler (VPA)

```bash
# Install VPA (if using custom setup)
./autoscaler/vertical-pod-autoscaler/hack/vpa-up.sh

# Deploy VPA configuration
kubectl apply -f vpa.yml
```

## 🚪 Ingress & Networking

### NGINX Ingress Controller

```bash
# Deploy ingress controller
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml

# Configure port forwarding
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80:80 --address=0.0.0.0
```

### Service Exposure

```bash
# Port forward services for local access
kubectl port-forward svc/online-shop-svc -n online-shop 5173:80 --address=0.0.0.0
kubectl port-forward svc/nginx-svc -n nginx-ns 82:82 --address=0.0.0.0
```

## 💾 Persistent Storage

MySQL database with persistent volume:

```bash
# Apply storage configurations
kubectl apply -f mysql/persistent_volume.yml
kubectl apply -f mysql/persistentVolumeClaim.yml

# Deploy MySQL with persistent storage
kubectl apply -f mysql/deployment.yml
```

## ⚙️ Helm Package Management

### Installing Helm

```bash
# Download and install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

### Managing Applications

```bash
# Add repositories
helm repo add jenkins https://charts.jenkins.io
helm repo update

# Create custom chart
helm create python-app

# Deploy applications
helm install python-deployment ./python-app/
helm install jenkins-demo jenkins/jenkins --create-namespace
```

## 🔍 Monitoring & Debugging

### Cluster Monitoring

```bash
# Check cluster status
kubectl cluster-info
kubectl get nodes
kubectl top nodes

# Monitor resources
kubectl top pods --all-namespaces
kubectl get all --all-namespaces
```

### Application Debugging

```bash
# View logs
kubectl logs -f deployment/online-shop-deployment -n online-shop

# Describe resources
kubectl describe pod <pod-name> -n <namespace>

# Execute into containers
kubectl exec -it <pod-name> -n <namespace> -- bash
```

## 🚀 Deployment Commands

### Quick Deployment

```bash
# Deploy entire stack
./scripts/deploy-all.sh

# Or deploy individually
kubectl apply -f k8s_prac/namespace.yml
kubectl apply -f k8s_prac/deployment.yml
kubectl apply -f k8s_prac/services.yml
kubectl apply -f k8s_prac/ingress.yml
```

### Cleanup

```bash
# Remove applications
kubectl delete -f k8s_prac/

# Destroy cluster
kind delete cluster --name tws-cluster

# Clean Docker resources
docker system prune -f
```

## 🐳 Container Images

- **Online Shopping App**: `rohan700/online_shop_app:latest`
- **NGINX**: `nginx:latest`  
- **MySQL**: `mysql:8.0`

## 🔧 Troubleshooting

### Common Issues

1. **Port conflicts**: Check for running services on required ports
2. **Resource constraints**: Monitor cluster resource usage
3. **Image pull errors**: Verify image availability and credentials
4. **Network policies**: Ensure proper service discovery

### Useful Commands

```bash
# Check resource usage
kubectl top nodes
kubectl top pods --all-namespaces

# View events
kubectl get events --sort-by=.metadata.creationTimestamp

# Debug networking
kubectl exec -it <pod> -- nslookup <service-name>
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Rohan** - DevOps Engineer & Kubernetes Enthusiast

- 🌍 Location: Roorkee, Uttarakhand, India
- 📧 Contact: [your-email@example.com]
- 🔗 LinkedIn: [your-linkedin-profile]

## 🙏 Acknowledgments

- Kubernetes community for excellent documentation
- Kind team for the amazing local development tool
- Helm community for package management solutions
- NGINX team for ingress controller implementations

---

⭐ **Star this repository** if you find it helpful!

*Built with ❤️ using Kubernetes, Docker, and DevOps best practices*
