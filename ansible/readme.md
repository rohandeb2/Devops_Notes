# 🚀 Complete Ansible Guide for DevOps Engineers

> **Professional Notes for Mid-Level DevOps Engineers (3+ Years Experience)**  
> *From Configuration Management to Advanced Automation*

## 📋 Table of Contents

1. [Introduction to Ansible](#-introduction-to-ansible)
2. [Installation and Setup](#-installation-and-setup)
3. [Inventory Management](#-inventory-management)
4. [Ad-hoc Commands](#-ad-hoc-commands)
5. [Ansible Playbooks](#-ansible-playbooks)
6. [Variables and Templating](#-variables-and-templating)
7. [Conditionals and Logic](#-conditionals-and-logic)
8. [Ansible Vault (Security)](#-ansible-vault-security)
9. [Roles and Organization](#-roles-and-organization)
10. [Best Practices](#-best-practices)
11. [Advanced Topics](#-advanced-topics)
12. [Troubleshooting](#-troubleshooting)

---

## 🎯 Introduction to Ansible

### What is Ansible?

Ansible is an open-source IT Configuration Management, Deployment, and Orchestration tool that aims to provide large productivity gains to a wide variety of automation challenges. It's designed to be simple, powerful, and agentless.

### Key Features

- **Agentless Architecture**: No need to install agents on managed nodes
- **SSH-Based Communication**: Uses standard SSH for secure connections
- **YAML Syntax**: Human-readable configuration files
- **Idempotent Operations**: Safe to run multiple times
- **Cross-Platform Support**: Works on Linux, Windows, and cloud platforms

### Ansible Architecture

```
┌─────────────────┐    SSH    ┌─────────────────┐
│  Control Node   │◄────────► │  Managed Node 1 │
│   (Ansible)     │           │                 │
└─────────────────┘           └─────────────────┘
         │                    ┌─────────────────┐
         └─────────────────────│  Managed Node 2 │
                               │                 │
                               └─────────────────┘
```

**Architecture Components:**
- **Control Node**: Machine where Ansible is installed
- **Managed Nodes**: Target machines to be automated
- **Inventory**: List of managed nodes
- **Modules**: Units of code executed on managed nodes
- **Playbooks**: YAML files containing automation instructions

---

## 📦 Installation and Setup

### Prerequisites

- Python 3.8+ on control node
- SSH access to managed nodes
- Sudo privileges (when required)

### Installation Methods

#### Method 1: Using Package Manager (Ubuntu/Debian)

```bash
# Add Ansible PPA repository
sudo apt-add-repository ppa:ansible/ansible

# Update package list
sudo apt update

# Install Ansible
sudo apt install ansible
```

#### Method 2: Using pip (Recommended for latest version)

```bash
# Install pip if not available
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user

# Install Ansible via pip
python -m pip install --user ansible
```

#### Method 3: Using dnf/yum (RHEL/CentOS)

```bash
# RHEL 8/9 or CentOS 8/9
sudo dnf install ansible

# RHEL 7 or CentOS 7
sudo yum install ansible
```

### Verification

```bash
# Check Ansible version
ansible --version

# Check Ansible configuration
ansible-config view
```

---

## 📂 Inventory Management

### Understanding Inventory

The inventory file defines the hosts and groups that Ansible will manage. It's the foundation of your Ansible infrastructure.

### Default Inventory Location

```bash
/etc/ansible/hosts
```

### Basic Inventory Structure

```ini
# Static inventory example
[webservers]
web1 ansible_host=192.168.1.10
web2 ansible_host=192.168.1.11
web3 ansible_host=192.168.1.12

[databases]
db1 ansible_host=192.168.1.20
db2 ansible_host=192.168.1.21

[loadbalancers]
lb1 ansible_host=192.168.1.30

# Group variables
[webservers:vars]
nginx_port=80
php_version=7.4

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user=ubuntu
ansible_ssh_private_key_file=/path/to/private/key.pem
```

### Advanced Inventory Examples

#### Production Environment Example

```ini
[servers]
server1 ansible_host=100.26.220.138
server2 ansible_host=54.210.87.140
server3 ansible_host=54.236.43.216

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/ubuntu/keys/shubham-linux-key.pem
```

### Dynamic Inventory

For cloud environments, use dynamic inventory scripts or plugins:

```bash
# AWS EC2 Dynamic Inventory
ansible-inventory -i aws_ec2.yml --list

# View inventory in YAML format
ansible-inventory --list -y
```

### Inventory Commands

```bash
# List all hosts
ansible-inventory --list

# List hosts in YAML format
ansible-inventory --list -y

# List specific group
ansible-inventory --list --limit webservers
```

---

## ⚡ Ad-hoc Commands

Ad-hoc commands are perfect for quick, one-time tasks across your infrastructure.

### Basic Syntax

```bash
ansible [host-pattern] -m [module] -a "[module options]"
```

### Essential Ad-hoc Commands

#### System Information

```bash
# Test connectivity to all hosts
ansible all -m ping -u ubuntu

# Check disk space
ansible all -a "df -h" -u ubuntu

# Check system uptime
ansible servers -a "uptime" -u ubuntu

# Check memory usage
ansible all -a "free -m" -u ubuntu

# Check running processes
ansible all -a "ps aux" -u ubuntu
```

#### File Operations

```bash
# Copy files to remote hosts
ansible all -m copy -a "src=/local/path/file dest=/remote/path/file"

# Create directories
ansible all -m file -a "path=/tmp/testdir state=directory"

# Change file permissions
ansible all -m file -a "path=/tmp/file mode=0755"

# Download files from URL
ansible all -m get_url -a "url=https://example.com/file dest=/tmp/"
```

#### Package Management

```bash
# Install packages (Ubuntu/Debian)
ansible all -m apt -a "name=nginx state=present" --become

# Install packages (RHEL/CentOS)
ansible all -m yum -a "name=httpd state=present" --become

# Update all packages
ansible all -m apt -a "upgrade=dist" --become

# Remove packages
ansible all -m apt -a "name=apache2 state=absent" --become
```

#### Service Management

```bash
# Start services
ansible all -m service -a "name=nginx state=started" --become

# Stop services
ansible all -m service -a "name=apache2 state=stopped" --become

# Restart services
ansible all -m service -a "name=nginx state=restarted" --become

# Enable services on boot
ansible all -m service -a "name=nginx enabled=yes" --become
```

#### User Management

```bash
# Create users
ansible all -m user -a "name=devops shell=/bin/bash" --become

# Add users to groups
ansible all -m user -a "name=devops groups=sudo append=yes" --become

# Set password (hashed)
ansible all -m user -a "name=devops password={{ 'password' | password_hash('sha512') }}" --become
```

---

## 📜 Ansible Playbooks

Playbooks are the heart of Ansible automation, written in YAML format for defining complex automation workflows.

### Basic Playbook Structure

```yaml
---
- name: Playbook Description
  hosts: target_hosts
  become: yes  # Run with sudo privileges
  vars:
    variable_name: value
  tasks:
    - name: Task description
      module_name:
        parameter1: value1
        parameter2: value2
```

### Simple Examples

#### Date Display Playbook

```yaml
---
- name: Display Current Date
  hosts: servers
  tasks:
    - name: Show current date
      command: date
      register: current_date
    
    - name: Display the date
      debug:
        msg: "Current date is: {{ current_date.stdout }}"
```

#### Nginx Installation Playbook

```yaml
---
- name: Install and Configure Nginx
  hosts: servers
  become: yes
  tasks:
    - name: Update package cache
      apt:
        update_cache: yes
        cache_valid_time: 3600

    - name: Install Nginx
      apt:
        name: nginx
        state: latest

    - name: Start and enable Nginx
      service:
        name: nginx
        state: started
        enabled: yes

    - name: Ensure Nginx is running
      service:
        name: nginx
        state: started
```

### Multi-Service Playbook

```yaml
---
- name: Complete Web Server Setup
  hosts: webservers
  become: yes
  vars:
    packages:
      - nginx
      - git
      - curl
      - vim
    
  tasks:
    - name: Update system packages
      apt:
        update_cache: yes
        upgrade: dist

    - name: Install required packages
      apt:
        name: "{{ packages }}"
        state: latest

    - name: Copy custom index.html
      copy:
        content: |
          <html>
          <head><title>Welcome to Nginx</title></head>
          <body>
          <h1>Server managed by Ansible</h1>
          <p>Hostname: {{ ansible_hostname }}</p>
          <p>IP Address: {{ ansible_default_ipv4.address }}</p>
          </body>
          </html>
        dest: /var/www/html/index.html
        mode: '0644'

    - name: Start and enable services
      service:
        name: "{{ item }}"
        state: started
        enabled: yes
      loop:
        - nginx
```

### Running Playbooks

```bash
# Basic playbook execution
ansible-playbook playbook.yml

# Run with specific inventory
ansible-playbook -i inventory.ini playbook.yml

# Dry run (check mode)
ansible-playbook --check playbook.yml

# Show differences
ansible-playbook --diff playbook.yml

# Limit to specific hosts
ansible-playbook --limit webservers playbook.yml

# Run specific tags
ansible-playbook --tags "nginx,security" playbook.yml

# Skip specific tags
ansible-playbook --skip-tags "testing" playbook.yml

# Verbose output
ansible-playbook -v playbook.yml  # -vv, -vvv for more verbosity
```

---

## 🔧 Variables and Templating

### Variable Types and Precedence

Ansible variables can be defined at multiple levels with specific precedence order:

1. Extra vars (`-e` flag)
2. Task vars
3. Block vars
4. Role and include vars
5. Play vars
6. Host facts
7. Host vars
8. Group vars
9. Role defaults

### Defining Variables

#### In Playbooks

```yaml
---
- name: Variables Example
  hosts: all
  vars:
    package_name: nginx
    service_port: 80
    environment: production
  
  tasks:
    - name: Install {{ package_name }}
      apt:
        name: "{{ package_name }}"
        state: latest
```

#### In Separate Files

**group_vars/all.yml**
```yaml
---
# Global variables
ansible_python_interpreter: /usr/bin/python3
ntp_server: pool.ntp.org
timezone: UTC
```

**group_vars/webservers.yml**
```yaml
---
# Web server specific variables
nginx_port: 80
php_version: "7.4"
max_connections: 1000
```

**host_vars/web1.yml**
```yaml
---
# Host-specific variables
server_role: primary
backup_enabled: true
```

#### Using Variables in Tasks

```yaml
tasks:
  - name: Create user {{ username }}
    user:
      name: "{{ username }}"
      state: present
      shell: "{{ user_shell | default('/bin/bash') }}"
      groups: "{{ user_groups | join(',') }}"

  - name: Install packages
    package:
      name: "{{ item }}"
      state: "{{ package_state | default('present') }}"
    loop: "{{ required_packages }}"
```

### Advanced Variable Usage

#### Registered Variables

```yaml
- name: Get system information
  command: uname -a
  register: system_info

- name: Display system info
  debug:
    msg: "System: {{ system_info.stdout }}"
```

#### Facts and Magic Variables

```yaml
- name: Display system facts
  debug:
    msg: |
      Hostname: {{ ansible_hostname }}
      OS: {{ ansible_distribution }} {{ ansible_distribution_version }}
      Architecture: {{ ansible_architecture }}
      IP Address: {{ ansible_default_ipv4.address }}
      Memory: {{ ansible_memtotal_mb }}MB
```

#### Variable Filters

```yaml
- name: String manipulation
  debug:
    msg: |
      Uppercase: {{ username | upper }}
      Default value: {{ undefined_var | default('fallback') }}
      JSON: {{ complex_var | to_json }}
      Base64: {{ secret | b64encode }}
```

---

## ⚖️ Conditionals and Logic

### When Statements

#### Basic Conditionals

```yaml
---
- name: OS-specific Package Installation
  hosts: servers
  become: yes
  tasks:
    - name: Install Apache on Debian/Ubuntu
      apt:
        name: apache2
        state: latest
      when: ansible_distribution == 'Debian' or ansible_distribution == 'Ubuntu'

    - name: Install Apache on RHEL/CentOS
      yum:
        name: httpd
        state: latest
      when: ansible_distribution == 'CentOS' or ansible_distribution == 'Red Hat Enterprise Linux'

    - name: Install Docker on Ubuntu
      apt:
        name: docker.io
        state: latest
      when: ansible_distribution == 'Ubuntu'

    - name: Install AWS CLI on Debian-based systems
      apt:
        name: awscli
        state: latest
      when: ansible_distribution == 'Debian' or ansible_distribution == 'Ubuntu'
```

#### Advanced Conditionals

```yaml
tasks:
  - name: Install package only on specific conditions
    package:
      name: "{{ package_name }}"
      state: present
    when:
      - ansible_distribution_major_version | int >= 8
      - ansible_memtotal_mb > 1024
      - environment == "production"

  - name: Configure service based on multiple conditions
    template:
      src: service.conf.j2
      dest: /etc/service/service.conf
    when:
      - ansible_processor_cores > 2
      - ansible_distribution in ['Ubuntu', 'Debian']
      - inventory_hostname in groups['webservers']
```

### Loops and Iteration

```yaml
tasks:
  - name: Install multiple packages
    package:
      name: "{{ item }}"
      state: present
    loop:
      - nginx
      - git
      - curl
      - vim

  - name: Create multiple users
    user:
      name: "{{ item.name }}"
      groups: "{{ item.groups }}"
      shell: "{{ item.shell }}"
    loop:
      - { name: 'developer1', groups: 'developers', shell: '/bin/bash' }
      - { name: 'developer2', groups: 'developers', shell: '/bin/zsh' }
      - { name: 'admin1', groups: 'admin', shell: '/bin/bash' }
```

---

## 🔐 Ansible Vault (Security)

Ansible Vault provides encryption for sensitive data like passwords, API keys, and certificates.

### Vault Commands

```bash
# Create a new encrypted file
ansible-vault create secrets.yml

# Edit an encrypted file
ansible-vault edit secrets.yml

# Change vault password
ansible-vault rekey secrets.yml

# Encrypt an existing file
ansible-vault encrypt existing_file.yml

# Decrypt a file
ansible-vault decrypt secrets.yml

# View encrypted file content
ansible-vault view secrets.yml
```

### Using Vault in Playbooks

#### Creating Encrypted Variables

```bash
# Create vault file
ansible-vault create group_vars/production/vault.yml
```

**vault.yml content:**
```yaml
---
vault_database_password: super_secret_password
vault_api_key: your_secret_api_key
vault_ssl_private_key: |
  -----BEGIN PRIVATE KEY-----
  MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC...
  -----END PRIVATE KEY-----
```

#### Running Vault-Protected Playbooks

```bash
# Prompt for vault password
ansible-playbook --ask-vault-pass playbook.yml

# Use password file
ansible-playbook --vault-password-file ~/.ansible_vault_pass playbook.yml

# Use multiple vault passwords
ansible-playbook --vault-id prod@prompt playbook.yml
```

#### Using Vault Variables in Playbooks

```yaml
---
- name: Deploy Application with Secrets
  hosts: webservers
  vars:
    database_password: "{{ vault_database_password }}"
    api_key: "{{ vault_api_key }}"
  
  tasks:
    - name: Configure database connection
      template:
        src: database.conf.j2
        dest: /etc/app/database.conf
        mode: '0600'
      no_log: true  # Don't log sensitive data
```

---

## 🎭 Roles and Organization

### Understanding Roles

Roles provide a way to organize playbooks into reusable components. They encapsulate tasks, handlers, variables, and files into a directory structure.

### Role Directory Structure

```
roles/
└── webserver/
    ├── defaults/
    │   └── main.yml          # Default variables (lowest priority)
    ├── files/
    │   └── static_file.txt   # Static files for copy module
    ├── handlers/
    │   └── main.yml          # Handlers (triggered by notify)
    ├── meta/
    │   └── main.yml          # Role metadata and dependencies
    ├── tasks/
    │   └── main.yml          # Main task list
    ├── templates/
    │   └── config.j2         # Jinja2 templates
    ├── tests/
    │   ├── inventory         # Test inventory
    │   └── test.yml          # Test playbook
    └── vars/
        └── main.yml          # Role variables (high priority)
```

### Creating Roles

#### Manual Creation

```bash
# Create role directory structure
mkdir -p roles/webserver/{tasks,handlers,templates,files,vars,defaults,meta}

# Create main task file
touch roles/webserver/tasks/main.yml
```

#### Using Ansible Galaxy

```bash
# Initialize new role
ansible-galaxy init roles/webserver

# Install role from Galaxy
ansible-galaxy install geerlingguy.nginx

# Install from requirements file
ansible-galaxy install -r requirements.yml
```

### Example Role Implementation

#### roles/webserver/tasks/main.yml

```yaml
---
- name: Update package cache
  apt:
    update_cache: yes
    cache_valid_time: 3600

- name: Install web server packages
  apt:
    name: "{{ webserver_packages }}"
    state: "{{ webserver_package_state }}"

- name: Copy configuration files
  template:
    src: "{{ item.src }}"
    dest: "{{ item.dest }}"
    backup: yes
  loop: "{{ webserver_config_files }}"
  notify: restart webserver

- name: Ensure web server is running
  service:
    name: "{{ webserver_service_name }}"
    state: started
    enabled: yes
```

#### roles/webserver/handlers/main.yml

```yaml
---
- name: restart webserver
  service:
    name: "{{ webserver_service_name }}"
    state: restarted

- name: reload webserver
  service:
    name: "{{ webserver_service_name }}"
    state: reloaded
```

#### roles/webserver/defaults/main.yml

```yaml
---
webserver_packages:
  - nginx
  - nginx-extras

webserver_package_state: present
webserver_service_name: nginx
webserver_port: 80

webserver_config_files:
  - src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  - src: site.conf.j2
    dest: /etc/nginx/sites-available/default
```

### Using Roles in Playbooks

#### Master Playbook Example

```yaml
---
- name: Master Playbook for Web Infrastructure
  hosts: webservers
  become: yes
  roles:
    - common
    - webserver
    - monitoring

- name: Database Server Setup
  hosts: databases
  become: yes
  roles:
    - common
    - database
    - backup
```

#### Role with Variables

```yaml
---
- name: Multi-environment Deployment
  hosts: "{{ target_environment }}"
  become: yes
  roles:
    - role: webserver
      vars:
        webserver_port: 8080
        webserver_worker_processes: 4
    - role: database
      vars:
        db_port: 3306
        max_connections: 200
```

---

## 🎯 Best Practices

### Project Structure Best Practices

#### Recommended Directory Layout

```
ansible-project/
├── ansible.cfg                 # Ansible configuration
├── inventory/
│   ├── production/
│   │   ├── hosts.yml          # Production inventory
│   │   └── group_vars/
│   ├── staging/
│   │   ├── hosts.yml          # Staging inventory
│   │   └── group_vars/
│   └── testing/
├── group_vars/
│   ├── all.yml                # Variables for all hosts
│   ├── webservers.yml         # Web server variables
│   └── databases.yml          # Database variables
├── host_vars/
│   ├── web1.yml              # Host-specific variables
│   └── db1.yml
├── roles/
│   ├── common/               # Common configuration role
│   ├── webserver/            # Web server role
│   ├── database/             # Database role
│   └── monitoring/           # Monitoring role
├── playbooks/
│   ├── site.yml              # Master playbook
│   ├── webservers.yml        # Web server playbook
│   ├── databases.yml         # Database playbook
│   └── maintenance.yml       # Maintenance tasks
├── library/                  # Custom modules (optional)
├── filter_plugins/           # Custom filters (optional)
├── templates/               # Shared templates
├── files/                   # Shared files
└── requirements.yml         # Ansible Galaxy requirements
```

### Coding Best Practices

#### YAML Best Practices

```yaml
# ✅ Good: Proper YAML formatting
---
- name: Install and configure web server
  hosts: webservers
  become: yes
  vars:
    nginx_port: 80
    php_version: "7.4"
  
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

# ❌ Bad: Poor formatting
- name: Install and configure web server
  hosts: webservers
  become: yes
  vars: {nginx_port: 80, php_version: 7.4}
  tasks:
  - name: Install Nginx
    apt: name=nginx state=present update_cache=yes
```

#### Task Best Practices

```yaml
# ✅ Good: Descriptive names and explicit states
- name: Ensure Nginx is installed and running
  package:
    name: nginx
    state: present
  notify: restart nginx

- name: Copy Nginx configuration
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
    backup: yes
    validate: nginx -t -c %s
  notify: reload nginx

# ✅ Good: Use blocks for related tasks
- name: Configure firewall
  block:
    - name: Install UFW
      package:
        name: ufw
        state: present
    
    - name: Allow SSH
      ufw:
        rule: allow
        port: 22
        proto: tcp
    
    - name: Allow HTTP
      ufw:
        rule: allow
        port: 80
        proto: tcp
    
    - name: Enable UFW
      ufw:
        state: enabled
  become: yes
  tags: firewall
```

### Security Best Practices

#### Sensitive Data Management

```yaml
# ✅ Use no_log for sensitive tasks
- name: Set user password
  user:
    name: "{{ username }}"
    password: "{{ user_password | password_hash('sha512') }}"
  no_log: true

# ✅ Use Ansible Vault for secrets
- name: Configure database
  template:
    src: database.yml.j2
    dest: /etc/app/database.yml
    mode: '0600'
  vars:
    db_password: "{{ vault_db_password }}"
```

#### Privilege Escalation

```yaml
# ✅ Use become judiciously
- name: Install system packages
  package:
    name: "{{ packages }}"
    state: present
  become: yes
  become_user: root

# ✅ Drop privileges when possible
- name: Copy user configuration
  copy:
    src: user.conf
    dest: "{{ ansible_user_dir }}/.config/app.conf"
  become: no
```

### Performance Best Practices

#### Efficient Task Execution

```yaml
# ✅ Use package module with lists
- name: Install multiple packages efficiently
  package:
    name:
      - nginx
      - php-fpm
      - mysql-client
      - git
    state: present

# ✅ Use async for long-running tasks
- name: Long running deployment
  command: /opt/deploy.sh
  async: 300
  poll: 10

# ✅ Use parallel execution
- name: Update all servers
  hosts: all
  serial: "20%"  # Process 20% of hosts at a time
  tasks:
    - name: Update packages
      package:
        name: "*"
        state: latest
```

#### Caching and Optimization

```yaml
# ✅ Cache package updates
- name: Update package cache
  apt:
    update_cache: yes
    cache_valid_time: 3600

# ✅ Use fact caching
# In ansible.cfg
[defaults]
fact_caching = memory
fact_caching_timeout = 86400
```

### Error Handling Best Practices

```yaml
# ✅ Proper error handling
- name: Attempt service restart with fallback
  block:
    - name: Restart primary service
      service:
        name: nginx
        state: restarted
  rescue:
    - name: Log error
      debug:
        msg: "Primary service restart failed, trying alternative"
    
    - name: Start backup service
      service:
        name: apache2
        state: started
  always:
    - name: Ensure monitoring is aware
      uri:
        url: "http://monitoring.example.com/api/status"
        method: POST
        body_format: json
        body:
          status: "deployment_complete"
```

### Testing Best Practices

#### Validation Tasks

```yaml
- name: Validate service configuration
  uri:
    url: "http://{{ ansible_default_ipv4.address }}:{{ nginx_port }}"
    method: GET
    status_code: 200
  register: health_check
  retries: 3
  delay: 10

- name: Fail if service is not responding
  fail:
    msg: "Service health check failed"
  when: health_check.status != 200
```

---

## 🔍 Advanced Topics

### Dynamic Inventory

#### AWS EC2 Dynamic Inventory

**aws_ec2.yml**
```yaml
---
plugin: aws_ec2
regions:
  - us-east-1
  - us-west-2
keyed_groups:
  - key: tags
    prefix: tag
  - key: instance_type
    prefix: type
hostnames:
  - tag:Name
  - dns-name
```

### Custom Modules

#### Simple Custom Module Example

**library/check_port.py**
```python
#!/usr/bin/python
from ansible.module_utils.basic import AnsibleModule
import socket

def check_port(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex((host, port))
    sock.close()
    return result == 0

def main():
    module = AnsibleModule(
        argument_spec=dict(
            host=dict(required=True, type='str'),
            port=dict(required=True, type='int')
        )
    )
    
    host = module.params['host']
    port = module.params['port']
    
    is_open = check_port(host, port)
    
    module.exit_json(changed=False, is_open=is_open, 
                    msg=f"Port {port} on {host} is {'open' if is_open else 'closed'}")

if __name__ == '__main__':
    main()
```

### Ansible Configuration

#### ansible.cfg Example

```ini
[defaults]
# Inventory location
inventory = ./inventory/production

# Number of parallel processes
forks = 50

# SSH connection settings
host_key_checking = False
ssh_args = -o ControlMaster=auto -o ControlPersist=60s

# Logging
log_path = ./ansible.log

# Role path
roles_path = ./roles:~/.ansible/roles:/usr/share/ansible/roles

# Fact caching
fact_caching = jsonfile
fact_caching_connection = ./tmp/facts_cache
fact_caching_timeout = 86400

[ssh_connection]
# SSH multiplexing
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null
pipelining = True
```

### Advanced Playbook Techniques

#### Rolling Updates

```yaml
---
- name: Rolling Update Web Servers
  hosts: webservers
  serial: "25%"  # Process 25% of hosts at a time
  max_fail_percentage: 10
  
  pre_tasks:
    - name: Remove from load balancer
      uri:
        url: "http://lb.example.com/api/remove/{{ inventory_hostname }}"
        method: POST
  
  tasks:
    - name: Update application
      git:
        repo: https://github.com/company/app.git
        dest: /opt/app
        version: "{{ app_version }}"
      notify: restart app
  
  post_tasks:
    - name: Add back to load balancer
      uri:
        url: "http://lb.example.com/api/add/{{ inventory_hostname }}"
        method: POST
      
  handlers:
    - name: restart app
      service:
        name: myapp
        state: restarted
```

#### Blue-Green Deployment

```yaml
---
- name: Blue-Green Deployment Strategy
  hosts: webservers
  vars:
    current_color: "{{ deploy_color | default('blue') }}"
    new_color: "{{ 'green' if current_color == 'blue' else 'blue' }}"
  
  tasks:
    - name: Deploy to {{ new_color }} environment
      git:
        repo: "{{ app_repository }}"
        dest: "/opt/app-{{ new_color }}"
        version: "{{ app_version }}"
    
    - name: Start {{ new_color }} application
      service:
        name: "app-{{ new_color }}"
        state: started
    
    - name: Health check {{ new_color }} environment
      uri:
        url: "http://{{ ansible_default_ipv4.address }}:{{ new_color_port }}/health"
        method: GET
        status_code: 200
      retries: 5
      delay: 30
    
    - name: Switch load balancer to {{ new_color }}
      template:
        src: lb-config.j2
        dest: /etc/nginx/conf.d/upstream.conf
      vars:
        active_color: "{{ new_color }}"
      notify: reload nginx
    
    - name: Stop {{ current_color }} application
      service:
        name: "app-{{ current_color }}"
        state: stopped
```

### Complex Workflow Example

```yaml
---
- name: Complete Application Deployment Pipeline
  hosts: localhost
  gather_facts: no
  vars:
    environments: ['staging', 'production']
    
  tasks:
    - name: Run deployment across environments
      include: deploy-environment.yml
      vars:
        target_env: "{{ item }}"
      loop: "{{ environments }}"
      when: deploy_all is defined

- name: Environment-specific deployment
  hosts: "{{ target_env }}"
  become: yes
  
  pre_tasks:
    - name: Validate deployment prerequisites
      assert:
        that:
          - app_version is defined
          - app_version != ""
        fail_msg: "app_version must be defined"
    
    - name: Create deployment directory
      file:
        path: "/opt/deployments/{{ app_version }}"
        state: directory
        mode: '0755'
  
  roles:
    - role: common
      tags: ['common']
    - role: application
      vars:
        app_environment: "{{ target_env }}"
      tags: ['app']
    - role: monitoring
      when: enable_monitoring | default(true)
      tags: ['monitoring']
  
  post_tasks:
    - name: Verify deployment
      uri:
        url: "http://{{ ansible_default_ipv4.address }}/health"
        method: GET
        status_code: 200
      retries: 3
      delay: 10
```

---

## 🛠️ Troubleshooting

### Common Issues and Solutions

#### SSH Connection Issues

```bash
# Debug SSH connection
ansible all -m ping -vvv

# Test SSH manually
ssh -i /path/to/key user@host

# Common SSH fixes in inventory
[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_host_key_checking=False
```

#### Permission Issues

```yaml
# Fix common permission issues
- name: Ensure correct permissions
  file:
    path: "{{ item.path }}"
    owner: "{{ item.owner }}"
    group: "{{ item.group }}"
    mode: "{{ item.mode }}"
  loop:
    - { path: '/var/log/app', owner: 'app', group: 'app', mode: '0755' }
    - { path: '/etc/app/config', owner: 'root', group: 'app', mode: '0640' }
```

#### Debugging Techniques

```yaml
# Debug variable values
- name: Debug variables
  debug:
    var: hostvars[inventory_hostname]

# Debug with conditions
- name: Conditional debug
  debug:
    msg: "This host is {{ ansible_hostname }}"
  when: ansible_distribution == "Ubuntu"

# Register and debug command output
- name: Check service status
  command: systemctl status nginx
  register: service_status
  failed_when: false

- name: Show service status
  debug:
    var: service_status.stdout_lines
```

### Performance Optimization

#### Ansible Configuration Tuning

```ini
[defaults]
# Increase parallel execution
forks = 50

# Enable SSH pipelining
pipelining = True

# Reduce SSH overhead
ssh_args = -o ControlMaster=auto -o ControlPersist=60s

# Enable fact caching
fact_caching = memory
fact_caching_timeout = 3600

[ssh_connection]
# SSH multiplexing
control_path = ~/.ansible/cp/%%h-%%p-%%r
```

#### Efficient Playbook Design

```yaml
# ✅ Gather facts only when needed
- name: Quick tasks without facts
  hosts: all
  gather_facts: no
  tasks:
    - name: Simple command
      command: echo "Hello World"

# ✅ Use async for long-running tasks
- name: Long running installation
  yum:
    name: large-package
    state: present
  async: 600
  poll: 10

# ✅ Use strategy for different execution patterns
- name: Free strategy example
  hosts: all
  strategy: free  # Don't wait for all hosts to complete each task
  tasks:
    - name: Independent task
      command: /usr/local/bin/independent-script.sh
```

---

## 📊 Monitoring and Logging

### Built-in Logging

```yaml
# Enable detailed logging
- name: Task with logging
  command: /usr/bin/some-command
  register: command_result

- name: Log command output
  copy:
    content: |
      Command: /usr/bin/some-command
      Exit Code: {{ command_result.rc }}
      Output: {{ command_result.stdout }}
      Error: {{ command_result.stderr }}
      Timestamp: {{ ansible_date_time.iso8601 }}
    dest: /var/log/ansible-deployment.log
    mode: '0644'
  delegate_to: localhost
```

### Integration with External Systems

```yaml
# Slack notifications
- name: Notify Slack on deployment
  uri:
    url: "{{ slack_webhook_url }}"
    method: POST
    body_format: json
    body:
      text: "Deployment of {{ app_version }} to {{ inventory_hostname }} completed"
  delegate_to: localhost
  run_once: true

# Datadog metrics
- name: Send metrics to Datadog
  uri:
    url: "https://api.datadoghq.com/api/v1/series"
    method: POST
    headers:
      DD-API-KEY: "{{ datadog_api_key }}"
    body_format: json
    body:
      series:
        - metric: "deployment.count"
          points: [[{{ ansible_date_time.epoch }}, 1]]
          tags: ["environment:{{ target_env }}", "version:{{ app_version }}"]
```

---

## 🚀 Advanced Use Cases

### Infrastructure as Code

#### Complete Environment Provisioning

```yaml
---
- name: Provision Complete Infrastructure
  hosts: localhost
  gather_facts: no
  tasks:
    - name: Create VPC
      ec2_vpc_net:
        name: "{{ project_name }}-vpc"
        cidr_block: "{{ vpc_cidr }}"
        region: "{{ aws_region }}"
        tags:
          Environment: "{{ environment }}"
      register: vpc

    - name: Create subnets
      ec2_vpc_subnet:
        vpc_id: "{{ vpc.vpc.id }}"
        cidr: "{{ item.cidr }}"
        az: "{{ item.az }}"
        tags:
          Name: "{{ item.name }}"
          Environment: "{{ environment }}"
      loop: "{{ subnets }}"
      register: subnet_results

    - name: Launch EC2 instances
      ec2_instance:
        name: "{{ item.name }}"
        image_id: "{{ ami_id }}"
        instance_type: "{{ item.type }}"
        subnet_id: "{{ subnet_results.results[item.subnet_index].subnet.id }}"
        security_groups: "{{ item.security_groups }}"
        key_name: "{{ key_pair_name }}"
        tags:
          Environment: "{{ environment }}"
          Role: "{{ item.role }}"
      loop: "{{ instances }}"
```

### CI/CD Integration

#### Jenkins Pipeline Integration

```yaml
---
- name: CI/CD Pipeline Deployment
  hosts: "{{ target_environment }}"
  vars:
    build_number: "{{ lookup('env', 'BUILD_NUMBER') }}"
    git_commit: "{{ lookup('env', 'GIT_COMMIT') }}"
    
  tasks:
    - name: Create deployment directory
      file:
        path: "/opt/releases/{{ build_number }}"
        state: directory

    - name: Download artifact from Jenkins
      get_url:
        url: "{{ jenkins_url }}/job/{{ job_name }}/{{ build_number }}/artifact/{{ artifact_name }}"
        dest: "/opt/releases/{{ build_number }}/{{ artifact_name }}"
        headers:
          Authorization: "Bearer {{ jenkins_token }}"

    - name: Extract application
      unarchive:
        src: "/opt/releases/{{ build_number }}/{{ artifact_name }}"
        dest: "/opt/releases/{{ build_number }}"
        remote_src: yes

    - name: Update symlink
      file:
        src: "/opt/releases/{{ build_number }}"
        dest: /opt/current
        state: link
      notify: restart application

    - name: Update deployment metadata
      template:
        src: deployment.json.j2
        dest: /opt/current/deployment.json
      vars:
        deployment_info:
          build: "{{ build_number }}"
          commit: "{{ git_commit }}"
          timestamp: "{{ ansible_date_time.iso8601 }}"
          deployed_by: "{{ ansible_user }}"
```

### Multi-Cloud Deployment

```yaml
---
- name: Multi-Cloud Application Deployment
  hosts: localhost
  vars:
    cloud_providers:
      - aws
      - azure
      - gcp
  
  tasks:
    - name: Deploy to each cloud provider
      include_tasks: "deploy-{{ item }}.yml"
      loop: "{{ cloud_providers }}"
      vars:
        provider: "{{ item }}"
```

---

## 📝 Real-World Examples

### Complete LAMP Stack Deployment

```yaml
---
- name: Deploy LAMP Stack
  hosts: webservers
  become: yes
  vars:
    mysql_root_password: "{{ vault_mysql_root_password }}"
    app_database: myapp
    app_user: appuser
    app_password: "{{ vault_app_password }}"
  
  roles:
    - common
    - apache
    - mysql
    - php
    
  tasks:
    - name: Create application database
      mysql_db:
        name: "{{ app_database }}"
        state: present
        login_user: root
        login_password: "{{ mysql_root_password }}"

    - name: Create application user
      mysql_user:
        name: "{{ app_user }}"
        password: "{{ app_password }}"
        priv: "{{ app_database }}.*:ALL"
        state: present
        login_user: root
        login_password: "{{ mysql_root_password }}"

    - name: Deploy application code
      git:
        repo: "{{ app_repository }}"
        dest: /var/www/html
        version: "{{ app_version | default('main') }}"
      notify: restart apache

    - name: Configure Apache virtual host
      template:
        src: vhost.conf.j2
        dest: "/etc/apache2/sites-available/{{ app_name }}.conf"
      notify: restart apache

    - name: Enable site
      command: a2ensite {{ app_name }}
      notify: restart apache

  handlers:
    - name: restart apache
      service:
        name: apache2
        state: restarted
```

### Docker Container Management

```yaml
---
- name: Docker Container Orchestration
  hosts: docker_hosts
  become: yes
  
  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
        update_cache: yes

    - name: Start Docker service
      service:
        name: docker
        state: started
        enabled: yes

    - name: Pull application image
      docker_image:
        name: "{{ app_image }}"
        tag: "{{ app_version }}"
        source: pull

    - name: Run application container
      docker_container:
        name: "{{ app_name }}"
        image: "{{ app_image }}:{{ app_version }}"
        state: started
        restart_policy: always
        ports:
          - "{{ app_port }}:{{ app_internal_port }}"
        env:
          DATABASE_URL: "{{ database_url }}"
          API_KEY: "{{ vault_api_key }}"
        volumes:
          - "/opt/app/data:/data"
          - "/var/log/app:/var/log/app"

    - name: Configure reverse proxy
      template:
        src: nginx-proxy.conf.j2
        dest: /etc/nginx/conf.d/{{ app_name }}.conf
      notify: reload nginx
```

### Kubernetes Deployment

```yaml
---
- name: Deploy to Kubernetes
  hosts: localhost
  connection: local
  vars:
    namespace: "{{ app_namespace | default('default') }}"
    
  tasks:
    - name: Create namespace
      kubernetes.core.k8s:
        name: "{{ namespace }}"
        api_version: v1
        kind: Namespace
        state: present

    - name: Deploy application secrets
      kubernetes.core.k8s:
        definition:
          apiVersion: v1
          kind: Secret
          metadata:
            name: app-secrets
            namespace: "{{ namespace }}"
          data:
            database-password: "{{ vault_db_password | b64encode }}"
            api-key: "{{ vault_api_key | b64encode }}"

    - name: Deploy application
      kubernetes.core.k8s:
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ app_name }}"
            namespace: "{{ namespace }}"
          spec:
            replicas: "{{ app_replicas | default(3) }}"
            selector:
              matchLabels:
                app: "{{ app_name }}"
            template:
              metadata:
                labels:
                  app: "{{ app_name }}"
              spec:
                containers:
                - name: "{{ app_name }}"
                  image: "{{ app_image }}:{{ app_version }}"
                  ports:
                  - containerPort: 8080
                  env:
                  - name: DATABASE_PASSWORD
                    valueFrom:
                      secretKeyRef:
                        name: app-secrets
                        key: database-password
```

---

## 🎨 Templates and Jinja2

### Template Basics

#### Nginx Configuration Template

**templates/nginx.conf.j2**
```nginx
# Ansible managed - DO NOT EDIT MANUALLY

user {{ nginx_user | default('www-data') }};
worker_processes {{ nginx_worker_processes | default(ansible_processor_cores) }};
pid /run/nginx.pid;

events {
    worker_connections {{ nginx_worker_connections | default(1024) }};
    use epoll;
    multi_accept on;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    # Logging
    access_log {{ nginx_access_log | default('/var/log/nginx/access.log') }};
    error_log {{ nginx_error_log | default('/var/log/nginx/error.log') }};

    # Gzip compression
    gzip {{ nginx_gzip | default('on') }};
    gzip_types text/plain text/css application/json application/javascript;

    # Virtual hosts
    {% for vhost in nginx_vhosts | default([]) %}
    server {
        listen {{ vhost.port | default(80) }};
        server_name {{ vhost.server_name }};
        root {{ vhost.document_root }};
        index {{ vhost.index | default('index.html index.php') }};

        {% if vhost.ssl | default(false) %}
        # SSL configuration
        listen {{ vhost.ssl_port | default(443) }} ssl;
        ssl_certificate {{ vhost.ssl_cert }};
        ssl_certificate_key {{ vhost.ssl_key }};
        {% endif %}

        location / {
            try_files $uri $uri/ =404;
        }

        {% if vhost.php | default(false) %}
        location ~ \.php$ {
            fastcgi_pass unix:/var/run/php/php{{ php_version }}-fpm.sock;
            fastcgi_index index.php;
            include fastcgi_params;
        }
        {% endif %}
    }
    {% endfor %}
}
```

#### Application Configuration Template

**templates/app.properties.j2**
```properties
# Application Configuration
# Environment: {{ environment }}
# Generated: {{ ansible_date_time.iso8601 }}

# Database Configuration
database.host={{ database_host }}
database.port={{ database_port | default(3306) }}
database.name={{ database_name }}
database.user={{ database_user }}
database.password={{ vault_database_password }}

# Redis Configuration
{% if redis_enabled | default(false) %}
redis.host={{ redis_host }}
redis.port={{ redis_port | default(6379) }}
{% if redis_password is defined %}
redis.password={{ redis_password }}
{% endif %}
{% endif %}

# Application Settings
app.debug={{ app_debug | default(false) | lower }}
app.port={{ app_port | default(8080) }}
app.threads={{ app_threads | default(ansible_processor_cores * 2) }}

# Feature Flags
{% for feature, enabled in feature_flags.items() %}
feature.{{ feature }}={{ enabled | lower }}
{% endfor %}

# Environment-specific settings
{% if environment == 'production' %}
logging.level=INFO
cache.ttl=3600
{% elif environment == 'staging' %}
logging.level=DEBUG
cache.ttl=300
{% else %}
logging.level=DEBUG
cache.ttl=60
{% endif %}
```

---

## 🔄 Advanced Automation Patterns

### Immutable Infrastructure

```yaml
---
- name: Immutable Infrastructure Deployment
  hosts: localhost
  vars:
    timestamp: "{{ ansible_date_time.epoch }}"
    
  tasks:
    - name: Build new AMI
      ec2_ami:
        instance_id: "{{ base_instance_id }}"
        name: "{{ app_name }}-{{ app_version }}-{{ timestamp }}"
        description: "{{ app_name }} version {{ app_version }}"
        tags:
          Name: "{{ app_name }}-{{ app_version }}"
          Version: "{{ app_version }}"
          Environment: "{{ environment }}"
      register: new_ami

    - name: Update launch template
      ec2_launch_template:
        name: "{{ app_name }}-template"
        image_id: "{{ new_ami.image_id }}"
        instance_type: "{{ instance_type }}"
        security_group_ids: "{{ security_groups }}"
        user_data: |
          #!/bin/bash
          systemctl start {{ app_name }}
          systemctl enable {{ app_name }}

    - name: Update Auto Scaling Group
      ec2_asg:
        name: "{{ app_name }}-asg"
        launch_template:
          name: "{{ app_name }}-template"
          version: '$Latest'
        min_size: "{{ min_instances }}"
        max_size: "{{ max_instances }}"
        desired_capacity: "{{ desired_instances }}"
        replace_all_instances: yes
        wait_for_instances: yes
```

### Zero-Downtime Deployment

```yaml
---
- name: Zero-Downtime Deployment
  hosts: webservers
  serial: 1
  vars:
    health_check_url: "http://{{ ansible_default_ipv4.address }}:{{ app_port }}/health"
    
  pre_tasks:
    - name: Check current health
      uri:
        url: "{{ health_check_url }}"
        method: GET
        status_code: 200
      register: pre_health_check
      retries: 3
      delay: 5

  tasks:
    - name: Remove from load balancer
      uri:
        url: "{{ load_balancer_api }}/servers/{{ inventory_hostname }}/disable"
        method: POST
        headers:
          Authorization: "Bearer {{ lb_api_token }}"

    - name: Wait for connections to drain
      wait_for:
        timeout: 30
      delegate_to: localhost

    - name: Deploy new version
      unarchive:
        src: "{{ artifact_url }}"
        dest: /opt/app
        remote_src: yes
        owner: app
        group: app
      notify: restart application

    - name: Wait for application to start
      wait_for:
        port: "{{ app_port }}"
        delay: 10
        timeout: 60

    - name: Health check after deployment
      uri:
        url: "{{ health_check_url }}"
        method: GET
        status_code: 200
      retries: 10
      delay: 6

    - name: Add back to load balancer
      uri:
        url: "{{ load_balancer_api }}/servers/{{ inventory_hostname }}/enable"
        method: POST
        headers:
          Authorization: "Bearer {{ lb_api_token }}"

  handlers:
    - name: restart application
      service:
        name: "{{ app_service_name }}"
        state: restarted
```

---

## 📈 Monitoring and Observability

### Application Performance Monitoring

```yaml
---
- name: Setup Comprehensive Monitoring
  hosts: all
  become: yes
  
  roles:
    - prometheus
    - grafana
    - elasticsearch
    - kibana
  
  tasks:
    - name: Install monitoring agents
      package:
        name:
          - node-exporter
          - filebeat
          - metricbeat
        state: present

    - name: Configure Prometheus node exporter
      template:
        src: node-exporter.service.j2
        dest: /etc/systemd/system/node-exporter.service
      notify:
        - reload systemd
        - restart node-exporter

    - name: Configure log shipping
      template:
        src: filebeat.yml.j2
        dest: /etc/filebeat/filebeat.yml
      notify: restart filebeat

    - name: Setup custom metrics collection
      copy:
        content: |
          #!/bin/bash
          # Custom metrics script
          echo "app_requests_total $(grep 'request' /var/log/app.log | wc -l)"
          echo "app_errors_total $(grep 'ERROR' /var/log/app.log | wc -l)"
        dest: /usr/local/bin/custom-metrics.sh
        mode: '0755'

    - name: Schedule metrics collection
      cron:
        name: "collect custom metrics"
        minute: "*/5"
        job: "/usr/local/bin/custom-metrics.sh >> /var/lib/node-exporter/textfile-collector/app.prom"
```

---

## 🛡️ Security Hardening

### System Security Playbook

```yaml
---
- name: System Security Hardening
  hosts: all
  become: yes
  
  tasks:
    - name: Update all packages
      package:
        name: "*"
        state: latest

    - name: Install security packages
      package:
        name:
          - fail2ban
          - ufw
          - aide
          - rkhunter
        state: present

    - name: Configure SSH security
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: "{{ item.regexp }}"
        line: "{{ item.line }}"
        backup: yes
      loop:
        - { regexp: '^#?PermitRootLogin', line: 'PermitRootLogin no' }
        - { regexp: '^#?PasswordAuthentication', line: 'PasswordAuthentication no' }
        - { regexp: '^#?Port', line: 'Port {{ ssh_port | default(22) }}' }
        - { regexp: '^#?MaxAuthTries', line: 'MaxAuthTries 3' }
      notify: restart sshd

    - name: Configure firewall rules
      ufw:
        rule: "{{ item.rule }}"
        port: "{{ item.port }}"
        proto: "{{ item.proto }}"
      loop:
        - { rule: 'allow', port: '{{ ssh_port | default(22) }}', proto: 'tcp' }
        - { rule: 'allow', port: '80', proto: 'tcp' }
        - { rule: 'allow', port: '443', proto: 'tcp' }

    - name: Enable firewall
      ufw:
        state: enabled
        policy: deny

    - name: Configure fail2ban
      template:
        src: jail.local.j2
        dest: /etc/fail2ban/jail.local
      notify: restart fail2ban

  handlers:
    - name: restart sshd
      service:
        name: sshd
        state: restarted
    
    - name: restart fail2ban
      service:
        name: fail2ban
        state: restarted
```

---

## 📚 Additional Resources

### Useful Ansible Commands Reference

```bash
# Inventory and host management
ansible-inventory --graph                    # Show inventory structure
ansible all --list-hosts                     # List all hosts
ansible webservers --list-hosts               # List hosts in group

# Playbook operations
ansible-playbook --syntax-check playbook.yml # Syntax validation
ansible-playbook --list-tasks playbook.yml   # List tasks without running
ansible-playbook --list-hosts playbook.yml   # List target hosts
ansible-playbook --check --diff playbook.yml # Dry run with differences

# Debugging and troubleshooting
ansible-playbook -vvv playbook.yml           # Maximum verbosity
ansible all -m setup                         # Gather all facts
ansible all -m setup -a "filter=ansible_eth*" # Filter specific facts

# Performance and parallel execution
ansible-playbook --forks=20 playbook.yml     # Increase parallelism
ansible-playbook --start-at-task="task name" playbook.yml # Start at specific task
```

### Environment Configuration

#### Development Environment

```yaml
# group_vars/development.yml
---
environment: development
debug_mode: true
log_level: DEBUG
database_host: localhost
redis_enabled: false
ssl_enabled: false
backup_enabled: false
monitoring_enabled: false
```

#### Production Environment

```yaml
# group_vars/production.yml
---
environment: production
debug_mode: false
log_level: INFO
database_host: "{{ vault_production_db_host }}"
redis_enabled: true
ssl_enabled: true
backup_enabled: true
monitoring_enabled: true
performance_monitoring: true
security_scanning: true
```

### Interview Preparation Topics

#### Key Areas for 3+ Years DevOps Experience

1. **Ansible Architecture**: Understanding control nodes, managed nodes, and communication
2. **Inventory Management**: Static vs dynamic inventory, grouping strategies
3. **Playbook Design**: Task organization, role usage, variable management
4. **Security**: Vault usage, privilege escalation, secret management
5. **Performance**: Parallel execution, fact caching, optimization techniques
6. **Integration**: CI/CD pipelines, cloud providers, container orchestration
7. **Troubleshooting**: Debugging techniques, common issues, logging

#### Sample Interview Questions & Answers

**Q: How does Ansible ensure idempotency?**

A: Ansible modules are designed to be idempotent, meaning they check the current state before making changes. For example, the `package` module checks if a package is already installed before attempting installation, ensuring the same playbook can be run multiple times safely.

**Q: Explain the difference between `include` and `import` in Ansible.**

A: `import` is processed at parse time (static), while `include` is processed at runtime (dynamic). Use `import` for static content and `include` when you need dynamic behavior based on variables or conditions.

**Q: How would you handle secrets in a multi-environment setup?**

A: Use Ansible Vault with environment-specific vault files:
```
group_vars/
├── production/
│   ├── vars.yml
│   └── vault.yml  # Encrypted secrets
├── staging/
│   ├── vars.yml
│   └── vault.yml  # Different secrets
```

---

## 🚨 Common Pitfalls and Solutions

### Performance Issues

#### Problem: Slow playbook execution
**Solution:**
```yaml
# Use strategy for faster execution
- name: Fast execution
  hosts: all
  strategy: free
  gather_facts: no  # Skip if not needed
```

#### Problem: SSH connection timeouts
**Solution:**
```ini
# ansible.cfg
[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=300s
control_path = ~/.ansible/cp/%%h-%%p-%%r
```

### Security Issues

#### Problem: Hardcoded passwords in playbooks
**Solution:**
```yaml
# Use Ansible Vault
- name: Configure database
  mysql_user:
    name: "{{ db_user }}"
    password: "{{ vault_db_password }}"  # From encrypted vault
    state: present
  no_log: true
```

#### Problem: Running everything as root
**Solution:**
```yaml
# Use privilege escalation only when needed
- name: Install system package
  package:
    name: nginx
    state: present
  become: yes

- name: Configure user application
  copy:
    src: user.conf
    dest: ~/.config/app.conf
  become: no
```

---

## 📋 Checklists for DevOps Engineers

### Pre-Deployment Checklist

- [ ] Inventory file updated and tested
- [ ] Variables defined for target environment
- [ ] Secrets encrypted with Ansible Vault
- [ ] Playbook syntax validated (`--syntax-check`)
- [ ] Dry run completed successfully (`--check`)
- [ ] Backup procedures verified
- [ ] Rollback plan prepared
- [ ] Monitoring alerts configured
- [ ] Team notifications set up

### Post-Deployment Checklist

- [ ] All services running and healthy
- [ ] Application responding to health checks
- [ ] Logs show no critical errors
- [ ] Monitoring metrics within expected ranges
- [ ] Performance benchmarks met
- [ ] Security scans passed
- [ ] Documentation updated
- [ ] Team notified of completion

---

## 🎓 Career Advancement Tips

### Skills to Develop

1. **Advanced YAML**: Complex data structures, anchors, and references
2. **Jinja2 Templating**: Advanced filters, custom filters, complex logic
3. **Python**: Custom modules, plugins, and filters
4. **Cloud Integration**: AWS, Azure, GCP modules and dynamic inventory
5. **Container Orchestration**: Docker, Kubernetes, OpenShift
6. **Security**: Compliance automation, vulnerability management
7. **Performance Tuning**: Large-scale deployments, optimization techniques

### Building Your Portfolio

Create GitHub repositories showcasing:

1. **Infrastructure as Code**: Complete environment provisioning
2. **Application Deployment**: Multi-tier application automation
3. **Security Automation**: Compliance and hardening playbooks
4. **Monitoring Setup**: Observability stack deployment
5. **CI/CD Integration**: Pipeline automation examples

### Recommended Learning Path

1. **Master the Basics** (Week 1-2)
   - Inventory management and host patterns
   - Ad-hoc commands and modules
   - Basic playbook structure

2. **Intermediate Concepts** (Week 3-4)
   - Variables and templates
   - Roles and organization
   - Conditionals and loops

3. **Advanced Topics** (Week 5-6)
   - Ansible Vault and security
   - Custom modules and plugins
   - Performance optimization

4. **Production Skills** (Week 7-8)
   - CI/CD integration
   - Multi-environment management
   - Monitoring and observability

5. **Expert Level** (Ongoing)
   - Cloud-native deployments
   - Kubernetes automation
   - Enterprise patterns

---

## 🔧 Practical Labs and Exercises

### Lab 1: Multi-Tier Application Deployment

**Objective**: Deploy a complete web application stack

**Infrastructure**:
- 2 Web servers (Nginx + PHP)
- 1 Database server (MySQL)
- 1 Load balancer (HAProxy)

**Tasks**:
1. Set up inventory with proper grouping
2. Create roles for each component
3. Implement health checks
4. Add SSL termination
5. Configure monitoring

**Expected Deliverables**:
```yaml
# site.yml
---
- import_playbook: database.yml
- import_playbook: webservers.yml
- import_playbook: loadbalancer.yml
- import_playbook: monitoring.yml

# Inventory structure
[databases]
db1 ansible_host=10.0.1.10

[webservers]
web1 ansible_host=10.0.1.20
web2 ansible_host=10.0.1.21

[loadbalancers]
lb1 ansible_host=10.0.1.30

[monitoring]
monitor1 ansible_host=10.0.1.40
```

### Lab 2: CI/CD Pipeline Integration

**Objective**: Integrate Ansible with Jenkins for automated deployments

**Components**:
- Jenkins server
- Git repository
- Application servers
- Automated testing

**Implementation**:

```yaml
---
- name: CI/CD Pipeline Deployment
  hosts: "{{ target_environment | default('staging') }}"
  vars:
    build_number: "{{ lookup('env', 'BUILD_NUMBER') }}"
    git_branch: "{{ lookup('env', 'GIT_BRANCH') }}"
    
  pre_tasks:
    - name: Validate environment
      assert:
        that:
          - target_environment in ['staging', 'production']
          - build_number != ""
        fail_msg: "Invalid environment or build number"

  tasks:
    - name: Download build artifact
      get_url:
        url: "{{ artifact_repository }}/{{ app_name }}/{{ build_number }}/{{ app_name }}.tar.gz"
        dest: "/tmp/{{ app_name }}-{{ build_number }}.tar.gz"

    - name: Create release directory
      file:
        path: "/opt/releases/{{ build_number }}"
        state: directory
        owner: "{{ app_user }}"
        group: "{{ app_group }}"

    - name: Extract application
      unarchive:
        src: "/tmp/{{ app_name }}-{{ build_number }}.tar.gz"
        dest: "/opt/releases/{{ build_number }}"
        remote_src: yes
        owner: "{{ app_user }}"
        group: "{{ app_group }}"

    - name: Run database migrations
      command: >
        /opt/releases/{{ build_number }}/bin/migrate
        --config /etc/{{ app_name }}/database.yml
      become_user: "{{ app_user }}"
      when: run_migrations | default(false)

    - name: Update application symlink
      file:
        src: "/opt/releases/{{ build_number }}"
        dest: "/opt/{{ app_name }}/current"
        state: link
      notify: restart application

    - name: Cleanup old releases
      shell: |
        cd /opt/releases
        ls -1dt */ | tail -n +{{ keep_releases | default(5) }} | xargs rm -rf
      args:
        executable: /bin/bash

  post_tasks:
    - name: Application health check
      uri:
        url: "http://{{ ansible_default_ipv4.address }}:{{ app_port }}/health"
        method: GET
        status_code: 200
      retries: 5
      delay: 10

    - name: Send deployment notification
      mail:
        to: "{{ deployment_notification_email }}"
        subject: "Deployment {{ 'SUCCESS' if ansible_failed_result is not defined else 'FAILED' }}"
        body: |
          Deployment Details:
          - Application: {{ app_name }}
          - Version: {{ build_number }}
          - Environment: {{ target_environment }}
          - Branch: {{ git_branch }}
          - Status: {{ 'SUCCESS' if ansible_failed_result is not defined else 'FAILED' }}
          - Deployed by: {{ ansible_user }}
          - Timestamp: {{ ansible_date_time.iso8601 }}
      delegate_to: localhost
      run_once: true
```

### Lab 3: Infrastructure Compliance Automation

**Objective**: Implement automated compliance checking and remediation

```yaml
---
- name: Security Compliance Automation
  hosts: all
  become: yes
  vars:
    compliance_standards:
      - cis_benchmark
      - pci_dss
      - sox_compliance
  
  tasks:
    - name: Gather system information
      setup:
        filter: "ansible_*"

    - name: Check password policy
      lineinfile:
        path: /etc/login.defs
        regexp: "{{ item.regexp }}"
        line: "{{ item.line }}"
        backup: yes
      loop:
        - { regexp: '^PASS_MAX_DAYS', line: 'PASS_MAX_DAYS 90' }
        - { regexp: '^PASS_MIN_DAYS', line: 'PASS_MIN_DAYS 1' }
        - { regexp: '^PASS_MIN_LEN', line: 'PASS_MIN_LEN 12' }
        - { regexp: '^PASS_WARN_AGE', line: 'PASS_WARN_AGE 7' }

    - name: Configure audit rules
      blockinfile:
        path: /etc/audit/rules.d/compliance.rules
        block: |
          # Monitor file system changes
          -w /etc/passwd -p wa -k identity
          -w /etc/group -p wa -k identity
          -w /etc/shadow -p wa -k identity
          -w /etc/sudoers -p wa -k privilege_escalation
          
          # Monitor network changes
          -a always,exit -F arch=b64 -S socket,bind,connect -k network
          
          # Monitor privilege escalation
          -a always,exit -F arch=b64 -S setuid,setgid -k privilege_escalation
      notify: restart auditd

    - name: Generate compliance report
      template:
        src: compliance-report.html.j2
        dest: "/var/www/html/compliance-{{ inventory_hostname }}.html"
      vars:
        report_timestamp: "{{ ansible_date_time.iso8601 }}"
        compliance_checks:
          - name: "Password Policy"
            status: "{{ 'PASS' if password_policy_compliant else 'FAIL' }}"
          - name: "SSH Configuration"
            status: "{{ 'PASS' if ssh_hardened else 'FAIL' }}"
          - name: "Firewall Enabled"
            status: "{{ 'PASS' if firewall_enabled else 'FAIL' }}"

  handlers:
    - name: restart auditd
      service:
        name: auditd
        state: restarted
```

---

## 🌐 Cloud-Native Ansible

### AWS Integration

```yaml
---
- name: AWS Infrastructure Management
  hosts: localhost
  gather_facts: no
  vars:
    aws_region: us-east-1
    
  tasks:
    - name: Create VPC
      amazon.aws.ec2_vpc_net:
        name: "{{ project_name }}-vpc"
        cidr_block: "{{ vpc_cidr }}"
        region: "{{ aws_region }}"
        state: present
        tags:
          Environment: "{{ environment }}"
          Project: "{{ project_name }}"
      register: vpc_result

    - name: Create Internet Gateway
      amazon.aws.ec2_vpc_igw:
        vpc_id: "{{ vpc_result.vpc.id }}"
        state: present
        tags:
          Name: "{{ project_name }}-igw"
      register: igw_result

    - name: Create subnets
      amazon.aws.ec2_vpc_subnet:
        vpc_id: "{{ vpc_result.vpc.id }}"
        cidr: "{{ item.cidr }}"
        az: "{{ item.az }}"
        tags:
          Name: "{{ item.name }}"
          Type: "{{ item.type }}"
        state: present
      loop: "{{ subnets }}"
      register: subnet_results

    - name: Create security groups
      amazon.aws.ec2_group:
        name: "{{ item.name }}"
        description: "{{ item.description }}"
        vpc_id: "{{ vpc_result.vpc.id }}"
        rules: "{{ item.rules }}"
        tags:
          Environment: "{{ environment }}"
      loop: "{{ security_groups }}"

    - name: Launch EC2 instances
      amazon.aws.ec2_instance:
        name: "{{ item.name }}"
        image_id: "{{ item.ami_id }}"
        instance_type: "{{ item.instance_type }}"
        subnet_id: "{{ subnet_results.results[item.subnet_index].subnet.id }}"
        security_groups: "{{ item.security_groups }}"
        key_name: "{{ aws_key_pair }}"
        wait: yes
        tags:
          Environment: "{{ environment }}"
          Role: "{{ item.role }}"
      loop: "{{ ec2_instances }}"
      register: ec2_results

    - name: Add instances to inventory
      add_host:
        name: "{{ item.instances[0].public_dns_name }}"
        groups: "{{ item.item.role }}s"
        ansible_host: "{{ item.instances[0].public_ip_address }}"
        ansible_user: ubuntu
        ansible_ssh_private_key_file: "{{ aws_private_key_file }}"
      loop: "{{ ec2_results.results }}"
```

### Kubernetes Automation

```yaml
---
- name: Kubernetes Application Deployment
  hosts: localhost
  connection: local
  vars:
    namespace: "{{ app_namespace }}"
    app_labels:
      app: "{{ app_name }}"
      version: "{{ app_version }}"
      environment: "{{ environment }}"

  tasks:
    - name: Create namespace
      kubernetes.core.k8s:
        name: "{{ namespace }}"
        api_version: v1
        kind: Namespace
        state: present

    - name: Create ConfigMap
      kubernetes.core.k8s:
        definition:
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: "{{ app_name }}-config"
            namespace: "{{ namespace }}"
          data:
            app.properties: |
              database.host={{ database_host }}
              database.port={{ database_port }}
              redis.enabled={{ redis_enabled | lower }}
              debug.mode={{ debug_mode | lower }}

    - name: Deploy application secrets
      kubernetes.core.k8s:
        definition:
          apiVersion: v1
          kind: Secret
          metadata:
            name: "{{ app_name }}-secrets"
            namespace: "{{ namespace }}"
          type: Opaque
          data:
            database-password: "{{ vault_database_password | b64encode }}"
            api-key: "{{ vault_api_key | b64encode }}"

    - name: Deploy application
      kubernetes.core.k8s:
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ app_name }}"
            namespace: "{{ namespace }}"
            labels: "{{ app_labels }}"
          spec:
            replicas: "{{ app_replicas }}"
            selector:
              matchLabels:
                app: "{{ app_name }}"
            template:
              metadata:
                labels: "{{ app_labels }}"
              spec:
                containers:
                - name: "{{ app_name }}"
                  image: "{{ app_image }}:{{ app_version }}"
                  ports:
                  - containerPort: 8080
                    name: http
                  envFrom:
                  - configMapRef:
                      name: "{{ app_name }}-config"
                  - secretRef:
                      name: "{{ app_name }}-secrets"
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

    - name: Create service
      kubernetes.core.k8s:
        definition:
          apiVersion: v1
          kind: Service
          metadata:
            name: "{{ app_name }}-service"
            namespace: "{{ namespace }}"
          spec:
            selector:
              app: "{{ app_name }}"
            ports:
            - port: 80
              targetPort: 8080
              protocol: TCP
            type: ClusterIP

    - name: Create ingress
      kubernetes.core.k8s:
        definition:
          apiVersion: networking.k8s.io/v1
          kind: Ingress
          metadata:
            name: "{{ app_name }}-ingress"
            namespace: "{{ namespace }}"
            annotations:
              nginx.ingress.kubernetes.io/rewrite-target: /
              cert-manager.io/cluster-issuer: "letsencrypt-prod"
          spec:
            tls:
            - hosts:
              - "{{ app_domain }}"
              secretName: "{{ app_name }}-tls"
            rules:
            - host: "{{ app_domain }}"
              http:
                paths:
                - path: /
                  pathType: Prefix
                  backend:
                    service:
                      name: "{{ app_name }}-service"
                      port:
                        number: 80
```

---

## 🏗️ Enterprise Patterns

### Multi-Environment Management

#### Environment-Specific Inventories

**inventory/production/hosts.yml**
```yaml
---
all:
  children:
    webservers:
      hosts:
        web-prod-01:
          ansible_host: 10.0.1.10
        web-prod-02:
          ansible_host: 10.0.1.11
      vars:
        environment: production
        replicas: 3
        resources:
          cpu: "2"
          memory: "4Gi"
    
    databases:
      hosts:
        db-prod-01:
          ansible_host: 10.0.2.10
          role: primary
        db-prod-02:
          ansible_host: 10.0.2.11
          role: replica
      vars:
        environment: production
        backup_enabled: true
        monitoring_level: detailed
```

#### Environment Promotion Pipeline

```yaml
---
- name: Environment Promotion Pipeline
  hosts: localhost
  gather_facts: no
  vars:
    promotion_stages:
      - source: development
        target: staging
        approval_required: false
      - source: staging
        target: production
        approval_required: true
        
  tasks:
    - name: Validate source environment
      uri:
        url: "http://{{ hostvars[groups[item.source][0]]['ansible_host'] }}/health"
        method: GET
        status_code: 200
      loop: "{{ promotion_stages }}"
      when: item.source in promotion_target

    - name: Request approval for production
      pause:
        prompt: "Approve promotion to production? (yes/no)"
      when: 
        - item.target == 'production'
        - item.approval_required
      loop: "{{ promotion_stages }}"

    - name: Execute promotion
      include_tasks: promote-environment.yml
      vars:
        source_env: "{{ item.source }}"
        target_env: "{{ item.target }}"
      loop: "{{ promotion_stages }}"
      when: item.source in promotion_target
```

### Disaster Recovery Automation

```yaml
---
- name: Disaster Recovery Procedures
  hosts: "{{ recovery_target | default('all') }}"
  become: yes
  vars:
    backup_location: "{{ vault_backup_location }}"
    recovery_point: "{{ recovery_datetime | default('latest') }}"
    
  pre_tasks:
    - name: Validate recovery parameters
      assert:
        that:
          - backup_location is defined
          - recovery_point is defined
        fail_msg: "Backup location and recovery point must be specified"

    - name: Check backup availability
      uri:
        url: "{{ backup_service_url }}/backups/{{ recovery_point }}"
        method: HEAD
        status_code: 200
      delegate_to: localhost

  tasks:
    - name: Stop application services
      service:
        name: "{{ item }}"
        state: stopped
      loop: "{{ application_services }}"

    - name: Download backup data
      get_url:
        url: "{{ backup_location }}/{{ inventory_hostname }}/{{ recovery_point }}.tar.gz"
        dest: "/tmp/recovery-{{ recovery_point }}.tar.gz"

    - name: Restore application data
      unarchive:
        src: "/tmp/recovery-{{ recovery_point }}.tar.gz"
        dest: /
        remote_src: yes
        owner: root
        group: root

    - name: Restore database
      mysql_db:
        name: "{{ app_database }}"
        state: import
        target: "/tmp/database-{{ recovery_point }}.sql"
        login_user: root
        login_password: "{{ vault_mysql_root_password }}"
      when: "'databases' in group_names"

    - name: Start application services
      service:
        name: "{{ item }}"
        state: started
      loop: "{{ application_services }}"

    - name: Verify recovery
      uri:
        url: "http://{{ ansible_default_ipv4.address }}/health"
        method: GET
        status_code: 200
      retries: 10
      delay: 30

  post_tasks:
    - name: Log recovery completion
      lineinfile:
        path: /var/log/disaster-recovery.log
        line: "{{ ansible_date_time.iso8601 }} - Recovery completed for {{ recovery_point }} on {{ inventory_hostname }}"
        create: yes

    - name: Notify operations team
      mail:
        to: "{{ ops_team_email }}"
        subject: "Disaster Recovery Completed - {{ inventory_hostname }}"
        body: |
          Disaster recovery has been completed successfully.
          
          Details:
          - Host: {{ inventory_hostname }}
          - Recovery Point: {{ recovery_point }}
          - Completion Time: {{ ansible_date_time.iso8601 }}
          - Services Restored: {{ application_services | join(', ') }}
      delegate_to: localhost
```

---

## 📊 Monitoring and Metrics

### Custom Metrics Collection

```yaml
---
- name: Application Metrics Collection
  hosts: webservers
  become: yes
  
  tasks:
    - name: Install monitoring dependencies
      package:
        name:
          - python3-pip
          - python3-requests
        state: present

    - name: Create metrics collection script
      copy:
        content: |
          #!/usr/bin/env python3
          import json
          import requests
          import subprocess
          import time
          from datetime import datetime

          def collect_system_metrics():
              # CPU usage
              cpu_usage = subprocess.check_output("top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1", shell=True)
              
              # Memory usage
              memory_info = subprocess.check_output("free -m | grep '^Mem:'", shell=True).decode().split()
              memory_used = int(memory_info[2])
              memory_total = int(memory_info[1])
              memory_percent = (memory_used / memory_total) * 100
              
              # Disk usage
              disk_usage = subprocess.check_output("df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1", shell=True)
              
              return {
                  "timestamp": datetime.now().isoformat(),
                  "hostname": "{{ inventory_hostname }}",
                  "cpu_usage": float(cpu_usage.decode().strip()),
                  "memory_usage": round(memory_percent, 2),
                  "disk_usage": int(disk_usage.decode().strip()),
                  "environment": "{{ environment }}"
              }

          def collect_application_metrics():
              try:
                  response = requests.get("http://localhost:{{ app_port }}/metrics", timeout=5)
                  if response.status_code == 200:
                      return response.json()
              except:
                  pass
              return {}

          def send_metrics(metrics):
              try:
                  requests.post(
                      "{{ metrics_endpoint }}",
                      json=metrics,
                      headers={"Authorization": "Bearer {{ vault_metrics_token }}"},
                      timeout=10
                  )
              except Exception as e:
                  print(f"Failed to send metrics: {e}")

          if __name__ == "__main__":
              system_metrics = collect_system_metrics()
              app_metrics = collect_application_metrics()
              
              combined_metrics = {**system_metrics, **app_metrics}
              send_metrics(combined_metrics)
              
              # Also write to local file for backup
              with open("/var/log/metrics.json", "a") as f:
                  f.write(json.dumps(combined_metrics) + "\n")
        dest: /usr/local/bin/collect-metrics.py
        mode: '0755'

    - name: Schedule metrics collection
      cron:
        name: "collect application metrics"
        minute: "*/5"
        job: "/usr/local/bin/collect-metrics.py"
        user: root
```

### Log Aggregation Setup

```yaml
---
- name: Centralized Logging Setup
  hosts: all
  become: yes
  
  tasks:
    - name: Install Filebeat
      get_url:
        url: "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-{{ filebeat_version }}-amd64.deb"
        dest: "/tmp/filebeat.deb"
      
    - name: Install Filebeat package
      apt:
        deb: "/tmp/filebeat.deb"
        state: present

    - name: Configure Filebeat
      template:
        src: filebeat.yml.j2
        dest: /etc/filebeat/filebeat.yml
        backup: yes
      notify: restart filebeat

    - name: Enable Filebeat modules
      command: filebeat modules enable {{ item }}
      loop: "{{ filebeat_modules }}"
      notify: restart filebeat

  handlers:
    - name: restart filebeat
      service:
        name: filebeat
        state: restarted
        enabled: yes
```

**templates/filebeat.yml.j2**
```yaml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/{{ app_name }}/*.log
  fields:
    service: {{ app_name }}
    environment: {{ environment }}
    hostname: {{ inventory_hostname }}
  fields_under_root: true
  multiline.pattern: '^\d{4}-\d{2}-\d{2}'
  multiline.negate: true
  multiline.match: after

- type: log
  enabled: true
  paths:
    - /var/log/nginx/access.log
    - /var/log/nginx/error.log
  fields:
    service: nginx
    log_type: webserver

output.elasticsearch:
  hosts: ["{{ elasticsearch_host }}:{{ elasticsearch_port }}"]
  {% if elasticsearch_auth_enabled %}
  username: "{{ elasticsearch_username }}"
  password: "{{ vault_elasticsearch_password }}"
  {% endif %}
  index: "{{ app_name }}-%{+yyyy.MM.dd}"

processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~

logging.level: info
logging.to_files: true
logging.files:
  path: /var/log/filebeat
  name: filebeat
  keepfiles: 7
  permissions: 0644
```

---

## 🔄 Advanced Ansible Techniques

### Dynamic Playbook Generation

```yaml
---
- name: Dynamic Playbook Generator
  hosts: localhost
  gather_facts: no
  vars:
    service_definitions:
      - name: frontend
        type: web
        count: 3
        dependencies: [backend]
      - name: backend
        type: api
        count: 2
        dependencies: [database, redis]
      - name: database
        type: data
        count: 1
        dependencies: []
      - name: redis
        type: cache
        count: 1
        dependencies: []
        
  tasks:
    - name: Generate deployment order
      set_fact:
        deployment_order: "{{ service_definitions | community.general.dependency_sort('dependencies') }}"

    - name: Deploy services in dependency order
      include_tasks: deploy-service.yml
      vars:
        service: "{{ item }}"
      loop: "{{ deployment_order }}"

    - name: Wait for all services to be healthy
      uri:
        url: "http://{{ item.host }}/health"
        method: GET
        status_code: 200
      loop: "{{ deployed_services }}"
      retries: 5
      delay: 10
```

### Ansible with Terraform Integration

```yaml
---
- name: Terraform + Ansible Integration
  hosts: localhost
  gather_facts: no
  
  tasks:
    - name: Run Terraform to provision infrastructure
      terraform:
        project_path: "{{ terraform_project_path }}"
        state: present
        variables:
          environment: "{{ environment }}"
          instance_count: "{{ instance_count }}"
          instance_type: "{{ instance_type }}"
      register: terraform_output

    - name: Extract instance information
      set_fact:
        terraform_instances: "{{ terraform_output.outputs.instance_ips.value }}"

    - name: Add Terraform instances to inventory
      add_host:
        name: "{{ item.name }}"
        groups: "{{ item.role }}"
        ansible_host: "{{ item.public_ip }}"
        ansible_user: ubuntu
        ansible_ssh_private_key_file: "{{ ssh_private_key }}"
      loop: "{{ terraform_instances }}"

    - name: Wait for instances to be ready
      wait_for:
        host: "{{ item.public_ip }}"
        port: 22
        delay: 30
        timeout: 300
      loop: "{{ terraform_instances }}"

- name: Configure Terraform-provisioned instances
  hosts: all:!localhost
  become: yes
  
  roles:
    - common
    - "{{ ansible_host_role }}"  # Role based on host group
```

---

## 💡 Tips for Senior DevOps Engineers

### Code Review Guidelines

#### Ansible Playbook Review Checklist

```markdown
## Playbook Review Checklist

### Structure and Organization
- [ ] Proper YAML indentation and syntax
- [ ] Descriptive task names
- [ ] Logical task organization
- [ ] Appropriate use of roles vs tasks
- [ ] Clear variable naming conventions

### Security
- [ ] No hardcoded secrets or passwords
- [ ] Proper use of Ansible Vault
- [ ] Minimal privilege escalation
- [ ] no_log used for sensitive tasks
- [ ] Input validation where needed

### Performance
- [ ] Efficient module usage
- [ ] Proper use of loops vs individual tasks
- [ ] Async tasks for long operations
- [ ] Fact gathering optimization
- [ ] Appropriate serial/parallel execution

### Reliability
- [ ] Error handling and rollback procedures
- [ ] Health checks and validation
- [ ] Idempotency considerations
- [ ] Retry logic where appropriate
- [ ] Meaningful failure messages

### Maintainability
- [ ] Proper documentation and comments
- [ ] Consistent formatting
- [ ] Reusable components
- [ ] Version control best practices
- [ ] Clear variable definitions
```

### Advanced Testing Strategies

#### Molecule Testing Framework

```yaml
# molecule/default/molecule.yml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: instance
    image: quay.io/ansible/molecule-goss:latest
    pre_build_image: true
provisioner:
  name: ansible
  inventory:
    host_vars:
      instance:
        ansible_connection: docker
verifier:
  name: goss
```

#### Test Playbook

```yaml
# molecule/default/converge.yml
---
- name: Converge
  hosts: all
  tasks:
    - name: Include role
      include_role:
        name: webserver
```

#### Verification Tests

```yaml
# molecule/default/verify.yml
---
- name: Verify
  hosts: all
  gather_facts: false
  tasks:
    - name: Check if nginx is running
      service:
        name: nginx
        state: started
      check_mode: yes
      register: nginx_status

    - name: Verify nginx service
      assert:
        that:
          - not nginx_status.changed
        fail_msg: "Nginx is not running"

    - name: Test HTTP response
      uri:
        url: http://localhost
        method: GET
        status_code: 200
```

---

## 📋 Final Notes and Resources

### Essential Ansible Collections

```bash
# Install essential collections
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install community.docker
ansible-galaxy collection install kubernetes.core
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install azure.azcollection
ansible-galaxy collection install google.cloud
```

### Production-Ready ansible.cfg

```ini
[defaults]
# Basic configuration
inventory = ./inventory
library = ./library
module_utils = ./module_utils
remote_tmp = ~/.ansible/tmp
local_tmp = ~/.ansible/tmp
plugin_filters_cfg = ./ansible.cfg
forks = 50
poll_interval = 15
ask_pass = False
transport = ssh

# Privilege escalation
become = False
become_method = sudo
become_user = root
become_ask_pass = False

# SSH settings
host_key_checking = False
timeout = 30
ansible_managed = Ansible managed: {file} modified on %Y-%m-%d %H:%M:%S by {uid} on {host}

# Logging
log_path = ./logs/ansible.log
display_skipped_hosts = False
display_ok_hosts = True
bin_ansible_callbacks = True

# Performance
fact_caching = jsonfile
fact_caching_connection = ./tmp/facts_cache
fact_caching_timeout = 86400
fact_caching_prefix = ansible_facts_
gathering = smart
gather_subset = all
gather_timeout = 10

# Callback plugins
stdout_callback = yaml
callbacks_enabled = timer, profile_tasks, profile_roles

[inventory]
enable_plugins = host
