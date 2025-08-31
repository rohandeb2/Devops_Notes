# 🐳 Complete Docker Guide for DevOps Engineers

*From Beginner to 3+ Years Experience Level*

---

## Table of Contents

1. [Introduction to Docker](#introduction-to-docker)
2. [Docker Architecture & Components](#docker-architecture--components)
3. [Installation and Setup](#installation-and-setup)
4. [Docker Images](#docker-images)
5. [Docker Containers](#docker-containers)
6. [Dockerfile Best Practices](#dockerfile-best-practices)
7. [Docker Networking](#docker-networking)
8. [Docker Volumes & Data Management](#docker-volumes--data-management)
9. [Docker Compose](#docker-compose)
10. [Docker Registry & Hub](#docker-registry--hub)
11. [Container Orchestration Basics](#container-orchestration-basics)
12. [Security Best Practices](#security-best-practices)
13. [Monitoring & Logging](#monitoring--logging)
14. [CI/CD Integration](#cicd-integration)
15. [Troubleshooting & Debugging](#troubleshooting--debugging)
16. [Production Considerations](#production-considerations)
17. [Interview Questions](#interview-questions)
18. [Hands-on Labs](#hands-on-labs)

---

## Introduction to Docker

### What is Docker?
Docker is a platform that enables developers to package applications and their dependencies into lightweight, portable containers. It solves the "it works on my machine" problem by ensuring consistency across different environments.

### Why Docker?
- **Portability**: Run anywhere - development, testing, production
- **Scalability**: Easy horizontal scaling
- **Resource Efficiency**: Lighter than VMs
- **Consistency**: Same environment across all stages
- **Speed**: Fast startup and deployment
- **Microservices**: Perfect for microservice architectures

### Docker vs Virtual Machines

| Aspect | Docker Containers | Virtual Machines |
|--------|------------------|------------------|
| Resource Usage | Lightweight | Heavy |
| Boot Time | Seconds | Minutes |
| Isolation | Process-level | Hardware-level |
| OS | Shares host OS | Separate OS |
| Portability | High | Medium |
| Performance | Native | Overhead |

---

## Docker Architecture & Components

### Docker Engine
The core of Docker consisting of:
- **Docker Daemon (dockerd)**: Background service managing containers
- **Docker CLI**: Command-line interface
- **REST API**: Interface between CLI and daemon

### Key Components
- **Images**: Read-only templates for containers
- **Containers**: Running instances of images
- **Registry**: Storage for Docker images
- **Networks**: Communication between containers
- **Volumes**: Persistent data storage

### Docker Architecture Diagram
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Docker CLI    │    │  Docker Client  │    │   REST API      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │  Docker Daemon  │
                    └─────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Images    │    │ Containers  │    │  Networks   │
└─────────────┘    └─────────────┘    └─────────────┘
```

---

## Installation and Setup

### Linux (Ubuntu/CentOS)
```bash
# Ubuntu
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# CentOS
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
```

### Windows/macOS
- Download Docker Desktop from official website
- Follow installation wizard
- Enable WSL2 integration (Windows)

### Post-Installation Verification
```bash
docker --version
docker run hello-world
docker info
```

### Docker Daemon Configuration
```bash
# /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2"
}
```

---

## Docker Images

### Understanding Images
Images are layered, read-only templates used to create containers. Each layer represents a change from the previous layer.

### Basic Image Commands
```bash
# List images
docker images
docker image ls

# Pull image from registry
docker pull nginx:latest
docker pull ubuntu:20.04

# Remove images
docker rmi image_name:tag
docker image rm image_id

# Inspect image
docker inspect nginx:latest

# Image history
docker history nginx:latest

# Search images
docker search python
```

### Image Layers
```bash
# View layers
docker history nginx:alpine

# Inspect layers
docker inspect nginx:alpine | jq '.[0].RootFS.Layers'
```

### Building Custom Images
```bash
# Build from Dockerfile
docker build -t myapp:v1.0 .
docker build -t myapp:v1.0 -f Dockerfile.prod .

# Build with build arguments
docker build --build-arg VERSION=1.0 -t myapp .

# Multi-stage builds
docker build --target production -t myapp:prod .
```

### Image Management Best Practices
- Use specific tags, avoid `latest`
- Implement multi-stage builds
- Minimize layer count
- Use `.dockerignore`
- Regular cleanup with `docker system prune`

---

## Docker Containers

### Container Lifecycle
1. **Created**: Container created but not started
2. **Running**: Container is executing
3. **Paused**: Container processes are paused
4. **Stopped**: Container has stopped
5. **Deleted**: Container is removed

### Basic Container Commands
```bash
# Run containers
docker run nginx
docker run -d nginx                    # Detached mode
docker run -it ubuntu bash            # Interactive mode
docker run --name web nginx           # Named container
docker run -p 8080:80 nginx          # Port mapping
docker run -v /host:/container nginx  # Volume mounting

# List containers
docker ps                             # Running containers
docker ps -a                         # All containers

# Container management
docker start container_name
docker stop container_name
docker restart container_name
docker pause container_name
docker unpause container_name

# Execute commands in running container
docker exec -it container_name bash
docker exec container_name ls -la

# View container logs
docker logs container_name
docker logs -f container_name         # Follow logs
docker logs --since 30m container_name

# Copy files
docker cp file.txt container_name:/path/
docker cp container_name:/path/file.txt ./

# Container inspection
docker inspect container_name
docker stats container_name
```

### Advanced Container Operations
```bash
# Run with resource limits
docker run -d --memory="1g" --cpus="1.5" nginx

# Run with environment variables
docker run -e NODE_ENV=production -e PORT=3000 node-app

# Run with custom networks
docker run --network my-network nginx

# Run with health checks
docker run --health-cmd="curl -f http://localhost || exit 1" nginx
```

---

## Dockerfile Best Practices

### Dockerfile Structure
```dockerfile
# Use specific base image
FROM node:16-alpine

# Set metadata
LABEL maintainer="devops@company.com"
LABEL version="1.0"

# Set working directory
WORKDIR /app

# Copy dependency files first (for better caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy application code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

# Change ownership
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start application
CMD ["npm", "start"]
```

### Multi-Stage Dockerfile Example
```dockerfile
# Build stage
FROM node:16-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Production stage
FROM node:16-alpine AS production

WORKDIR /app

# Copy built application
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./

# Non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

USER nextjs

EXPOSE 3000

CMD ["npm", "start"]
```

### Dockerfile Optimization Tips
1. **Order matters**: Place frequently changing instructions at the end
2. **Minimize layers**: Combine RUN commands with `&&`
3. **Use .dockerignore**: Exclude unnecessary files
4. **Multi-stage builds**: Reduce final image size
5. **Specific base images**: Avoid generic images
6. **Security**: Run as non-root user

### .dockerignore Example
```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.sass-cache
```

---

## Docker Networking

### Network Types
1. **Bridge**: Default network for containers
2. **Host**: Container uses host networking
3. **None**: No networking
4. **Overlay**: Multi-host networking
5. **Macvlan**: Assign MAC address to container

### Network Commands
```bash
# List networks
docker network ls

# Create networks
docker network create my-network
docker network create --driver bridge my-bridge
docker network create --subnet=172.20.0.0/16 my-subnet

# Inspect network
docker network inspect my-network

# Connect/disconnect containers
docker network connect my-network container_name
docker network disconnect my-network container_name

# Remove network
docker network rm my-network

# Network cleanup
docker network prune
```

### Container Communication
```bash
# Run containers on same network
docker network create app-network

docker run -d --name database \
  --network app-network \
  postgres:13

docker run -d --name web \
  --network app-network \
  -p 8080:80 \
  nginx
```

### Network Configuration Examples
```bash
# Bridge network with custom subnet
docker network create --driver bridge \
  --subnet=172.20.0.0/16 \
  --ip-range=172.20.240.0/20 \
  --gateway=172.20.0.1 \
  my-bridge-network

# Host network
docker run --network host nginx

# Container networking
docker run --network container:web nginx
```

---

## Docker Volumes & Data Management

### Volume Types
1. **Named Volumes**: Managed by Docker
2. **Bind Mounts**: Host filesystem paths
3. **tmpfs Mounts**: In-memory storage

### Volume Commands
```bash
# Create volumes
docker volume create my-volume
docker volume create --driver local my-local-volume

# List volumes
docker volume ls

# Inspect volume
docker volume inspect my-volume

# Remove volumes
docker volume rm my-volume
docker volume prune                    # Remove unused volumes
```

### Using Volumes
```bash
# Named volume
docker run -v my-volume:/data postgres

# Bind mount
docker run -v /host/path:/container/path nginx
docker run -v $(pwd):/app node:alpine

# tmpfs mount
docker run --tmpfs /tmp nginx

# Read-only volumes
docker run -v my-volume:/data:ro nginx
```

### Volume Best Practices
```bash
# Backup volume
docker run --rm -v my-volume:/data -v $(pwd):/backup \
  ubuntu tar czf /backup/backup.tar.gz /data

# Restore volume
docker run --rm -v my-volume:/data -v $(pwd):/backup \
  ubuntu tar xzf /backup/backup.tar.gz -C /

# Volume with specific user
docker run -v my-volume:/data \
  --user $(id -u):$(id -g) \
  ubuntu
```

---

## Docker Compose

### Introduction
Docker Compose is a tool for defining and running multi-container Docker applications using YAML files.

### Basic docker-compose.yml
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/code
    environment:
      - DEBUG=1
    depends_on:
      - db

  db:
    image: postgres:13
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

### Advanced Compose Configuration
```yaml
version: '3.8'

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.prod
      target: production
    ports:
      - "80:80"
    environment:
      - NODE_ENV=production
    networks:
      - frontend
      - backend
    deploy:
      replicas: 3
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

  redis:
    image: redis:alpine
    networks:
      - backend
    volumes:
      - redis_data:/data

  nginx:
    image: nginx:alpine
    ports:
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    networks:
      - frontend
    depends_on:
      - web

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

volumes:
  redis_data:

secrets:
  db_password:
    file: ./db_password.txt
```

### Compose Commands
```bash
# Start services
docker-compose up
docker-compose up -d                   # Detached mode
docker-compose up --scale web=3        # Scale service

# Stop services
docker-compose stop
docker-compose down                    # Stop and remove
docker-compose down -v                 # Remove volumes too

# View services
docker-compose ps
docker-compose logs
docker-compose logs -f web             # Follow logs

# Execute commands
docker-compose exec web bash
docker-compose run web python manage.py migrate

# Build services
docker-compose build
docker-compose build --no-cache web
```

### Environment Variables in Compose
```yaml
# .env file
POSTGRES_DB=myapp
POSTGRES_USER=user
POSTGRES_PASSWORD=secret
WEB_PORT=8000

# docker-compose.yml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "${WEB_PORT}:80"
  
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
```

---

## Docker Registry & Hub

### Docker Hub
```bash
# Login to Docker Hub
docker login

# Tag image for Hub
docker tag myapp:latest username/myapp:v1.0

# Push to Hub
docker push username/myapp:v1.0

# Pull from Hub
docker pull username/myapp:v1.0

# Search on Hub
docker search python
```

### Private Registry
```bash
# Run local registry
docker run -d -p 5000:5000 --name registry registry:2

# Tag for private registry
docker tag myapp:latest localhost:5000/myapp:v1.0

# Push to private registry
docker push localhost:5000/myapp:v1.0

# Pull from private registry
docker pull localhost:5000/myapp:v1.0
```

### Registry Authentication
```yaml
# docker-compose for private registry with auth
version: '3.8'
services:
  registry:
    image: registry:2
    ports:
      - "5000:5000"
    environment:
      REGISTRY_AUTH: htpasswd
      REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
      REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
      REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY: /data
    volumes:
      - ./auth:/auth
      - ./data:/data
```

---

## Container Orchestration Basics

### Docker Swarm Mode
```bash
# Initialize swarm
docker swarm init

# Join swarm as worker
docker swarm join --token TOKEN MANAGER_IP:2377

# Deploy stack
docker stack deploy -c docker-compose.yml myapp

# List services
docker service ls

# Scale service
docker service scale myapp_web=5

# Update service
docker service update --image nginx:alpine myapp_web
```

### Kubernetes Integration
```yaml
# Simple Kubernetes deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web
        image: nginx:alpine
        ports:
        - containerPort: 80
```

---

## Security Best Practices

### Image Security
```bash
# Scan images for vulnerabilities
docker scan myapp:latest

# Use minimal base images
FROM alpine:3.14
FROM scratch  # For Go binaries

# Non-root users
RUN adduser -D -s /bin/sh appuser
USER appuser
```

### Container Security
```bash
# Run with security options
docker run --security-opt=no-new-privileges:true nginx

# Drop capabilities
docker run --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx

# Read-only filesystem
docker run --read-only nginx

# Resource limits
docker run --memory="256m" --cpus="0.5" nginx
```

### Dockerfile Security
```dockerfile
# Security best practices
FROM node:16-alpine

# Update packages
RUN apk update && apk upgrade

# Don't run as root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001
USER nextjs

# Remove unnecessary packages
RUN apk del --purge build-dependencies

# Use COPY instead of ADD
COPY package*.json ./

# Avoid secrets in layers
RUN --mount=type=secret,id=api_key \
    API_KEY=$(cat /run/secrets/api_key) && \
    # Use the secret
```

### Runtime Security
```bash
# Docker bench security
docker run -it --net host --pid host --userns host --cap-add audit_control \
  -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
  -v /etc:/etc:ro \
  -v /usr/bin/containerd:/usr/bin/containerd:ro \
  -v /usr/bin/runc:/usr/bin/runc:ro \
  -v /usr/lib/systemd:/usr/lib/systemd:ro \
  -v /var/lib:/var/lib:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --label docker_bench_security \
  docker/docker-bench-security
```

---

## Monitoring & Logging

### Container Monitoring
```bash
# Real-time stats
docker stats

# System information
docker system df
docker system events

# Container resource usage
docker exec container_name top
```

### Logging Configuration
```bash
# Configure logging driver
docker run --log-driver=json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  nginx

# Send logs to syslog
docker run --log-driver=syslog nginx

# Send logs to journald
docker run --log-driver=journald nginx
```

### Monitoring Stack with Compose
```yaml
version: '3.8'

services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin

  node-exporter:
    image: prom/node-exporter
    ports:
      - "9100:9100"

  cadvisor:
    image: gcr.io/cadvisor/cadvisor
    ports:
      - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
```

---

## CI/CD Integration

### GitLab CI Pipeline
```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - deploy

variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"

services:
  - docker:dind

build:
  stage: build
  image: docker:latest
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

test:
  stage: test
  image: docker:latest
  script:
    - docker run --rm $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA npm test

deploy:
  stage: deploy
  image: docker:latest
  script:
    - docker tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA $CI_REGISTRY_IMAGE:latest
    - docker push $CI_REGISTRY_IMAGE:latest
  only:
    - main
```

### GitHub Actions
```yaml
# .github/workflows/docker.yml
name: Docker Build and Push

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v1
    
    - name: Login to DockerHub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKERHUB_USERNAME }}
        password: ${{ secrets.DOCKERHUB_TOKEN }}
    
    - name: Build and push
      uses: docker/build-push-action@v2
      with:
        context: .
        push: true
        tags: user/app:latest
        cache-from: type=gha
        cache-to: type=gha,mode=max
```

### Jenkins Pipeline
```groovy
pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "myapp"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").inside {
                        sh 'npm test'
                    }
                }
            }
        }
        
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push("latest")
                    }
                }
            }
        }
    }
}
```

---

## Troubleshooting & Debugging

### Common Issues and Solutions

#### Container Won't Start
```bash
# Check container logs
docker logs container_name

# Inspect container configuration
docker inspect container_name

# Check exit code
docker ps -a
```

#### Network Connectivity Issues
```bash
# Test container connectivity
docker exec container_name ping google.com
docker exec container_name nslookup google.com

# Check network configuration
docker network ls
docker network inspect network_name

# Test port connectivity
docker exec container_name telnet host port
```

#### Storage Issues
```bash
# Check disk usage
docker system df

# Clean up unused resources
docker system prune -a

# Check volume mounts
docker inspect container_name | grep -A 20 "Mounts"
```

#### Performance Issues
```bash
# Monitor resource usage
docker stats container_name

# Check container processes
docker exec container_name ps aux

# Memory analysis
docker exec container_name free -h
```

### Debugging Tools
```bash
# Enter container for debugging
docker exec -it container_name /bin/sh

# Copy files for analysis
docker cp container_name:/app/logs ./logs

# Run container with different entrypoint
docker run -it --entrypoint /bin/sh image_name

# Debugging with docker-compose
docker-compose exec service_name bash
```

### Log Analysis
```bash
# View logs with timestamps
docker logs -t container_name

# Follow logs in real-time
docker logs -f container_name

# Filter logs by time
docker logs --since 30m container_name
docker logs --until 2021-01-01 container_name

# Search logs
docker logs container_name 2>&1 | grep ERROR
```

---

## Production Considerations

### Resource Management
```bash
# Set resource limits
docker run -d \
  --memory="1g" \
  --cpus="1.5" \
  --memory-swap="2g" \
  nginx

# Monitor resource usage
docker stats --no-stream

# System-wide resource limits
# /etc/docker/daemon.json
{
  "default-ulimits": {
    "nofile": {
      "Name": "nofile",
      "Hard": 64000,
      "Soft": 64000
    }
  }
}
```

### Health Checks
```dockerfile
# Dockerfile health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1
```

```yaml
# Docker Compose health check
version: '3.8'
services:
  web:
    image: nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

### Backup Strategies
```bash
# Volume backup
docker run --rm \
  -v myapp_data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/backup-$(date +%Y%m%d).tar.gz /data

# Database backup
docker exec postgres_container pg_dump -U user dbname > backup.sql

# Image backup
docker save -o myapp.tar myapp:latest
docker load -i myapp.tar
```

### High Availability
```yaml
# Docker Swarm service
version: '3.8'
services:
  web:
    image: nginx
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
      update_config:
        parallelism: 1
        delay: 10s
        failure_action: rollback
      placement:
        constraints:
          - node.role == worker
```

---

## Interview Questions

### Basic Level (0-1 years)

**Q1: What is Docker and how does it differ from virtual machines?**
A: Docker is a containerization platform that packages applications with their dependencies. Unlike VMs, containers share the host OS kernel, making them lighter and faster to start.

**Q2: Explain the difference between Docker images and containers.**
A: Images are read-only templates used to create containers. Containers are running instances of images with an additional writable layer.

**Q3: What is a Dockerfile?**
A: A Dockerfile is a text file containing instructions to build a Docker image. It defines the base image, dependencies, configuration, and commands to run.

**Q4: How do you expose ports in Docker?**
A: Use the `-p` flag: `docker run -p host_port:container_port image`. In Dockerfile, use `EXPOSE port_number`.

**Q5: What is the difference between COPY and ADD in Dockerfile?**
A: COPY simply copies files/folders. ADD has additional features like URL downloading and automatic tar extraction, but COPY is preferred for clarity.

### Intermediate Level (1-2 years)

**Q6: Explain Docker networking modes.**
A: 
- Bridge: Default, containers communicate via bridge network
- Host: Container uses host networking directly
- None: No networking
- Overlay: Multi-host networking for Swarm

**Q7: How do you persist data in Docker?**
A: Using volumes (managed by Docker) or bind mounts (host filesystem paths). Volumes are preferred for production.

**Q8: What is multi-stage build in Docker?**
A: A technique to reduce image size by using multiple FROM statements, copying only necessary artifacts from build stage to production stage.

**Q9: How do you optimize Docker images?**
A: Use minimal base images, multi-stage builds, minimize layers, use .dockerignore, and avoid installing unnecessary packages.

**Q10: Explain Docker Compose and its benefits.**
A: Tool for defining multi-container applications using YAML. Benefits include service orchestration, networking, and environment management.

### Advanced Level (3+ years)

**Q11: How do you implement container security?**
A: Use minimal base images, non-root users, security scanning, resource limits, read-only filesystems, and tools like Docker Bench Security.

**Q12: Explain Docker Swarm vs Kubernetes.**
A: Swarm is Docker's native orchestration, simpler but less feature-rich. Kubernetes is more complex but offers advanced features like auto-scaling, rolling updates, and ecosystem.

**Q13: How do you troubleshoot container performance issues?**
A: Use `docker stats`, `docker logs`, container monitoring tools, analyze resource usage, check network connectivity, and review application metrics.

**Q14: Describe your CI/CD pipeline with Docker.**
A: Build images in CI, run tests in containers, push to registry, deploy using orchestration tools, implement blue-green or rolling deployments.

**Q15: How do you handle secrets in Docker?**
A: Use Docker secrets (Swarm), external secret management (Vault), environment variables at runtime, or init containers for secret injection.

---

## Hands-on Labs

### Lab 1: Basic Container Operations
```bash
# Pull and run nginx
docker pull nginx:alpine
docker run -d -p 8080:80 --name web nginx:alpine

# Modify content
docker exec -it web sh
echo "<h1>Hello Docker!</h1>" > /usr/share/nginx/html/index.html
exit

# Test the change
curl http://localhost:8080

# View logs
docker logs web

# Stop and remove
docker stop web
docker rm web
```

### Lab 2: Building Custom Images
```bash
# Create application files
mkdir myapp && cd myapp

# Create app.js
cat > app.js << 'EOF'
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello from Docker!');
});

app.get('/health', (req, res) => {
    res.status(200).json({ status: 'healthy' });
});

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});
EOF

# Create package.json
cat > package.json << 'EOF'
{
  "name": "docker-app",
  "version": "1.0.0",
  "main": "app.js",
  "dependencies": {
    "express": "^4.18.0"
  }
}
EOF

# Create Dockerfile
cat > Dockerfile << 'EOF'
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

USER node

CMD ["node", "app.js"]
EOF

# Build and run
docker build -t myapp:v1.0 .
docker run -d -p 3000:3000 --name myapp myapp:v1.0

# Test
curl http://localhost:3000
curl http://localhost:3000/health

# Check health status
docker inspect myapp | grep -A 10 Health
```

### Lab 3: Docker Compose Full-Stack Application
```bash
# Create project structure
mkdir fullstack-app && cd fullstack-app
mkdir backend frontend nginx

# Backend (Node.js API)
cat > backend/app.js << 'EOF'
const express = require('express');
const { Pool } = require('pg');
const redis = require('redis');

const app = express();
const port = 3001;

// Database connection
const pool = new Pool({
  user: 'postgres',
  host: 'database',
  database: 'myapp',
  password: 'password',
  port: 5432,
});

// Redis connection
const redisClient = redis.createClient({
  host: 'redis',
  port: 6379
});

app.use(express.json());

app.get('/api/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.post('/api/users', async (req, res) => {
  try {
    const { name, email } = req.body;
    const result = await pool.query(
      'INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *',
      [name, email]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(port, () => {
  console.log(`Backend running on port ${port}`);
});
EOF

cat > backend/package.json << 'EOF'
{
  "name": "backend",
  "version": "1.0.0",
  "main": "app.js",
  "dependencies": {
    "express": "^4.18.0",
    "pg": "^8.7.0",
    "redis": "^4.0.0"
  }
}
EOF

cat > backend/Dockerfile << 'EOF'
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3001

CMD ["node", "app.js"]
EOF

# Frontend (React)
cat > frontend/package.json << 'EOF'
{
  "name": "frontend",
  "version": "1.0.0",
  "dependencies": {
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "react-scripts": "5.0.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build"
  },
  "proxy": "http://backend:3001"
}
EOF

cat > frontend/Dockerfile << 'EOF'
FROM node:16-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Nginx configuration
cat > nginx/nginx.conf << 'EOF'
upstream backend {
    server backend:3001;
}

server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://backend;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF

# Database initialization
cat > init.sql << 'EOF'
CREATE DATABASE IF NOT EXISTS myapp;

\c myapp;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email) VALUES 
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');
EOF

# Docker Compose file
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  database:
    image: postgres:13-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 30s
      timeout: 10s
      retries: 5

  redis:
    image: redis:alpine
    volumes:
      - redis_data:/data

  backend:
    build: ./backend
    environment:
      - NODE_ENV=development
    depends_on:
      database:
        condition: service_healthy
      redis:
        condition: service_started
    volumes:
      - ./backend:/app
      - /app/node_modules

  frontend:
    build: ./frontend
    depends_on:
      - backend

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - backend
      - frontend

volumes:
  postgres_data:
  redis_data:

networks:
  default:
    driver: bridge
EOF

# Start the application
docker-compose up --build -d

# Test the application
sleep 30  # Wait for services to start
curl http://localhost/api/health
curl http://localhost/api/users
```

### Lab 4: Production Deployment with Docker Swarm
```bash
# Initialize Docker Swarm
docker swarm init

# Create production compose file
cat > docker-compose.prod.yml << 'EOF'
version: '3.8'

services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
      update_config:
        parallelism: 1
        delay: 10s
        failure_action: rollback
      resources:
        limits:
          memory: 128M
        reservations:
          memory: 64M
    volumes:
      - web_content:/usr/share/nginx/html
    networks:
      - webnet

  api:
    image: node:16-alpine
    command: ["node", "server.js"]
    deploy:
      replicas: 2
      restart_policy:
        condition: on-failure
      resources:
        limits:
          memory: 256M
        reservations:
          memory: 128M
    environment:
      - NODE_ENV=production
    networks:
      - webnet
      - backend
    secrets:
      - db_password

  database:
    image: postgres:13-alpine
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      placement:
        constraints:
          - node.role == manager
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - backend
    secrets:
      - db_password

volumes:
  web_content:
  db_data:

networks:
  webnet:
    driver: overlay
  backend:
    driver: overlay

secrets:
  db_password:
    external: true
EOF

# Create secret
echo "my_secret_password" | docker secret create db_password -

# Deploy stack
docker stack deploy -c docker-compose.prod.yml myapp

# Monitor services
docker service ls
docker service ps myapp_web

# Scale service
docker service scale myapp_web=5

# Update service
docker service update --image nginx:latest myapp_web
```

### Lab 5: Container Security Hardening
```bash
# Create security-focused Dockerfile
cat > Dockerfile.secure << 'EOF'
# Use specific version
FROM node:16.14.0-alpine3.15

# Update packages and remove package manager
RUN apk update && apk upgrade && \
    apk add --no-cache dumb-init && \
    rm -rf /var/cache/apk/*

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001 -G nodejs

# Set working directory with proper permissions
WORKDIR /app
RUN chown nodejs:nodejs /app

# Copy package files and install dependencies
COPY --chown=nodejs:nodejs package*.json ./
USER nodejs
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY --chown=nodejs:nodejs . .

# Remove development dependencies and unnecessary files
RUN rm -f package-lock.json

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node healthcheck.js || exit 1

# Expose port
EXPOSE 3000

# Use dumb-init as PID 1
ENTRYPOINT ["dumb-init", "--"]

# Start application
CMD ["node", "server.js"]
EOF

# Run with security options
docker run -d \
  --name secure-app \
  --read-only \
  --tmpfs /tmp \
  --security-opt=no-new-privileges:true \
  --cap-drop=ALL \
  --cap-add=NET_BIND_SERVICE \
  --user 1001:1001 \
  --memory="256m" \
  --cpus="0.5" \
  --pids-limit=100 \
  -p 3000:3000 \
  myapp:secure

# Security scan
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image myapp:secure
```

### Lab 6: Monitoring and Logging Setup
```bash
# Create monitoring stack
mkdir monitoring && cd monitoring

cat > docker-compose.monitoring.yml << 'EOF'
version: '3.8'

services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--web.enable-lifecycle'

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_USERS_ALLOW_SIGN_UP=false
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana/provisioning:/etc/grafana/provisioning
      - ./grafana/dashboards:/var/lib/grafana/dashboards

  node-exporter:
    image: prom/node-exporter:latest
    container_name: node-exporter
    ports:
      - "9100:9100"
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($|/)'

  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    container_name: cadvisor
    ports:
      - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    privileged: true

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.15.0
    container_name: elasticsearch
    environment:
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data
    ports:
      - "9200:9200"

  kibana:
    image: docker.elastic.co/kibana/kibana:7.15.0
    container_name: kibana
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch

  logstash:
    image: docker.elastic.co/logstash/logstash:7.15.0
    container_name: logstash
    volumes:
      - ./logstash/config/logstash.yml:/usr/share/logstash/config/logstash.yml
      - ./logstash/pipeline:/usr/share/logstash/pipeline
    ports:
      - "5044:5044"
    depends_on:
      - elasticsearch

volumes:
  prometheus_data:
  grafana_data:
  elasticsearch_data:
EOF

# Prometheus configuration
cat > prometheus.yml << 'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
EOF

# Start monitoring stack
docker-compose -f docker-compose.monitoring.yml up -d

# Wait for services to start
sleep 60

# Test endpoints
curl http://localhost:9090  # Prometheus
curl http://localhost:3000  # Grafana (admin/admin)
curl http://localhost:5601  # Kibana
```

### Lab 7: Backup and Disaster Recovery
```bash
# Create backup scripts
mkdir backup-scripts && cd backup-scripts

# Volume backup script
cat > backup-volumes.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup named volumes
for volume in $(docker volume ls -q); do
    echo "Backing up volume: $volume"
    docker run --rm \
        -v $volume:/data \
        -v $BACKUP_DIR:/backup \
        alpine tar czf /backup/${volume}_${DATE}.tar.gz /data
done

# Clean old backups (keep 7 days)
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "Backup completed: $DATE"
EOF

# Database backup script
cat > backup-database.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="/backups/database"
DATE=$(date +%Y%m%d_%H%M%S)
CONTAINER_NAME="postgres_container"

mkdir -p $BACKUP_DIR

# PostgreSQL backup
docker exec $CONTAINER_NAME pg_dump -U postgres myapp > $BACKUP_DIR/myapp_$DATE.sql

# Compress backup
gzip $BACKUP_DIR/myapp_$DATE.sql

# Clean old backups
find $BACKUP_DIR -name "*.sql.gz" -mtime +30 -delete

echo "Database backup completed: $DATE"
EOF

# Restore script
cat > restore-database.sh << 'EOF'
#!/bin/bash

BACKUP_FILE=$1
CONTAINER_NAME="postgres_container"

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: $0 <backup_file.sql.gz>"
    exit 1
fi

# Extract and restore
gunzip -c $BACKUP_FILE | docker exec -i $CONTAINER_NAME psql -U postgres -d myapp

echo "Database restored from: $BACKUP_FILE"
EOF

# Make scripts executable
chmod +x *.sh

# Container state backup
cat > backup-containers.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="/backups/containers"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Export running containers
for container in $(docker ps --format "table {{.Names}}" | tail -n +2); do
    echo "Exporting container: $container"
    
    # Get image name
    image=$(docker inspect $container --format='{{.Config.Image}}')
    
    # Create container export
    docker export $container > $BACKUP_DIR/${container}_${DATE}.tar
    
    # Save container metadata
    docker inspect $container > $BACKUP_DIR/${container}_${DATE}_metadata.json
    
    echo "Container: $container, Image: $image" >> $BACKUP_DIR/containers_list_$DATE.txt
done

echo "Container backup completed: $DATE"
EOF

chmod +x backup-containers.sh

# Automated backup with cron
echo "Creating automated backup schedule..."
(crontab -l 2>/dev/null; echo "0 2 * * * /path/to/backup-volumes.sh") | crontab -
(crontab -l 2>/dev/null; echo "30 2 * * * /path/to/backup-database.sh") | crontab -
```

---

## Performance Optimization

### Image Optimization Techniques
```dockerfile
# Multi-stage build for minimal production image
FROM node:16-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:16-alpine AS production
WORKDIR /app

# Copy only production dependencies
COPY --from=builder /app/node_modules ./node_modules
COPY . .

# Remove unnecessary files
RUN rm -rf /app/src/tests \
    && rm -rf /app/docs \
    && rm -rf /app/.git

# Use distroless or scratch for ultimate minimal image
FROM gcr.io/distroless/nodejs:16
COPY --from=production /app /app
WORKDIR /app
CMD ["server.js"]
```

### Container Performance Tuning
```bash
# CPU and Memory optimization
docker run -d \
  --cpus="2.0" \
  --memory="2g" \
  --memory-swap="4g" \
  --oom-kill-disable=false \
  --memory-swappiness=10 \
  nginx

# I/O optimization
docker run -d \
  --device-read-bps /dev/sda:100mb \
  --device-write-bps /dev/sda:50mb \
  --blkio-weight=500 \
  nginx

# Network optimization
docker run -d \
  --network host \
  --sysctl net.core.somaxconn=65535 \
  nginx
```

---

## Advanced Docker Features

### Docker BuildKit
```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1

# Advanced Dockerfile with BuildKit features
cat > Dockerfile.buildkit << 'EOF'
# syntax=docker/dockerfile:1.4
FROM node:16-alpine

# Cache mount for npm
RUN --mount=type=cache,target=/root/.npm \
    npm install -g npm@latest

WORKDIR /app

# Cache mount for node_modules
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/app/node_modules \
    npm ci --only=production

COPY . .

EXPOSE 3000
CMD ["npm", "start"]
EOF

# Build with BuildKit
docker build -f Dockerfile.buildkit -t myapp:buildkit .
```

### Docker Context
```bash
# Create remote Docker context
docker context create remote --docker "host=ssh://user@remote-host"

# Use remote context
docker context use remote
docker ps  # This runs on remote host

# Switch back to default
docker context use default
```

### Docker Extensions and Plugins
```bash
# Install Docker Compose as a plugin
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
    -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

# Use as plugin
docker compose up -d
```

---

## Conclusion

This comprehensive Docker guide covers everything from basic concepts to advanced production deployments. As a DevOps engineer with 3+ years of experience, you should be comfortable with:

### Core Competencies
- Container lifecycle management
- Image optimization and security
- Multi-container orchestration
- CI/CD integration
- Production deployment strategies
- Monitoring and troubleshooting
- Performance optimization

### Key Takeaways for Career Growth
1. **Practice Regularly**: Set up lab environments and experiment
2. **Focus on Security**: Always implement security best practices
3. **Learn Orchestration**: Master Docker Compose, consider Kubernetes
4. **Automate Everything**: Integrate Docker into CI/CD pipelines
5. **Monitor and Optimize**: Understand performance implications
6. **Stay Updated**: Follow Docker releases and community best practices

### Next Steps
- Explore Kubernetes for advanced orchestration
- Learn about service mesh technologies (Istio, Linkerd)
- Dive deeper into container security scanning
- Study advanced networking concepts
- Practice with different cloud providers (AWS ECS, GCP GKE, Azure ACI)

### Resources for Continuous Learning
- Docker Official Documentation
- Play with Docker online labs
- Docker Community Forums
- Kubernetes documentation
- Cloud provider container services documentation

Remember: Docker is just a tool in the DevOps ecosystem. Understanding how it integrates with other technologies like Kubernetes, CI/CD tools, monitoring solutions, and cloud platforms is crucial for career advancement.

---

*This guide serves as a comprehensive reference for Docker technologies. Regular practice and hands-on experience with these concepts will prepare you for senior DevOps roles and technical interviews.*
