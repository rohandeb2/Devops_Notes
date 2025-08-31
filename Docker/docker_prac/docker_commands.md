# Docker DevOps Projects Collection

## 📋 Overview

This repository contains a collection of Dockerized applications demonstrating various DevOps practices including containerization, multi-stage builds, Docker networking, volume management, and Docker Compose orchestration.

## 🏗️ Project Structure

```
devops_sep/
├── docker/
│   ├── java-quotes-app/
│   ├── flask-app-ecs/
│   ├── community_portfolio/
│   └── two-tier-flask-app/
└── volume/
```

## 🚀 Applications Included

### 1. Java Quotes Application
- **Port**: 8000
- **Technology**: Java
- **Features**: Quote generation service

### 2. Python Flask Application (ECS)
- **Port**: 80
- **Technology**: Python/Flask
- **Features**: Multi-stage Docker build for optimized image size

### 3. Community Portfolio
- **Port**: 3000
- **Technology**: Node.js/React
- **Features**: Portfolio website

### 4. Two-Tier Flask Application
- **Ports**: 5000 (Flask), 3306 (MySQL)
- **Technology**: Python/Flask + MySQL
- **Features**: Full-stack web application with database

## 📦 Prerequisites

- Docker Engine 20.10+
- Docker Compose V2
- Git
- 4GB+ RAM (recommended)

## 🛠️ Installation & Setup

### 1. Clone the Repository Structure

```bash
mkdir devops_sep && cd devops_sep
mkdir docker && cd docker
```

### 2. Clone Individual Applications

```bash
# Java Quotes App
git clone https://github.com/LondheShubham153/java-quotes-app.git

# Flask ECS App
git clone https://github.com/LondheShubham153/flask-app-ecs.git

# Portfolio App
git clone https://github.com/LondheShubham153/community_portfolio.git

# Two-Tier Flask App
git clone https://github.com/LondheShubham153/two-tier-flask-app.git
```

### 3. Create Volume Directory

```bash
mkdir ~/devops_sep/volume
```

## 🐳 Docker Commands Reference

### Basic Image Management

```bash
# Build images
docker build -t java-quotes:latest .
docker build -t python-app:latest .
docker build -t portfolio-app .
docker build -t flask-app .

# Multi-stage build for optimized Python app
docker build -f Docker-multi-stage -t python-app-mini .

# List images
docker images

# Remove all images
docker rmi -f $(docker images -aq)
```

### Container Operations

```bash
# Run Java Quotes App
docker run -d -p 8000:8000 --name java-quotes-app java-quotes:latest

# Run Python Flask App with volume mounting
docker run -d -p 80:80 --name python-app python-app:latest

# Run Portfolio App
docker run -d -p 3000:3000 --name portfolio portfolio-app:latest

# View running containers
docker ps

# View all containers (including stopped)
docker ps -a

# Stop and remove containers
docker stop <container_id> && docker rm <container_id>

# Stop all containers
docker stop $(docker ps -aq)

# Remove all containers
docker rm $(docker ps -aq)
```

### Volume Management

```bash
# Create named volume
docker volume create mysql-data

# List volumes
docker volume ls

# Inspect volume
docker inspect mysql-data

# Run with bind mount
docker run -d -v /home/rohan/devops_sep/volume:/app/data java-app

# Run with named volume
docker run -d -v mysql_data:/var/lib/mysql mysql:latest
```

### Network Management

```bash
# Create custom network
docker network create twotier

# List networks
docker network ls

# Inspect network
docker inspect twotier
```

### Registry Operations

```bash
# Login to Docker Hub
docker login

# Tag image for registry
docker tag python-app-mini:latest rohan700/python-app-mini:latest

# Push to Docker Hub
docker push rohan700/python-app-mini:latest

# Pull from registry
docker pull mysql
```

## 🔄 Two-Tier Application Deployment

### Manual Docker Commands

```bash
# Create network
docker network create twotier

# Run MySQL database
docker run -d --name mysql \
  --network=twotier \
  -e MYSQL_ROOT_PASSWORD=admin \
  -e MYSQL_DATABASE=tws_db \
  -e MYSQL_USER=admin \
  -e MYSQL_PASSWORD=admin \
  -p 3306:3306 \
  mysql:latest

# Run Flask application
docker run -d --name flask-app \
  --network=twotier \
  -e MYSQL_USER=admin \
  -e MYSQL_PASSWORD=admin \
  -e MYSQL_DB=tws_db \
  -e MYSQL_HOST=mysql \
  -p 5000:5000 \
  flask-app:latest
```

### Using Docker Compose

```bash
# Start services
docker compose up --build

# Start in detached mode
docker compose up --build -d

# Stop services
docker compose down

# Stop and remove volumes
docker compose down -v
```

## 📝 Docker Compose Configuration

Create a `docker-compose.yml` file in the two-tier-flask-app directory:

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:5.7
    container_name: mysql
    environment:
      MYSQL_ROOT_PASSWORD: admin
      MYSQL_DATABASE: tws_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
    ports:
      - "3306:3306"
    volumes:
      - mysql_data_new:/var/lib/mysql
    networks:
      - twotier

  flask-app:
    build: .
    container_name: flask-app
    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin
      MYSQL_DB: tws_db
    ports:
      - "5000:5000"
    depends_on:
      - mysql
    networks:
      - twotier

volumes:
  mysql_data_new:

networks:
  twotier:
    driver: bridge
```

## 🧹 Cleanup Commands

```bash
# Clean up system
docker system prune

# Remove all stopped containers
docker container prune -f

# Remove all unused volumes
docker volume prune -f

# Complete cleanup (use with caution)
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker volume prune -f
docker network prune -f
```

## 📊 Monitoring & Debugging

```bash
# View container logs
docker logs <container_name>

# Follow logs in real-time
docker logs -f <container_name>

# Execute commands in running container
docker exec -it <container_name> bash

# Watch running containers
watch docker ps

# Inspect container details
docker inspect <container_name>
```

## 🔧 Troubleshooting

### Common Issues

1. **Port Already in Use**
   - Check running processes: `sudo netstat -tlnp | grep <port>`
   - Stop conflicting services: `sudo systemctl stop <service>`

2. **MySQL Connection Issues**
   - Ensure network connectivity between containers
   - Verify environment variables are correctly set
   - Check MySQL logs: `docker logs mysql`

3. **Build Failures**
   - Clean Docker cache: `docker builder prune`
   - Remove conflicting containers: `docker rm -f <container_name>`

4. **Volume Permission Issues**
   - Fix ownership: `sudo chown -R 999:999 ./mysql_data_new`
   - Use named volumes instead of bind mounts

### Docker Compose Issues

```bash
# Rebuild services
docker compose up --build

# Force recreate containers
docker compose up --force-recreate

# View service logs
docker compose logs <service_name>
```

## 📈 Performance Optimization

### Multi-Stage Builds

Use multi-stage builds to reduce image size:

```dockerfile
# Build stage
FROM python:3.9-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Production stage
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
CMD ["python", "app.py"]
```

### Best Practices

- Use `.dockerignore` to exclude unnecessary files
- Leverage Docker layer caching
- Use specific image tags instead of `latest`
- Minimize the number of RUN instructions
- Clean up package caches in Dockerfile

## 🔒 Security Considerations

- Don't run containers as root user when possible
- Use secrets management for sensitive data
- Regularly update base images
- Scan images for vulnerabilities
- Use multi-stage builds to reduce attack surface

## 🌐 Environment Variables

### Flask Application
- `MYSQL_HOST`: MySQL server hostname
- `MYSQL_USER`: Database username
- `MYSQL_PASSWORD`: Database password
- `MYSQL_DB`: Database name

### MySQL Database
- `MYSQL_ROOT_PASSWORD`: Root user password
- `MYSQL_DATABASE`: Initial database name
- `MYSQL_USER`: Additional user account
- `MYSQL_PASSWORD`: User account password

## 🏢 Professional Docker Commands

### Advanced Container Management

```bash
# Run container with resource limits
docker run -d --memory="512m" --cpus="1.0" --name app nginx

# Run with restart policies
docker run -d --restart=unless-stopped nginx

# Run with health checks
docker run -d --health-cmd="curl -f http://localhost/" \
  --health-interval=30s --health-timeout=10s \
  --health-retries=3 nginx

# Run with user specification (non-root)
docker run -d --user 1000:1000 nginx

# Run with read-only filesystem
docker run -d --read-only --tmpfs /tmp nginx
```

### Production Deployment

```bash
# Deploy with Docker Swarm
docker swarm init
docker service create --name web --replicas 3 -p 80:80 nginx
docker service scale web=5
docker service update --image nginx:1.21 web

# Rolling updates
docker service update --update-parallelism 1 --update-delay 10s web

# Blue-green deployment simulation
docker service create --name blue-app nginx:1.20
docker service create --name green-app nginx:1.21
```

### Container Orchestration

```bash
# Stack deployment
docker stack deploy -c docker-compose.prod.yml myapp

# View stack services
docker stack services myapp

# Remove stack
docker stack rm myapp
```

### Security & Scanning

```bash
# Scan images for vulnerabilities
docker scout cves nginx:latest

# Run security benchmark
docker run --rm -it --net host --pid host --userns host --cap-add audit_control \
  -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
  -v /etc:/etc:ro \
  -v /usr/bin/containerd:/usr/bin/containerd:ro \
  -v /usr/bin/runc:/usr/bin/runc:ro \
  -v /usr/lib/systemd:/usr/lib/systemd:ro \
  -v /var/lib:/var/lib:ro \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --label docker_bench_security \
  docker/docker-bench-security

# Sign and verify images
export DOCKER_CONTENT_TRUST=1
docker push myregistry/myimage:latest
```

### Performance & Monitoring

```bash
# Container resource usage
docker stats
docker stats --no-stream

# System events monitoring
docker events

# Detailed container inspection
docker inspect --format='{{.State.Health.Status}}' container_name
docker inspect --format='{{.NetworkSettings.IPAddress}}' container_name

# Export/Import for backup
docker export container_name > backup.tar
docker import backup.tar new_image:tag

# Save/Load images
docker save -o myimage.tar myimage:latest
docker load -i myimage.tar
```

### Multi-Platform Builds

```bash
# Enable buildx for multi-arch builds
docker buildx create --use --name multiarch

# Build for multiple platforms
docker buildx build --platform linux/amd64,linux/arm64 \
  -t myregistry/myapp:latest --push .

# Inspect builder
docker buildx inspect multiarch
```

### Advanced Networking

```bash
# Create custom bridge network with subnet
docker network create --driver bridge --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 custom-net

# Connect running container to network
docker network connect custom-net container_name

# Create overlay network for swarm
docker network create --driver overlay --attachable my-overlay

# Network troubleshooting
docker run --rm --net container:web nicolaka/netshoot ss -tulpn
```

### Docker Registry Operations

```bash
# Run private registry
docker run -d -p 5000:5000 --name registry registry:2

# Push to private registry
docker tag myapp:latest localhost:5000/myapp:latest
docker push localhost:5000/myapp:latest

# Registry catalog
curl -X GET http://localhost:5000/v2/_catalog

# List image tags
curl -X GET http://localhost:5000/v2/myapp/tags/list
```

### Production-Grade Compose

```bash
# Production deployment with specific compose file
docker compose -f docker-compose.prod.yml up -d

# Scale specific services
docker compose up -d --scale web=3 --scale worker=2

# Rolling restart
docker compose restart --scale web=0
docker compose up -d --scale web=3

# Health check in compose
docker compose ps --format "table {{.Service}}\t{{.Status}}\t{{.Ports}}"
```

### Advanced Debugging

```bash
# Debug container filesystem
docker diff container_name

# Copy files from/to container
docker cp container_name:/path/to/file ./local/path
docker cp ./local/file container_name:/path/to/destination

# Run debug container in same namespace
docker run -it --rm --pid container:target_container \
  --net container:target_container --cap-add SYS_PTRACE \
  nicolaka/netshoot

# Container process monitoring
docker exec container_name ps aux
docker exec container_name top

# Memory and CPU usage
docker exec container_name cat /proc/meminfo
docker exec container_name cat /proc/cpuinfo
```

### CI/CD Integration Commands

```bash
# Automated testing
docker run --rm -v $(pwd):/app -w /app node:16 npm test

# Build with build args for CI
docker build --build-arg VERSION=$(git rev-parse HEAD) \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  -t myapp:$(git rev-parse HEAD) .

# Conditional builds
docker build --target production -t myapp:prod .
docker build --target development -t myapp:dev .

# Cache optimization for CI
docker build --cache-from myapp:cache --build-arg BUILDKIT_INLINE_CACHE=1 .
```

### Container Cleanup & Maintenance

```bash
# Advanced system cleanup
docker system prune -a --volumes

# Remove containers older than 24h
docker container prune --filter "until=24h"

# Remove images not used by containers
docker image prune -a

# Clean build cache
docker builder prune --all

# Remove specific pattern images
docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi
```

### Professional Development Workflow

```bash
# Development with hot reload
docker run -d -v $(pwd):/app -w /app \
  -p 3000:3000 --name dev-app \
  node:16 npm run dev

# Run tests in isolated environment
docker run --rm -v $(pwd):/app -w /app \
  -e NODE_ENV=test node:16 npm test

# Linting and code quality
docker run --rm -v $(pwd):/app -w /app \
  node:16 npm run lint

# Database migrations
docker exec flask-app python manage.py db upgrade

# Backup database
docker exec mysql mysqldump -u admin -padmin tws_db > backup.sql
```

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Best Practices](https://docs.docker.com/develop/best-practices/)
- [Docker Security](https://docs.docker.com/engine/security/)
- [Production Deployment Guide](https://docs.docker.com/engine/swarm/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Docker
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: This documentation is based on a DevOps learning project. Ensure all security best practices are implemented before deploying to production environments.
