# 🦊 Complete GitLab CI/CD Guide for DevOps Engineers

*From Beginner to 3+ Years Experience Level*

---

## Table of Contents

1. [Introduction to GitLab](#introduction-to-gitlab)
2. [GitLab Architecture & Components](#gitlab-architecture--components)
3. [GitLab Installation & Setup](#gitlab-installation--setup)
4. [GitLab CI/CD Fundamentals](#gitlab-cicd-fundamentals)
5. [GitLab Runner Configuration](#gitlab-runner-configuration)
6. [Pipeline Configuration (.gitlab-ci.yml)](#pipeline-configuration-gitlab-ciyml)
7. [Jobs, Stages, and Workflows](#jobs-stages-and-workflows)
8. [Variables and Secrets Management](#variables-and-secrets-management)
9. [Docker Integration](#docker-integration)
10. [Kubernetes Integration](#kubernetes-integration)
11. [GitLab Registry](#gitlab-registry)
12. [Security and Compliance](#security-and-compliance)
13. [Monitoring and Analytics](#monitoring-and-analytics)
14. [Advanced Pipeline Patterns](#advanced-pipeline-patterns)
15. [Multi-Project Pipelines](#multi-project-pipelines)
16. [GitOps with GitLab](#gitops-with-gitlab)
17. [Performance Optimization](#performance-optimization)
18. [Troubleshooting](#troubleshooting)
19. [Best Practices](#best-practices)
20. [Interview Questions](#interview-questions)
21. [Hands-on Labs](#hands-on-labs)

---

## Introduction to GitLab

### What is GitLab?

GitLab is a complete DevOps platform that provides source code management, CI/CD pipelines, container registry, security scanning, monitoring, and more in a single application.

### GitLab vs Competitors

| Feature | GitLab | GitHub Actions | Jenkins | Azure DevOps |
|---------|--------|----------------|---------|--------------|
| Built-in CI/CD | ✅ | ✅ | ✅ | ✅ |
| Container Registry | ✅ | ✅ | ❌ | ✅ |
| Security Scanning | ✅ | ✅ | Plugin | ✅ |
| Issue Management | ✅ | ✅ | ❌ | ✅ |
| Self-hosted | ✅ | ❌ | ✅ | ✅ |
| Free Tier | ✅ | ✅ | ✅ | Limited |

### Key Benefits

- **Single Platform**: Everything in one place
- **DevOps Lifecycle**: Complete software development lifecycle
- **Scalability**: From small teams to enterprise
- **Security First**: Built-in security scanning
- **Flexibility**: Self-hosted or SaaS options
- **Open Source**: Community edition available

---

## GitLab Architecture & Components

### GitLab Components

```
┌─────────────────────────────────────────────────────────────┐
│                    GitLab Instance                          │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   GitLab    │  │   GitLab    │  │    GitLab Pages     │  │
│  │   Rails     │  │   Workhorse │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │  PostgreSQL │  │    Redis    │  │    GitLab Runner    │  │
│  │  Database   │  │   Cache     │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   Gitaly    │  │ Object      │  │   Container         │  │
│  │   Git       │  │ Storage     │  │   Registry          │  │
│  │   Storage   │  │             │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### Core Services

1. **GitLab Rails Application**: Main web interface and API
2. **GitLab Workhorse**: HTTP reverse proxy for large requests
3. **Gitaly**: Git repository storage service
4. **GitLab Runner**: CI/CD job executor
5. **PostgreSQL**: Primary database
6. **Redis**: Cache and session storage
7. **Container Registry**: Docker image storage

---

## GitLab Installation & Setup

### Docker Installation (Recommended for Testing)

```bash
# Create directory structure
mkdir -p /srv/gitlab/{config,logs,data}

# Docker Compose setup
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    container_name: gitlab
    hostname: 'gitlab.example.com'
    ports:
      - '80:80'
      - '443:443'
      - '22:22'
    volumes:
      - '/srv/gitlab/config:/etc/gitlab'
      - '/srv/gitlab/logs:/var/log/gitlab'
      - '/srv/gitlab/data:/var/opt/gitlab'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://gitlab.example.com'
        gitlab_rails['gitlab_shell_ssh_port'] = 22
        # Email configuration
        gitlab_rails['smtp_enable'] = true
        gitlab_rails['smtp_address'] = "smtp.gmail.com"
        gitlab_rails['smtp_port'] = 587
        gitlab_rails['smtp_user_name'] = "your-email@gmail.com"
        gitlab_rails['smtp_password'] = "your-password"
        gitlab_rails['smtp_domain'] = "smtp.gmail.com"
        gitlab_rails['smtp_authentication'] = "login"
        gitlab_rails['smtp_enable_starttls_auto'] = true
        gitlab_rails['gitlab_email_from'] = 'your-email@gmail.com'
        gitlab_rails['gitlab_email_display_name'] = 'GitLab'
    restart: always

  gitlab-runner:
    image: gitlab/gitlab-runner:latest
    container_name: gitlab-runner
    volumes:
      - /srv/gitlab-runner/config:/etc/gitlab-runner
      - /var/run/docker.sock:/var/run/docker.sock
    restart: always
EOF

# Start GitLab
docker-compose up -d

# Get initial root password
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

### Production Installation (Ubuntu)

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y curl openssh-server ca-certificates tzdata perl

# Add GitLab repository
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

# Install GitLab
sudo apt install gitlab-ce

# Configure GitLab
sudo nano /etc/gitlab/gitlab.rb

# Key configurations to modify:
external_url 'https://gitlab.yourdomain.com'
nginx['enable'] = true
nginx['client_max_body_size'] = '250m'
nginx['redirect_http_to_https'] = true
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.yourdomain.com.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.yourdomain.com.key"

# SSL Configuration
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['admin@yourdomain.com']
letsencrypt['auto_renew'] = true

# Database configuration (for external PostgreSQL)
postgresql['enable'] = false
gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'unicode'
gitlab_rails['db_host'] = '127.0.0.1'
gitlab_rails['db_port'] = 5432
gitlab_rails['db_database'] = 'gitlabhq_production'
gitlab_rails['db_username'] = 'gitlab'
gitlab_rails['db_password'] = 'password'

# Redis configuration (for external Redis)
redis['enable'] = false
gitlab_rails['redis_host'] = '127.0.0.1'
gitlab_rails['redis_port'] = 6379

# Configure and start GitLab
sudo gitlab-ctl reconfigure
sudo gitlab-ctl start

# Get initial password
sudo cat /etc/gitlab/initial_root_password
```

### High Availability Setup

```yaml
# HA GitLab with Docker Swarm
version: '3.8'

services:
  gitlab:
    image: gitlab/gitlab-ce:latest
    deploy:
      replicas: 1
      placement:
        constraints:
          - node.role == manager
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
    ports:
      - "80:80"
      - "443:443"
      - "22:22"
    volumes:
      - gitlab_config:/etc/gitlab
      - gitlab_logs:/var/log/gitlab
      - gitlab_data:/var/opt/gitlab
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://gitlab.example.com'
        nginx['listen_https'] = false
        nginx['listen_port'] = 80
        nginx['real_ip_trusted_addresses'] = [ '10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16' ]
        nginx['real_ip_header'] = 'X-Real-IP'
        nginx['real_ip_recursive'] = 'on'
        gitlab_rails['trusted_proxies'] = ['10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16']

  gitlab-runner:
    image: gitlab/gitlab-runner:latest
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - gitlab_runner_config:/etc/gitlab-runner

volumes:
  gitlab_config:
  gitlab_logs:
  gitlab_data:
  gitlab_runner_config:

networks:
  default:
    external: true
    name: gitlab-network
```

---

## GitLab CI/CD Fundamentals

### CI/CD Pipeline Concepts

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Source    │───▶│   Build     │───▶│    Test     │───▶│   Deploy    │
│   Code      │    │   Stage     │    │   Stage     │    │   Stage     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │                   │
       ▼                   ▼                   ▼                   ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Git Commit  │    │ Compile     │    │ Unit Tests  │    │ Production  │
│ Git Push    │    │ Docker      │    │ Integration │    │ Staging     │
│ Merge       │    │ Build       │    │ Security    │    │ Review      │
│ Request     │    │ Artifacts   │    │ Scan        │    │ Apps        │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

### Basic Pipeline Structure

```yaml
# .gitlab-ci.yml
stages:
  - build
  - test
  - security
  - deploy

variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"

before_script:
  - echo "Pipeline started at $(date)"

after_script:
  - echo "Pipeline finished at $(date)"
```

---

## GitLab Runner Configuration

### Runner Types

1. **Shared Runners**: Available to all projects
2. **Group Runners**: Available to all projects in a group
3. **Specific Runners**: Dedicated to specific projects

### Runner Executors

| Executor | Use Case | Isolation | Performance |
|----------|----------|-----------|-------------|
| Shell | Simple scripts | Low | High |
| Docker | Containerized builds | High | Medium |
| Kubernetes | Cloud-native | High | Medium |
| VirtualBox | Full VM isolation | Very High | Low |
| SSH | Remote execution | Medium | Medium |

### Installing GitLab Runner

```bash
# Linux installation
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner

# Register runner
sudo gitlab-runner register \
  --url "https://gitlab.example.com/" \
  --registration-token "YOUR_REGISTRATION_TOKEN" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "docker-runner" \
  --tag-list "docker,aws" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

# Start runner
sudo gitlab-runner start
```

### Docker Runner Configuration

```toml
# /etc/gitlab-runner/config.toml
concurrent = 4
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "docker-runner"
  url = "https://gitlab.example.com/"
  token = "RUNNER_TOKEN"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]
  [runners.docker]
    tls_verify = false
    image = "alpine:latest"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]
    shm_size = 0
    extra_hosts = ["gitlab.example.com:192.168.1.100"]
```

### Kubernetes Runner Setup

```yaml
# gitlab-runner-rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: gitlab-runner
  namespace: gitlab-runner
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: gitlab-runner
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["list", "get", "watch", "create", "delete"]
- apiGroups: [""]
  resources: ["pods/exec"]
  verbs: ["create"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: gitlab-runner
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: gitlab-runner
subjects:
- kind: ServiceAccount
  name: gitlab-runner
  namespace: gitlab-runner
```

```bash
# Register Kubernetes runner
gitlab-runner register \
  --url "https://gitlab.example.com/" \
  --registration-token "YOUR_TOKEN" \
  --executor "kubernetes" \
  --kubernetes-host "https://k8s-api.example.com" \
  --kubernetes-namespace "gitlab-runner" \
  --kubernetes-service-account "gitlab-runner"
```

---

## Pipeline Configuration (.gitlab-ci.yml)

### Basic Pipeline Structure

```yaml
# .gitlab-ci.yml - Basic Example
stages:
  - build
  - test
  - deploy

variables:
  NODE_VERSION: "16"
  DATABASE_URL: "postgresql://user:pass@postgres:5432/test"

cache:
  paths:
    - node_modules/
    - .npm/

before_script:
  - apt-get update -qq && apt-get install -y -qq git curl
  - curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  - export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  - nvm install $NODE_VERSION && nvm use $NODE_VERSION
  - npm ci --cache .npm --prefer-offline

build_job:
  stage: build
  script:
    - echo "Building the application..."
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 week
  only:
    - main
    - develop
    - merge_requests

test_unit:
  stage: test
  script:
    - echo "Running unit tests..."
    - npm run test:unit
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
  artifacts:
    reports:
      junit: junit.xml
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura.xml

test_integration:
  stage: test
  services:
    - name: postgres:13
      alias: postgres
  variables:
    POSTGRES_DB: test_db
    POSTGRES_USER: test_user
    POSTGRES_PASSWORD: test_password
    POSTGRES_HOST_AUTH_METHOD: trust
  script:
    - echo "Running integration tests..."
    - npm run test:integration
  only:
    - main
    - develop

deploy_staging:
  stage: deploy
  script:
    - echo "Deploying to staging..."
    - npm run deploy:staging
  environment:
    name: staging
    url: https://staging.example.com
  when: manual
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - echo "Deploying to production..."
    - npm run deploy:production
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
```

### Advanced Pipeline Features

```yaml
# .gitlab-ci.yml - Advanced Example
include:
  - template: Security/SAST.gitlab-ci.yml
  - template: Security/Dependency-Scanning.gitlab-ci.yml
  - template: Security/Container-Scanning.gitlab-ci.yml
  - local: '.gitlab/ci/build.yml'
  - local: '.gitlab/ci/deploy.yml'

stages:
  - validate
  - build
  - test
  - security
  - package
  - deploy
  - post-deploy

variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"
  DOCKER_IMAGE_TAG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
  KUBECONFIG: /tmp/kubeconfig

workflow:
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
    - if: '$CI_COMMIT_BRANCH && $CI_OPEN_MERGE_REQUESTS'
      when: never
    - if: '$CI_COMMIT_BRANCH'

# Validate stage
validate_yaml:
  stage: validate
  image: alpine:latest
  before_script:
    - apk add --no-cache yamllint
  script:
    - yamllint -d relaxed .gitlab-ci.yml
    - yamllint -d relaxed docker-compose.yml
  rules:
    - changes:
        - "*.yml"
        - "*.yaml"

validate_dockerfile:
  stage: validate
  image: hadolint/hadolint:latest-debian
  script:
    - hadolint Dockerfile
  rules:
    - changes:
        - "Dockerfile*"

# Build stage
build_application:
  stage: build
  image: node:16-alpine
  services:
    - docker:20.10.16-dind
  variables:
    DOCKER_HOST: tcp://docker:2376
    DOCKER_TLS_CERTDIR: "/certs"
  before_script:
    - docker info
    - echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY
  script:
    - docker build --pull -t $DOCKER_IMAGE_TAG .
    - docker push $DOCKER_IMAGE_TAG
    - docker tag $DOCKER_IMAGE_TAG $CI_REGISTRY_IMAGE:latest
    - docker push $CI_REGISTRY_IMAGE:latest
  after_script:
    - docker logout $CI_REGISTRY
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour
  retry:
    max: 2
    when:
      - runner_system_failure
      - stuck_or_timeout_failure

# Test stage with parallel jobs
.test_template: &test_template
  stage: test
  image: node:16-alpine
  dependencies:
    - build_application
  before_script:
    - npm ci --cache .npm --prefer-offline
  retry: 1

test_unit:
  <<: *test_template
  script:
    - npm run test:unit -- --reporter=junit --outputFile=junit-unit.xml
  artifacts:
    reports:
      junit: junit-unit.xml
    paths:
      - coverage/
    expire_in: 1 day
  parallel:
    matrix:
      - NODE_ENV: [test, development]

test_integration:
  <<: *test_template
  services:
    - name: postgres:13-alpine
      alias: postgres
    - name: redis:6-alpine
      alias: redis
  variables:
    POSTGRES_DB: test_db
    POSTGRES_USER: test_user
    POSTGRES_PASSWORD: test_password
    POSTGRES_HOST_AUTH_METHOD: trust
    REDIS_URL: redis://redis:6379
  script:
    - npm run test:integration -- --reporter=junit --outputFile=junit-integration.xml
  artifacts:
    reports:
      junit: junit-integration.xml
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'

test_e2e:
  <<: *test_template
  services:
    - name: selenium/standalone-chrome:latest
      alias: selenium
  variables:
    SELENIUM_HOST: selenium
    SELENIUM_PORT: 4444
  script:
    - npm run test:e2e
  artifacts:
    when: always
    paths:
      - cypress/videos/
      - cypress/screenshots/
    expire_in: 1 week

# Security stage
security_sast:
  stage: security
  allow_failure: true
  artifacts:
    reports:
      sast: gl-sast-report.json

security_container_scanning:
  stage: security
  variables:
    DOCKER_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
    DOCKERFILE_PATH: "Dockerfile"
  allow_failure: true

security_dependency_scanning:
  stage: security
  allow_failure: true
  artifacts:
    reports:
      dependency_scanning: gl-dependency-scanning-report.json

# Package stage
package_helm:
  stage: package
  image: alpine/helm:latest
  script:
    - helm package ./helm/myapp --version $CI_COMMIT_REF_SLUG
    - helm repo index . --url $CI_PROJECT_URL/-/packages/helm/stable
  artifacts:
    paths:
      - "*.tgz"
      - index.yaml
  only:
    - main
    - tags

# Deploy stages with environments
.deploy_template: &deploy_template
  stage: deploy
  image: bitnami/kubectl:latest
  before_script:
    - echo $KUBE_CONFIG | base64 -d > $KUBECONFIG
    - kubectl cluster-info

deploy_review:
  <<: *deploy_template
  script:
    - kubectl create namespace review-$CI_MERGE_REQUEST_IID || true
    - kubectl apply -f k8s/ -n review-$CI_MERGE_REQUEST_IID
    - kubectl set image deployment/myapp myapp=$DOCKER_IMAGE_TAG -n review-$CI_MERGE_REQUEST_IID
  environment:
    name: review/$CI_COMMIT_REF_NAME
    url: https://review-$CI_MERGE_REQUEST_IID.example.com
    on_stop: stop_review
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'

stop_review:
  <<: *deploy_template
  script:
    - kubectl delete namespace review-$CI_MERGE_REQUEST_IID
  environment:
    name: review/$CI_COMMIT_REF_NAME
    action: stop
  when: manual
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'

deploy_staging:
  <<: *deploy_template
  script:
    - kubectl apply -f k8s/ -n staging
    - kubectl set image deployment/myapp myapp=$DOCKER_IMAGE_TAG -n staging
    - kubectl rollout status deployment/myapp -n staging --timeout=300s
  environment:
    name: staging
    url: https://staging.example.com
  rules:
    - if: '$CI_COMMIT_BRANCH == "develop"'

deploy_production:
  <<: *deploy_template
  script:
    - kubectl apply -f k8s/ -n production
    - kubectl set image deployment/myapp myapp=$DOCKER_IMAGE_TAG -n production
    - kubectl rollout status deployment/myapp -n production --timeout=300s
  environment:
    name: production
    url: https://example.com
  when: manual
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'

# Post-deploy stage
smoke_tests:
  stage: post-deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache curl
  script:
    - curl -f https://staging.example.com/health || exit 1
    - curl -f https://staging.example.com/api/status || exit 1
  dependencies: []
  rules:
    - if: '$CI_COMMIT_BRANCH == "develop"'
      when: delayed
      start_in: 2 minutes

notify_slack:
  stage: post-deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache curl
  script:
    - |
      curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"🚀 Deployment to $CI_ENVIRONMENT_NAME completed successfully!\\n*Project:* $CI_PROJECT_NAME\\n*Branch:* $CI_COMMIT_REF_NAME\\n*Commit:* $CI_COMMIT_SHORT_SHA\\n*Pipeline:* $CI_PIPELINE_URL\"}" \
        $SLACK_WEBHOOK_URL
  when: on_success
  dependencies: []
  rules:
    - if: '$CI_COMMIT_BRANCH == "main" || $CI_COMMIT_BRANCH == "develop"'
```

---

## Jobs, Stages, and Workflows

### Job Lifecycle

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Created   │───▶│   Pending   │───▶│  Running    │───▶│ Completed   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                          │                   │                   │
                          ▼                   ▼                   ▼
                   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
                   │   Skipped   │    │   Failed    │    │  Success    │
                   └─────────────┘    └─────────────┘    └─────────────┘
```

### Job Rules and Conditions

```yaml
# Advanced job rules
deploy_production:
  script:
    - echo "Deploying to production"
  rules:
    # Run for main branch commits
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: manual
      allow_failure: false
    # Run for tags starting with 'v'
    - if: '$CI_COMMIT_TAG =~ /^v\d+\.\d+\.\d+$/'
      when: delayed
      start_in: 5 minutes
    # Skip for draft merge requests
    - if: '$CI_MERGE_REQUEST_TITLE =~ /^(Draft|WIP):/'
      when: never
    # Run for merge requests to main
    - if: '$CI_MERGE_REQUEST_TARGET_BRANCH_NAME == "main"'
      changes:
        - "src/**/*"
        - "Dockerfile"
        - "package.json"

# Conditional job execution
test_performance:
  script:
    - npm run test:performance
  rules:
    - if: '$PERFORMANCE_TESTS == "true"'
    - if: '$CI_COMMIT_BRANCH == "main"'
      changes:
        - "performance/**/*"
      when: manual
    - if: '$CI_COMMIT_MESSAGE =~ /\[perf\]/'

# Complex workflow rules
workflow:
  rules:
    # Don't run pipelines for merge requests AND branch commits simultaneously
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
    - if: '$CI_COMMIT_BRANCH && $CI_OPEN_MERGE_REQUESTS'
      when: never
    # Run for protected branches
    - if: '$CI_COMMIT_REF_PROTECTED == "true"'
    # Run for tags
    - if: '$CI_COMMIT_TAG'
    # Manual trigger with custom variables
    - if: '$CI_PIPELINE_SOURCE == "web" && $CUSTOM_PIPELINE == "true"'
```

### Parallel Jobs and Matrix

```yaml
# Parallel execution with matrix
test_matrix:
  image: node:$NODE_VERSION-alpine
  script:
    - npm ci
    - npm test
  parallel:
    matrix:
      - NODE_VERSION: ["14", "16", "18"]
        DATABASE: ["postgres", "mysql"]
        OS: ["alpine", "ubuntu"]

# Parallel execution with number
test_parallel:
  script:
    - echo "Running parallel job $CI_NODE_INDEX of $CI_NODE_TOTAL"
    - npm run test:parallel -- --ci-node-index=$CI_NODE_INDEX --ci-node-total=$CI_NODE_TOTAL
  parallel: 5

# Dynamic parallel jobs
generate_tests:
  stage: build
  script:
    - echo "test1 test2 test3" > test-list.txt
  artifacts:
    paths:
      - test-list.txt

run_dynamic_tests:
  stage: test
  script:
    - |
      while read test; do
        echo "Running test: $test"
        npm run test:$test
      done < test-list.txt
  dependencies:
    - generate_tests
```

### Job Dependencies and Needs

```yaml
# Traditional stage-based execution
stages:
  - build
  - test
  - deploy

build_app:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/

test_unit:
  stage: test
  script:
    - npm run test:unit
  dependencies:
    - build_app

test_integration:
  stage: test
  script:
    - npm run test:integration
  dependencies:
    - build_app

# Optimized execution with 'needs'
build_app:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/

test_unit:
  stage: test
  script:
    - npm run test:unit
  needs:
    - job: build_app
      artifacts: true

test_integration:
  stage: test
  script:
    - npm run test:integration
  needs:
    - job: build_app
      artifacts: true

# Deploy can start as soon as unit tests pass
deploy_staging:
  stage: deploy
  script:
    - npm run deploy
  needs:
    - job: test_unit
      artifacts: false
  environment:
    name: staging

# Complex dependency graph
deploy_production:
  stage: deploy
  script:
    - npm run deploy:production
  needs:
    - job: test_unit
    - job: test_integration
    - job: security_scan
      artifacts: false
  when: manual
```

---

## Variables and Secrets Management

### Variable Types and Precedence

```
Project Variables (Lowest Priority)
       ↓
Group Variables
       ↓
Instance Variables
       ↓
Pipeline Variables
       ↓
Job Variables
       ↓
Predefined Variables (Highest Priority)
```

### Predefined Variables

```yaml
# Common GitLab CI/CD Variables
job_info:
  script:
    - echo "Pipeline ID: $CI_PIPELINE_ID"
    - echo "Job ID: $CI_JOB_ID"
    - echo "Commit SHA: $CI_COMMIT_SHA"
    - echo "Commit Ref Name: $CI_COMMIT_REF_NAME"
    - echo "Branch: $CI_COMMIT_BRANCH"
    - echo "Tag: $CI_COMMIT_TAG"
    - echo "Project Name: $CI_PROJECT_NAME"
    - echo "Project URL: $CI_PROJECT_URL"
    - echo "Registry: $CI_REGISTRY"
    - echo "Registry Image: $CI_REGISTRY_IMAGE"
    - echo "Runner ID: $CI_RUNNER_ID"
    - echo "Environment Name: $CI_ENVIRONMENT_NAME"
    - echo "Environment URL: $CI_ENVIRONMENT_URL"
```

### Custom Variables

```yaml
# Global variables
variables:
  DEPLOY_ENVIRONMENT: "staging"
  APP_VERSION: "1.0.0"
  DATABASE_URL: "postgresql://localhost:5432/myapp"
  # Masked variable (hidden in logs)
  API_TOKEN: "${CI_API_TOKEN}"
  # Protected variable (only for protected branches/tags)
  PRODUCTION_KEY: "${PROD_DEPLOY_KEY}"
  # File variable (stored as file)
  SERVICE_ACCOUNT_KEY: "${GCP_SERVICE_ACCOUNT}"

# Job-specific variables
deploy_job:
  variables:
    DEPLOYMENT_TIER: "production"
    REPLICAS: "3"
  script:
    - echo "Deploying $REPLICAS replicas to $DEPLOYMENT_TIER"
    - kubectl scale deployment myapp --replicas=$REPLICAS

# Conditional variables
variables:
  DATABASE_URL:
    value: "postgresql://prod-server:5432/myapp"
    description: "Database connection string"
  APP_ENV:
    value: "production"
    description: "Application environment"
  DEBUG_MODE:
    value: "false"
    description: "Enable debug mode"
    options:
      - "true"
      - "false"
```

### Secrets Management

```yaml
# Using GitLab Variables for Secrets
deploy_with_secrets:
  script:
    # Kubernetes secrets
    - kubectl create secret generic app-secrets \
        --from-literal=database-url="$DATABASE_URL" \
        --from-literal=api-key="$API_KEY" \
        --dry-run=client -o yaml | kubectl apply -f -
    
    # Docker registry authentication
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    
    # AWS credentials
    - aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    - aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    - aws configure set default.region $AWS_DEFAULT_REGION
  
# Using external secret management
deploy_with_vault:
  before_script:
    - export VAULT_ADDR="https://vault.example.com"
    - export VAULT_TOKEN="$VAULT_CI_TOKEN"
    - vault auth -method=jwt role=gitlab-ci jwt=$CI_JOB_JWT
  script:
    - export DATABASE_PASSWORD=$(vault kv get -field=password secret/database)
    - export API_KEY=$(vault kv get -field=api_key secret/external-service)
    - ./deploy.sh

# Azure Key Vault integration
deploy_with_azure_kv:
  before_script:
    - az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
  script:
    - export DB_PASSWORD=$(az keyvault secret show --name database-password --vault-name myapp-kv --query value -o tsv)
    - export API_SECRET=$(az keyvault secret show --name api-secret --vault-name myapp-kv --query value -o tsv)
    - ./deploy.sh

# Using files for secrets
deploy_with_file_secrets:
  variables:
    SERVICE_ACCOUNT_KEY: "$GCP_SERVICE_ACCOUNT_FILE"
    KUBECONFIG_FILE: "$KUBE_CONFIG_FILE"
  script:
    - echo "$SERVICE_ACCOUNT_KEY" > /tmp/service-account.json
    - export GOOGLE_APPLICATION_CREDENTIALS=/tmp/service-account.json
    - echo "$KUBECONFIG_FILE" > /tmp/kubeconfig
    - export KUBECONFIG=/tmp/kubeconfig
    - ./deploy.sh
  after_script:
    - rm -f /tmp/service-account.json /tmp/kubeconfig
```

### Environment-Specific Variables

```yaml
# Environment-specific deployments
.deploy_template: &deploy_template
  script:
    - echo "Deploying to $ENVIRONMENT"
    - echo "Database: $DATABASE_URL"
    - echo "Replicas: $REPLICA_COUNT"
    - ./deploy.sh

deploy_development:
  <<: *deploy_template
  variables:
    ENVIRONMENT: "development"
    DATABASE_URL: "postgresql://dev-db:5432/myapp_dev"
    REPLICA_COUNT: "1"
    DEBUG_MODE: "true"
  environment:
    name: development
    url: https://dev.example.com
  only:
    - develop

deploy_staging:
  <<: *deploy_template
  variables:
    ENVIRONMENT: "staging"
    DATABASE_URL: "postgresql://staging-db:5432/myapp_staging"
    REPLICA_COUNT: "2"
    DEBUG_MODE: "false"
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

deploy_production:
  <<: *deploy_template
  variables:
    ENVIRONMENT: "production"
    DATABASE_URL: "$PRODUCTION_DATABASE_URL"
    REPLICA_COUNT: "5"
    DEBUG_MODE: "false"
    MONITORING_ENABLED: "true"
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
    - tags
```

---

## Docker Integration

### Docker-in-Docker (DinD)

```yaml
# Docker-in-Docker setup
.docker_build: &docker_build
  image: docker:20.10.16
  services:
    - docker:20.10.16-dind
  variables:
    DOCKER_HOST: tcp://docker:2376
    DOCKER_TLS_CERTDIR: "/certs"
    DOCKER_TLS_VERIFY: 1
    DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
  before_script:
    - docker info
    - echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY

build_docker_image:
  <<: *docker_build
  stage: build
  script:
    # Build multi-platform image
    - docker buildx create --use
    - docker buildx build --platform linux/amd64,linux/arm64 -t $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG --push .
    
    # Traditional build
    - docker build --pull -t $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG .
    - docker tag $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG $CI_REGISTRY_IMAGE:latest
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
    - docker push $CI_REGISTRY_IMAGE:latest
  
  # Save image as artifact
  after_script:
    - docker save $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG | gzip > image.tar.gz
  artifacts:
    paths:
      - image.tar.gz
    expire_in: 1 day
```

### Multi-Stage Dockerfile with GitLab CI

```dockerfile
# Multi-stage Dockerfile optimized for GitLab CI
# Build stage
FROM node:16-alpine AS builder

WORKDIR /app

# Copy package files for better caching
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy source code
COPY . .

# Build application
RUN npm run build

# Production stage
FROM node:16-alpine AS production

# Add security updates
RUN apk update && apk upgrade && apk add --no-cache dumb-init

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001

WORKDIR /app

# Copy built application
COPY --from=builder --chown=nextjs:nodejs /app/dist ./dist
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/package*.json ./

# Switch to non-root user
USER nextjs

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Expose port
EXPOSE 3000

# Use dumb-init as PID 1
ENTRYPOINT ["dumb-init", "--"]

# Start application
CMD ["node", "dist/server.js"]
```

### Container Scanning and Security

```yaml
# Container security scanning
include:
  - template: Security/Container-Scanning.gitlab-ci.yml

variables:
  CS_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
  CS_DOCKERFILE_PATH: "Dockerfile"

container_scanning:
  stage: security
  variables:
    DOCKER_IMAGE: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
    DOCKERFILE_PATH: "Dockerfile"
  allow_failure: true
  artifacts:
    reports:
      container_scanning: gl-container-scanning-report.json
  dependencies:
    - build_docker_image

# Custom Trivy scanning
trivy_scan:
  stage: security
  image: aquasec/trivy:latest
  services:
    - docker:20.10.16-dind
  variables:
    DOCKER_HOST: tcp://docker:2376
    DOCKER_TLS_CERTDIR: "/certs"
  script:
    # Scan filesystem
    - trivy fs --format template --template "@contrib/gitlab.tpl" -o gl-container-scanning-report.json .
    
    # Scan Docker image
    - trivy image --format template --template "@contrib/gitlab.tpl" -o gl-container-scanning-report.json $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
    
    # Scan for secrets
    - trivy fs --scanners secret --format table .
  artifacts:
    reports:
      container_scanning: gl-container-scanning-report.json
  allow_failure: true
```

### Docker Compose Integration

```yaml
# Docker Compose testing environment
test_with_compose:
  stage: test
  image: docker/compose:latest
  services:
    - docker:20.10.16-dind
  variables:
    DOCKER_HOST: tcp://docker:2376
    DOCKER_TLS_CERTDIR: "/certs"
  before_script:
    - docker-compose --version
    - docker info
  script:
    # Start test environment
    - docker-compose -f docker-compose.test.yml up -d
    - docker-compose -f docker-compose.test.yml exec -T web npm run test
    - docker-compose -f docker-compose.test.yml exec -T web npm run test:integration
  after_script:
    - docker-compose -f docker-compose.test.yml down -v
    - docker-compose -f docker-compose.test.yml logs
  artifacts:
    reports:
      junit: test-results.xml
    paths:
      - coverage/
```

---

## Kubernetes Integration

### Kubernetes Deployment Pipeline

```yaml
# Kubernetes deployment pipeline
.k8s_deploy_template: &k8s_deploy
  image: bitnami/kubectl:latest
  before_script:
    - echo $KUBE_CONFIG | base64 -d > $KUBECONFIG
    - kubectl version --client
    - kubectl cluster-info

deploy_to_k8s:
  <<: *k8s_deploy
  stage: deploy
  script:
    # Create namespace if it doesn't exist
    - kubectl create namespace $KUBE_NAMESPACE || true
    
    # Apply ConfigMaps and Secrets
    - kubectl apply -f k8s/configmap.yaml -n $KUBE_NAMESPACE
    - kubectl apply -f k8s/secret.yaml -n $KUBE_NAMESPACE
    
    # Deploy application
    - envsubst < k8s/deployment.yaml | kubectl apply -f - -n $KUBE_NAMESPACE
    - envsubst < k8s/service.yaml | kubectl apply -f - -n $KUBE_NAMESPACE
    - envsubst < k8s/ingress.yaml | kubectl apply -f - -n $KUBE_NAMESPACE
    
    # Wait for deployment
    - kubectl rollout status deployment/$APP_NAME -n $KUBE_NAMESPACE --timeout=600s
    
    # Get deployment info
    - kubectl get pods -n $KUBE_NAMESPACE -l app=$APP_NAME
    - kubectl get svc -n $KUBE_NAMESPACE -l app=$APP_NAME
  variables:
    KUBE_NAMESPACE: "default"
    APP_NAME: "myapp"
    IMAGE_TAG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
```

### Helm Integration

```yaml
# Helm deployment
.helm_deploy: &helm_deploy
  image: alpine/helm:latest
  before_script:
    - echo $KUBE_CONFIG | base64 -d > $KUBECONFIG
    - helm version

deploy_with_helm:
  <<: *helm_deploy
  stage: deploy
  script:
    # Add Helm repositories
    - helm repo add stable https://charts.helm.sh/stable
    - helm repo add bitnami https://charts.bitnami.com/bitnami
    - helm repo update
    
    # Install/upgrade application
    - |
      helm upgrade --install $APP_NAME ./helm/myapp \
        --namespace $KUBE_NAMESPACE \
        --create-namespace \
        --set image.repository=$CI_REGISTRY_IMAGE \
        --set image.tag=$CI_COMMIT_REF_SLUG \
        --set environment=$ENVIRONMENT \
        --set replicas=$REPLICAS \
        --set ingress.hosts[0].host=$HOSTNAME \
        --set ingress.hosts[0].paths[0].path="/" \
        --set ingress.hosts[0].paths[0].pathType="Prefix" \
        --values ./helm/myapp/values-$ENVIRONMENT.yaml \
        --wait --timeout=10m
  
  # Rollback on failure
  after_script:
    - |
      if [ $CI_JOB_STATUS == "failed" ]; then
        echo "Deployment failed, rolling back..."
        helm rollback $APP_NAME -n $KUBE_NAMESPACE
      fi
  
  variables:
    APP_NAME: "myapp"
    KUBE_NAMESPACE: "default"
    ENVIRONMENT: "staging"
    REPLICAS: "2"
    HOSTNAME: "staging.example.com"
```

### Kubernetes Manifests with GitLab CI

```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${APP_NAME}
  namespace: ${KUBE_NAMESPACE}
  labels:
    app: ${APP_NAME}
    version: ${CI_COMMIT_REF_SLUG}
spec:
  replicas: ${REPLICAS}
  selector:
    matchLabels:
      app: ${APP_NAME}
  template:
    metadata:
      labels:
        app: ${APP_NAME}
        version: ${CI_COMMIT_REF_SLUG}
    spec:
      containers:
      - name: ${APP_NAME}
        image: ${IMAGE_TAG}
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "${NODE_ENV}"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: ${APP_NAME}-secrets
              key: database-url
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
```

### Auto DevOps with Kubernetes

```yaml
# Auto DevOps configuration
include:
  - template: Auto-DevOps.gitlab-ci.yml

variables:
  AUTO_DEVOPS_DOMAIN: example.com
  POSTGRES_ENABLED: true
  POSTGRES_VERSION: 13
  REDIS_ENABLED: true
  
# Override Auto DevOps stages
production:
  extends: .auto-deploy
  stage: production
  script:
    - auto-deploy check_kube_domain
    - auto-deploy download_chart
    - auto-deploy use_kube_context
    - auto-deploy initialize_tiller
    - auto-deploy create_secret
    - auto-deploy deploy
  environment:
    name: production
    url: https://$CI_PROJECT_PATH_SLUG.$AUTO_DEVOPS_DOMAIN
  when: manual
  only:
    refs:
      - main
    kubernetes: active
```

---

## GitLab Registry

### Using GitLab Container Registry

```yaml
# Registry operations
variables:
  REGISTRY_IMAGE: $CI_REGISTRY_IMAGE
  IMAGE_TAG: $CI_COMMIT_REF_SLUG

build_and_push:
  stage: build
  image: docker:20.10.16
  services:
    - docker:20.10.16-dind
  before_script:
    - echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY
  script:
    # Build image
    - docker build -t $REGISTRY_IMAGE:$IMAGE_TAG .
    - docker tag $REGISTRY_IMAGE:$IMAGE_TAG $REGISTRY_IMAGE:latest
    
    # Push to registry
    - docker push $REGISTRY_IMAGE:$IMAGE_TAG
    - docker push $REGISTRY_IMAGE:latest
    
    # Add additional tags
    - |
      if [ "$CI_COMMIT_BRANCH" == "main" ]; then
        docker tag $REGISTRY_IMAGE:$IMAGE_TAG $REGISTRY_IMAGE:stable
        docker push $REGISTRY_IMAGE:stable
      fi
  after_script:
    - docker logout $CI_REGISTRY

# Multi-architecture builds
build_multiarch:
  stage: build
  image: docker:20.10.16
  services:
    - docker:20.10.16-dind
  before_script:
    - docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    - docker buildx create --use --name multiarch-builder
    - echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY
  script:
    - |
      docker buildx build \
        --platform linux/amd64,linux/arm64 \
        --tag $REGISTRY_IMAGE:$IMAGE_TAG \
        --tag $REGISTRY_IMAGE:latest \
        --push .
```

### Registry Cleanup and Management

```yaml
# Registry cleanup job
registry_cleanup:
  stage: cleanup
  image: alpine:latest
  before_script:
    - apk add --no-cache curl jq
  script:
    # Get list of tags
    - |
      TAGS=$(curl -s -H "PRIVATE-TOKEN: $CI_JOB_TOKEN" \
        "$CI_API_V4_URL/projects/$CI_PROJECT_ID/registry/repositories" | \
        jq -r '.[0].id')
    
    # Delete old tags (keep last 10)
    - |
      curl -s -H "PRIVATE-TOKEN: $CI_JOB_TOKEN" \
        "$CI_API_V4_URL/projects/$CI_PROJECT_ID/registry/repositories/$TAGS/tags" | \
        jq -r '.[] | select(.created_at < (now - 86400 * 30 | todate)) | .name' | \
        head -n -10 | \
        while read tag; do
          echo "Deleting tag: $tag"
          curl -X DELETE -H "PRIVATE-TOKEN: $CI_JOB_TOKEN" \
            "$CI_API_V4_URL/projects/$CI_PROJECT_ID/registry/repositories/$TAGS/tags/$tag"
        done
  rules:
    - if: '$CI_PIPELINE_SOURCE == "schedule"'
    - when: manual
```

### Registry Security Scanning

```yaml
# Container vulnerability scanning
registry_scan:
  stage: security
  image: aquasec/trivy:latest
  script:
    # Scan latest image in registry
    - trivy image --exit-code 1 --severity HIGH,CRITICAL $CI_REGISTRY_IMAGE:latest
    
    # Generate report
    - trivy image --format template --template "@contrib/gitlab.tpl" -o gl-container-scanning-report.json $CI_REGISTRY_IMAGE:latest
  artifacts:
    reports:
      container_scanning: gl-container-scanning-report.json
  allow_failure: true
```

---

## Security and Compliance

### SAST (Static Application Security Testing)

```yaml
include:
  - template: Security/SAST.gitlab-ci.yml

# Custom SAST configuration
variables:
  SAST_EXCLUDED_PATHS: spec, test, tests, tmp, node_modules
  SAST_EXCLUDED_ANALYZERS: bandit, brakeman, eslint, flawfinder, gosec, kubesec, nodejs-scan, phpcs-security-audit, pmd-apex, security-code-scan, semgrep, sobelow, spotbugs

# Override SAST job
sast:
  stage: security
  artifacts:
    reports:
      sast: gl-sast-report.json
  allow_failure: true

# Custom security scanning with SonarQube
sonarqube_scan:
  stage: security
  image: sonarsource/sonar-scanner-cli:latest
  variables:
    SONAR_USER_HOME: "${CI_PROJECT_DIR}/.sonar"
    GIT_DEPTH: "0"
  cache:
    key: "${CI_JOB_NAME}"
    paths:
      - .sonar/cache
  script:
    - sonar-scanner
  allow_failure: true
  only:
    - main
    - merge_requests
```

### Dependency Scanning

```yaml
include:
  - template: Security/Dependency-Scanning.gitlab-ci.yml

# Custom dependency scanning
dependency_scanning:
  stage: security
  artifacts:
    reports:
      dependency_scanning: gl-dependency-scanning-report.json
  allow_failure: true

# NPM audit
npm_audit:
  stage: security
  image: node:16-alpine
  script:
    - npm audit --audit-level=high
    - npm audit --json > npm-audit-report.json
  artifacts:
    paths:
      - npm-audit-report.json
    reports:
      dependency_scanning: npm-audit-report.json
  allow_failure: true
```

### Secret Detection

```yaml
include:
  - template: Security/Secret-Detection.gitlab-ci.yml

# Custom secret detection
secret_detection:
  stage: security
  artifacts:
    reports:
      secret_detection: gl-secret-detection-report.json
  allow_failure: true

# GitLeaks secret scanning
gitleaks_scan:
  stage: security
  image: zricethezav/gitleaks:latest
  script:
    - gitleaks detect --source . --report-format json --report-path gitleaks-report.json
  artifacts:
    paths:
      - gitleaks-report.json
  allow_failure: true
```

### License Compliance

```yaml
include:
  - template: Security/License-Scanning.gitlab-ci.yml

license_scanning:
  stage: security
  artifacts:
    reports:
      license_scanning: gl-license-scanning-report.json
  allow_failure: true

# Custom license checking
check_licenses:
  stage: security
  image: node:16-alpine
  script:
    - npm install -g license-checker
    - license-checker --onlyAllow 'MIT;Apache-2.0;BSD-2-Clause;BSD-3-Clause;ISC' --production
    - license-checker --json --production > licenses.json
  artifacts:
    paths:
      - licenses.json
  allow_failure: true
```

### Compliance and Governance

```yaml
# Compliance pipeline
compliance_check:
  stage: compliance
  image: alpine:latest
  script:
    # Check branch protection
    - |
      if [ "$CI_COMMIT_REF_PROTECTED" != "true" ] && [ "$CI_COMMIT_BRANCH" == "main" ]; then
        echo "ERROR: Main branch is not protected"
        exit 1
      fi
    
    # Check required approvals for merge requests
    - |
      if [ -n "$CI_MERGE_REQUEST_IID" ]; then
        APPROVALS=$(curl -s -H "PRIVATE-TOKEN: $CI_JOB_TOKEN" \
          "$CI_API_V4_URL/projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/approvals" | \
          jq '.approvals_left')
        if [ "$APPROVALS" -gt 0 ]; then
          echo "ERROR: Merge request requires $APPROVALS more approvals"
          exit 1
        fi
      fi
    
    # Check commit message format
    - |
      if ! echo "$CI_COMMIT_MESSAGE" | grep -E "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+"; then
        echo "WARNING: Commit message doesn't follow conventional format"
      fi
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
    - if: '$CI_MERGE_REQUEST_IID'
```

---

## Monitoring and Analytics

### Pipeline Monitoring

```yaml
# Pipeline metrics and monitoring
pipeline_metrics:
  stage: post-deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache curl jq
  script:
    # Send metrics to monitoring system
    - |
      curl -X POST "https://metrics.example.com/api/v1/metrics" \
        -H "Authorization: Bearer $METRICS_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "pipeline_id": "'$CI_PIPELINE_ID'",
          "project_id": "'$CI_PROJECT_ID'",
          "commit_sha": "'$CI_COMMIT_SHA'",
          "branch": "'$CI_COMMIT_BRANCH'",
          "status": "success",
          "duration": "'$CI_JOB_STARTED_AT'",
          "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"
        }'
    
    # Send Slack notification
    - |
      curl -X POST -H 'Content-type: application/json' \
        --data '{
          "text": ":rocket: Deployment successful!",
          "attachments": [{
            "color": "good",
            "fields": [
              {"title": "Project", "value": "'$CI_PROJECT_NAME'", "short": true},
              {"title": "Branch", "value": "'$CI_COMMIT_BRANCH'", "short": true},
              {"title": "Commit", "value": "'$CI_COMMIT_SHORT_SHA'", "short": true},
              {"title": "Pipeline", "value": "<'$CI_PIPELINE_URL'|#'$CI_PIPELINE_ID'>", "short": true}
            ]
          }]
        }' $SLACK_WEBHOOK_URL
  when: on_success
```

### Application Performance Monitoring

```yaml
# APM integration
apm_setup:
  stage: post-deploy
  image: alpine:latest
  script:
    # Register deployment with APM
    - |
      curl -X POST "https://apm.example.com/api/deployments" \
        -H "Authorization: Bearer $APM_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "revision": "'$CI_COMMIT_SHA'",
          "environment": "'$CI_ENVIRONMENT_NAME'",
          "description": "'$CI_COMMIT_MESSAGE'",
          "user": "'$GITLAB_USER_NAME'",
          "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"
        }'
    
    # Create synthetic monitoring check
    - |
      curl -X POST "https://monitoring.example.com/api/v1/checks" \
        -H "Authorization: Bearer $MONITORING_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{
          "name": "'$CI_PROJECT_NAME'-'$CI_ENVIRONMENT_NAME'",
          "url": "'$CI_ENVIRONMENT_URL'",
          "interval": 60,
          "timeout": 10
        }'
```

### Test Coverage and Quality Gates

```yaml
# Test coverage and quality metrics
test_coverage:
  stage: test
  image: node:16-alpine
  script:
    - npm ci
    - npm run test:coverage
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura.xml
    paths:
      - coverage/
    expire_in: 1 week

# Quality gate check
quality_gate:
  stage: test
  image: alpine:latest
  before_script:
    - apk add --no-cache jq
  script:
    # Extract coverage percentage
    - COVERAGE=$(grep -o 'line-rate="[^"]*"' coverage/cobertura.xml | head -1 | grep -o '[0-9.]*')
    - COVERAGE_PERCENT=$(echo "$COVERAGE * 100" | bc)
    
    # Check coverage threshold
    - |
      if (( $(echo "$COVERAGE_PERCENT < 80" | bc -l) )); then
        echo "Coverage $COVERAGE_PERCENT% is below threshold of 80%"
        exit 1
      fi
    
    # Check for critical security vulnerabilities
    - |
      if [ -f gl-sast-report.json ]; then
        CRITICAL_VULNS=$(jq '[.vulnerabilities[] | select(.severity == "Critical")] | length' gl-sast-report.json)
        if [ "$CRITICAL_VULNS" -gt 0 ]; then
          echo "Found $CRITICAL_VULNS critical vulnerabilities"
          exit 1
        fi
      fi
    
    echo "All quality gates passed!"
  dependencies:
    - test_coverage
    - sast
```

---

## Advanced Pipeline Patterns

### Dynamic Child Pipelines

```yaml
# Parent pipeline
generate_child_pipeline:
  stage: generate
  image: alpine:latest
  script:
    - |
      cat > child-pipeline.yml << EOF
      stages:
        - build
        - test
        - deploy

      variables:
        DYNAMIC_VAR: "generated-value"

      build_job:
        stage: build
        script:
          - echo "Building with dynamic configuration"
          - echo "Variable: \$DYNAMIC_VAR"

      test_job:
        stage: test
        script:
          - echo "Testing with generated config"
        parallel:
          matrix:
            - VERSION: ["1.0", "2.0", "3.0"]

      deploy_job:
        stage: deploy
        script:
          - echo "Deploying version \$VERSION"
        when: manual
      EOF
  artifacts:
    paths:
      - child-pipeline.yml

trigger_child_pipeline:
  stage: trigger
  trigger:
    include:
      - artifact: child-pipeline.yml
        job: generate_child_pipeline
    strategy: depend
  dependencies:
    - generate_child_pipeline
```

### Multi-Project Pipelines

```yaml
# Upstream project pipeline
trigger_downstream:
  stage: trigger
  trigger:
    project: group/downstream-project
    branch: main
    strategy: depend
  variables:
    UPSTREAM_COMMIT_SHA: $CI_COMMIT_SHA
    UPSTREAM_PROJECT_ID: $CI_PROJECT_ID

# Cross-project dependencies
deploy_microservices:
  stage: deploy
  trigger:
    project: group/user-service
    branch: main
  parallel:
    matrix:
      - SERVICE: [user-service, payment-service, notification-service]
  variables:
    PARENT_PIPELINE_ID: $CI_PIPELINE_ID
    DEPLOYMENT_ENV: staging
```

### Conditional Pipeline Execution

```yaml
# Conditional workflows based on changes
workflow:
  rules:
    # Full pipeline for main branch
    - if: '$CI_COMMIT_BRANCH == "main"'
    # Limited pipeline for feature branches
    - if: '$CI_COMMIT_BRANCH =~ /^feature\/.*/'
      variables:
        PIPELINE_TYPE: "feature"
    # Documentation-only changes
    - if: '$CI_COMMIT_BRANCH'
      changes:
        - "docs/**/*"
        - "*.md"
      variables:
        PIPELINE_TYPE: "docs-only"
    # API changes trigger integration tests
    - if: '$CI_COMMIT_BRANCH'
      changes:
        - "api/**/*"
        - "schema/**/*"
      variables:
        PIPELINE_TYPE: "api-changes"

# Jobs with conditional execution
build_frontend:
  stage: build
  script:
    - npm run build:frontend
  rules:
    - changes:
        - "frontend/**/*"
        - "package.json"

build_backend:
  stage: build
  script:
    - ./build-backend.sh
  rules:
    - changes:
        - "backend/**/*"
        - "requirements.txt"

integration_tests:
  stage: test
  script:
    - npm run test:integration
  rules:
    - if: '$PIPELINE_TYPE == "api-changes"'
    - if: '$CI_COMMIT_BRANCH == "main"'
    - when: manual
      allow_failure: true

docs_build:
  stage: build
  script:
    - mkdocs build
  rules:
    - if: '$PIPELINE_TYPE == "docs-only"'
    - changes:
        - "docs/**/*"
        - "mkdocs.yml"
```

### Pipeline Templates and Inheritance

```yaml
# .gitlab/ci/templates/deploy.yml
.deploy_template:
  stage: deploy
  image: alpine/helm:latest
  before_script:
    - echo $KUBE_CONFIG | base64 -d > $KUBECONFIG
    - helm repo add stable https://charts.helm.sh/stable
    - helm repo update
  script:
    - |
      helm upgrade --install $APP_NAME ./helm/$APP_NAME \
        --namespace $NAMESPACE \
        --set image.tag=$IMAGE_TAG \
        --set environment=$ENVIRONMENT \
        --values ./helm/$APP_NAME/values-$ENVIRONMENT.yaml
  after_script:
    - kubectl get pods -n $NAMESPACE

# .gitlab/ci/templates/test.yml
.test_template:
  stage: test
  image: node:16-alpine
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - node_modules/
  before_script:
    - npm ci

# Main pipeline using templates
include:
  - local: '.gitlab/ci/templates/deploy.yml'
  - local: '.gitlab/ci/templates/test.yml'

test_unit:
  extends: .test_template
  script:
    - npm run test:unit
  artifacts:
    reports:
      junit: junit.xml

test_integration:
  extends: .test_template
  services:
    - postgres:13
  script:
    - npm run test:integration

deploy_staging:
  extends: .deploy_template
  variables:
    APP_NAME: myapp
    NAMESPACE: staging
    ENVIRONMENT: staging
    IMAGE_TAG: $CI_COMMIT_REF_SLUG
  environment:
    name: staging
    url: https://staging.example.com

deploy_production:
  extends: .deploy_template
  variables:
    APP_NAME: myapp
    NAMESPACE: production
    ENVIRONMENT: production
    IMAGE_TAG: $CI_COMMIT_SHA
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
```

---

## GitOps with GitLab

### GitOps Workflow Setup

```yaml
# GitOps deployment pipeline
stages:
  - build
  - deploy-config
  - sync

variables:
  CONFIG_REPO: "group/k8s-config"
  ARGOCD_SERVER: "argocd.example.com"

# Build and push application
build_image:
  stage: build
  # ... build steps as shown before

# Update deployment configuration
update_deployment_config:
  stage: deploy-config
  image: alpine/git:latest
  before_script:
    - git config --global user.email "gitlab-ci@example.com"
    - git config --global user.name "GitLab CI"
    - git clone https://gitlab-ci-token:${CI_JOB_TOKEN}@gitlab.example.com/${CONFIG_REPO}.git config-repo
  script:
    - cd config-repo
    
    # Update image tag in Kubernetes manifests
    - |
      sed -i "s|image: .*/${CI_PROJECT_NAME}:.*|image: ${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHA}|g" \
        environments/${ENVIRONMENT}/deployment.yaml
    
    # Update Helm values
    - |
      sed -i "s|tag: .*|tag: ${CI_COMMIT_SHA}|g" \
        environments/${ENVIRONMENT}/values.yaml
    
    # Commit and push changes
    - git add .
    - git commit -m "Update ${CI_PROJECT_NAME} to ${CI_COMMIT_SHA}" || exit 0
    - git push origin main
  
  variables:
    ENVIRONMENT: staging
  environment:
    name: staging
  only:
    - main

# Trigger ArgoCD sync
trigger_argocd_sync:
  stage: sync
  image: argoproj/argocd:latest
  script:
    # Login to ArgoCD
    - argocd login $ARGOCD_SERVER --username $ARGOCD_USERNAME --password $ARGOCD_PASSWORD
    
    # Sync application
    - argocd app sync $CI_PROJECT_NAME-$ENVIRONMENT
    - argocd app wait $CI_PROJECT_NAME-$ENVIRONMENT --timeout 300
  
  variables:
    ENVIRONMENT: staging
  dependencies:
    - update_deployment_config
```

### FluxCD Integration

```yaml
# FluxCD GitOps workflow
update_flux_config:
  stage: deploy
  image: fluxcd/flux-cli:latest
  before_script:
    - flux --version
    - git config --global user.email "gitlab-ci@example.com"
    - git config --global user.name "GitLab CI"
  script:
    # Clone GitOps repository
    - git clone https://gitlab-ci-token:${CI_JOB_TOKEN}@gitlab.example.com/group/gitops-repo.git
    - cd gitops-repo
    
    # Update image tag using flux
    - |
      flux create source git myapp-source \
        --url=$CI_PROJECT_URL \
        --branch=main \
        --interval=1m \
        --export > ./clusters/staging/myapp-source.yaml
    
    - |
      flux create kustomization myapp-kustomization \
        --target-namespace=default \
        --source=myapp-source \
        --path="./k8s" \
        --prune=true \
        --interval=5m \
        --export > ./clusters/staging/myapp-kustomization.yaml
    
    # Commit changes
    - git add .
    - git commit -m "Update myapp deployment for commit ${CI_COMMIT_SHA}"
    - git push origin main
  only:
    - main
```

---

## Performance Optimization

### Pipeline Performance Optimization

```yaml
# Optimized pipeline with caching and parallelization
variables:
  DOCKER_DRIVER: overlay2
  DOCKER_TLS_CERTDIR: "/certs"

# Global cache configuration
cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/
    - .npm/
    - dist/
  policy: pull-push

# Build with Docker layer caching
build_optimized:
  stage: build
  image: docker:20.10.16
  services:
    - docker:20.10.16-dind
  before_script:
    - docker info
    - echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER --password-stdin $CI_REGISTRY
  script:
    # Pull previous image for layer caching
    - docker pull $CI_REGISTRY_IMAGE:latest || true
    
    # Build with cache-from
    - |
      docker build \
        --cache-from $CI_REGISTRY_IMAGE:latest \
        --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA \
        --tag $CI_REGISTRY_IMAGE:latest \
        .
    
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
    - docker push $CI_REGISTRY_IMAGE:latest

# Parallel testing with shared cache
.test_base: &test_base
  stage: test
  image: node:16-alpine
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - node_modules/
    policy: pull
  before_script:
    - npm ci --prefer-offline --cache .npm

test_unit:
  <<: *test_base
  script:
    - npm run test:unit
  parallel: 3

test_integration:
  <<: *test_base
  script:
    - npm run test:integration
  parallel: 2

test_e2e:
  <<: *test_base
  script:
    - npm run test:e2e
  parallel: 2

# Conditional job execution for faster pipelines
lint_and_format:
  stage: test
  image: node:16-alpine
  script:
    - npm run lint
    - npm run format:check
  rules:
    - changes:
        - "**/*.js"
        - "**/*.ts"
        - "**/*.vue"
        - ".eslintrc*"
        - ".prettierrc*"
```

### Resource Optimization

```yaml
# Resource-optimized jobs
.resource_limited: &resource_limited
  variables:
    DOCKER_DRIVER: overlay2
    DOCKER_MEMORY: "2g"
    DOCKER_CPUS: "1"

build_small:
  <<: *resource_limited
  stage: build
  image: alpine:latest
  script:
    - echo "Building with limited resources"
  
# Shared services for multiple jobs
services:
  - name: postgres:13-alpine
    alias: postgres
    variables:
      POSTGRES_DB: testdb
      POSTGRES_USER: test
      POSTGRES_PASSWORD: test

.db_test: &db_test
  image: node:16-alpine
  variables:
    DATABASE_URL: "postgresql://test:test@postgres:5432/testdb"

test_with_db_1:
  <<: *db_test
  script:
    - npm run test:db:module1

test_with_db_2:
  <<: *db_test
  script:
    - npm run test:db:module2
```

### Artifact Management

```yaml
# Efficient artifact management
build_artifacts:
  stage: build
  script:
    - make build
  artifacts:
    # Only keep artifacts for downstream jobs
    paths:
      - dist/
    expire_in: 30 minutes
    exclude:
      - "**/*.log"
      - "**/node_modules/**"

test_with_artifacts:
  stage: test
  dependencies:
    - build_artifacts
  script:
    - make test
  artifacts:
    # Keep test results longer
    paths:
      - test-results/
    expire_in: 1 week
    when: always

# Selective artifact passing
deploy_staging:
  stage: deploy
  dependencies:
    - build_artifacts  # Only need build artifacts, not test results
  script:
    - make deploy
```

---

## Troubleshooting

### Common Issues and Solutions

#### Pipeline Failures

```yaml
# Debug pipeline issues
debug_pipeline:
  stage: debug
  script:
    - echo "=== System Information ==="
    - uname -a
    - df -h
    - free -h
    - env | sort
    
    - echo "=== GitLab CI Variables ==="
    - echo "CI_COMMIT_SHA: $CI_COMMIT_SHA"
    - echo "CI_COMMIT_REF_NAME: $CI_COMMIT_REF_NAME"
    - echo "CI_PIPELINE_SOURCE: $CI_PIPELINE_SOURCE"
    - echo "CI_JOB_STAGE: $CI_JOB_STAGE"
    
    - echo "=== Network Connectivity ==="
    - ping -c 3 google.com || true
    - nslookup gitlab.com || true
    
    - echo "=== Docker Information ==="
    - docker version || true
    - docker info || true
  when: manual
```

#### Runner Issues

```bash
# Runner troubleshooting commands

# Check runner status
sudo gitlab-runner status

# View runner logs
sudo gitlab-runner --debug run

# Test runner connectivity
sudo gitlab-runner verify

# Register runner with debug
sudo gitlab-runner register --debug

# Reset runner configuration
sudo gitlab-runner unregister --all-runners
sudo rm /etc/gitlab-runner/config.toml
```

#### Docker Issues

```yaml
# Docker troubleshooting
debug_docker:
  image: docker:20.10.16
  services:
    - docker:20.10.16-dind
  variables:
    DOCKER_HOST: tcp://docker:2376
    DOCKER_TLS_CERTDIR: "/certs"
  script:
    - echo "=== Docker Version ==="
    - docker version
    
    - echo "=== Docker Info ==="
    - docker info
    
    - echo "=== Docker Images ==="
    - docker images
    
    - echo "=== Docker Containers ==="
    - docker ps -a
    
    - echo "=== Docker Networks ==="
    - docker network ls
    
    - echo "=== Docker System ==="
    - docker system df
    - docker system events --since 10m --until 1m || true
  when: manual
```

### Error Handling and Retry Logic

```yaml
# Retry configuration for unreliable operations
deploy_with_retry:
  script:
    - ./deploy.sh
  retry:
    max: 3
    when:
      - runner_system_failure
      - stuck_or_timeout_failure
      - scheduler_failure

# Custom retry logic
deploy_with_custom_retry:
  script:
    - |
      for i in {1..3}; do
        echo "Deployment attempt $i"
        if ./deploy.sh; then
          echo "Deployment successful"
          break
        else
          if [ $i -eq 3 ]; then
            echo "Deployment failed after 3 attempts"
            exit 1
          fi
          echo "Deployment failed, retrying in 30 seconds..."
          sleep 30
        fi
      done

# Error handling with notifications
deploy_with_error_handling:
  script:
    - ./deploy.sh
  after_script:
    - |
      if [ $CI_JOB_STATUS == "failed" ]; then
        curl -X POST -H 'Content-type: application/json' \
          --data '{"text":"🚨 Deployment failed for '$CI_PROJECT_NAME' on '$CI_COMMIT_REF_NAME'"}' \
          $SLACK_WEBHOOK_URL
      fi
```

### Performance Monitoring

```yaml
# Pipeline performance monitoring
monitor_performance:
  script:
    - START_TIME=$(date +%s)
    - ./run-tests.sh
    - END_TIME=$(date +%s)
    - DURATION=$((END_TIME - START_TIME))
    - echo "Test execution took $DURATION seconds"
    
    # Send metrics to monitoring system
    - |
      curl -X POST "https://metrics.example.com/api/v1/metrics" \
        -d "pipeline.test.duration,project=$CI_PROJECT_NAME,branch=$CI_COMMIT_REF_NAME value=$DURATION"
```

---

## Best Practices

### Pipeline Design Best Practices

1. **Keep Jobs Small and Focused**
```yaml
# Good: Focused job
test_unit:
  script:
    - npm run test:unit

# Bad: Monolithic job
test_everything:
  script:
    - npm run test:unit
    - npm run test:integration
    - npm run test:e2e
    - npm run security:scan
    - npm run lint
```

2. **Use Meaningful Job Names**
```yaml
# Good: Descriptive names
build_frontend_assets:
  script: npm run build:frontend

test_api_endpoints:
  script: npm run test:api

deploy_to_staging_k8s:
  script: kubectl apply -f k8s/

# Bad: Generic names
job1:
  script: npm run build

job2:
  script: npm test

job3:
  script: ./deploy.sh
```

3. **Implement Proper Error Handling**
```yaml
deploy_application:
  script:
    - set -e  # Exit on any error
    - echo "Starting deployment..."
    - ./pre-deploy.sh || { echo "Pre-deploy failed"; exit 1; }
    - ./deploy.sh || { echo "Deployment failed"; ./rollback.sh; exit 1; }
    - ./post-deploy.sh || { echo "Post-deploy failed"; exit 1; }
  after_script:
    - |
      if [ $CI_JOB_STATUS == "failed" ]; then
        echo "Deployment failed, cleaning up..."
        ./cleanup.sh
      fi
```

### Security Best Practices

1. **Never Commit Secrets**
```yaml
# Good: Use variables
deploy:
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD
    - kubectl create secret generic app-secret --from-literal=api-key="$API_KEY"

# Bad: Hardcoded secrets
deploy:
  script:
    - docker login -u user -p password123
    - kubectl create secret generic app-secret --from-literal=api-key="abc123"
```

2. **Use Least Privilege Principle**
```yaml
# Good: Specific permissions
deploy_to_staging:
  script:
    - kubectl apply -f deployment.yaml -n staging
  environment:
    name: staging
  only:
    - develop

# Bad: Overprivileged
deploy_anywhere:
  script:
    - kubectl apply -f deployment.yaml -n $NAMESPACE
  when: manual
```

3. **Scan for Vulnerabilities**
```yaml
# Always include security scanning
include:
  - template: Security/SAST.gitlab-ci.yml
  - template: Security/Dependency-Scanning.gitlab-ci.yml
  - template: Security/Container-Scanning.gitlab-ci.yml
  - template: Security/Secret-Detection.gitlab-ci.yml
```

### Performance Best Practices

1. **Optimize Cache Usage**
```yaml
# Good: Layered caching
cache:
  - key: ${CI_COMMIT_REF_SLUG}-node
    paths:
      - node_modules/
    policy: pull-push
  - key: ${CI_COMMIT_REF_SLUG}-dist
    paths:
      - dist/
    policy: pull-push

# Bad: No caching strategy
build:
  script:
    - npm install  # Always downloads dependencies
    - npm run build
```

2. **Use Parallel Execution**
```yaml
# Good: Parallel tests
test:
  script:
    - npm run test
  parallel: 4

# Bad: Sequential execution
test:
  script:
    - npm run test:unit
    - npm run test:integration
    - npm run test:e2e
```

3. **Minimize Docker Image Size**
```dockerfile
# Good: Multi-stage build
FROM node:16-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:16-alpine AS production
COPY --from=builder /app/node_modules ./node_modules
COPY . .
CMD ["npm", "start"]

# Bad: Single stage with dev dependencies
FROM node:16
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "start"]
```

---

## Interview Questions

### Beginner Level (0-1 years)

**Q1: What is GitLab CI/CD and how does it work?**
A: GitLab CI/CD is a built-in continuous integration and continuous deployment tool that automatically builds, tests, and deploys code. It uses `.gitlab-ci.yml` files to define pipelines that run when code is pushed or merged.

**Q2: What is the difference between GitLab Runner and GitLab CI?**
A: GitLab CI is the service that manages pipelines and jobs, while GitLab Runner is the agent that executes the jobs. Runners can be shared, group-specific, or project-specific.

**Q3: What are stages and jobs in GitLab CI?**
A: Stages are logical groups of jobs that run sequentially (build → test → deploy). Jobs within the same stage run in parallel. Jobs define what scripts to execute.

**Q4: How do you define variables in GitLab CI?**
A: Variables can be defined at multiple levels: globally in the pipeline, per job, in the GitLab UI (project/group/instance settings), or as environment variables in jobs.

**Q5: What is the purpose of artifacts in GitLab CI?**
A: Artifacts are files and directories that are saved after a job completes and can be passed to jobs in later stages or downloaded by users. They're used to share build outputs between jobs.

### Intermediate Level (1-2 years)

**Q6: Explain different GitLab Runner executors and when to use them.**
A: 
- **Shell**: Direct execution on the host, fast but less isolated
- **Docker**: Containerized execution, good isolation and flexibility
- **Kubernetes**: Cloud-native execution, scalable and resource-efficient
- **VirtualBox**: Full VM isolation, highest security but slowest

**Q7: How do you implement conditional job execution in GitLab CI?**
A: Using `rules` with conditions like `if`, `changes`, `exists`, or legacy `only`/`except`. Rules provide more flexibility and are the modern approach.

**Q8: What are the different ways to trigger a GitLab pipeline?**
A: Push events, merge requests, scheduled pipelines, manual triggers, API calls, external webhooks, and triggers from other projects.

**Q9: How do you manage secrets in GitLab CI?**
A: Using GitLab CI/CD variables (masked and protected), external secret management (Vault, AWS Secrets Manager), and file variables for certificates/keys.

**Q10: Explain the concept of needs vs dependencies in GitLab CI.**
A: `dependencies` download artifacts from jobs in previous stages, while `needs` allows jobs to start as soon as their required jobs complete, regardless of stage order.

### Advanced Level (3+ years)

**Q11: How do you implement GitOps with GitLab CI?**
A: By separating application code and configuration repositories, using GitLab CI to build/test applications and update configuration repos, then tools like ArgoCD or Flux sync changes to Kubernetes.

**Q12: Describe advanced pipeline patterns you've implemented.**
A: Multi-project pipelines, parent-child pipelines, dynamic pipeline generation, matrix builds, conditional workflows based on file changes, and pipeline templates for reusability.

**Q13: How do you optimize GitLab pipeline performance?**
A: Caching strategies, parallel job execution, needs-based dependencies, Docker layer caching, artifact management, resource allocation, and conditional job execution.

**Q14: Explain your approach to pipeline security and compliance.**
A: Implementing security scanning (SAST, DAST, dependency scanning), secret management, branch protection, approval workflows, compliance checks, and audit trails.

**Q15: How do you handle complex deployment scenarios with GitLab CI?**
A: Blue-green deployments, canary releases, feature flags, environment-specific configurations, rollback strategies, and integration with service mesh technologies.

---

## Hands-on Labs

### Lab 1: Basic Pipeline Setup

```bash
# Create a new project
mkdir gitlab-ci-lab && cd gitlab-ci-lab
git init
git remote add origin https://gitlab.example.com/username/gitlab-ci-lab.git

# Create a simple Node.js application
cat > package.json << 'EOF'
{
  "name": "gitlab-ci-lab",
  "version": "1.0.0",
  "scripts": {
    "start": "node server.js",
    "test": "echo 'Running tests' && exit 0",
    "lint": "echo 'Running linter' && exit 0"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
EOF

cat > server.js << 'EOF'
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.json({ message: 'Hello GitLab CI!' });
});

app.get('/health', (req, res) => {
    res.status(200).json({ status: 'healthy' });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
EOF

# Create basic GitLab CI pipeline
cat > .gitlab-ci.yml << 'EOF'
stages:
  - build
  - test
  - deploy

variables:
  NODE_VERSION: "16"

cache:
  paths:
    - node_modules/

before_script:
  - node --version
  - npm --version

build_job:
  stage: build
  image: node:$NODE_VERSION-alpine
  script:
    - npm install
    - npm run lint
  artifacts:
    paths:
      - node_modules/
    expire_in: 1 hour

test_job:
  stage: test
  image: node:$NODE_VERSION-alpine
  script:
    - npm test
  dependencies:
    - build_job

deploy_staging:
  stage: deploy
  script:
    - echo "Deploying to staging..."
    - echo "Application URL: https://staging.example.com"
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

deploy_production:
  stage: deploy
  script:
    - echo "Deploying to production..."
    - echo "Application URL: https://example.com"
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
EOF

# Commit and push
git add .
git commit -m "Initial commit with basic GitLab CI pipeline"
git push -u origin main
```

### Lab 2: Docker Integration Pipeline

```bash
# Create Dockerfile
cat > Dockerfile << 'EOF'
FROM node:16-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodeuser -u 1001
RUN chown -R nodeuser:nodejs /app
USER nodeuser

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

# Start application
CMD ["npm", "start"]
EOF

# Advanced GitLab CI pipeline with Docker
cat > .gitlab-ci.yml << 'EOF'
stages:
  - validate
  - build
  - test
  - security
