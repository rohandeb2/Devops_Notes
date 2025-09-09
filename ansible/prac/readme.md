# Ansible Infrastructure Automation

[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/nginx-%23009639.svg?style=for-the-badge&logo=nginx&logoColor=white)](https://nginx.org/)

A comprehensive Ansible project for automating infrastructure provisioning and configuration management across multiple environments.

## 🏗️ Project Structure

```
ansible/
├── inventories/
│   ├── dev              # Development environment inventory
│   └── prd              # Production environment inventory
├── playbooks/
│   ├── install_nginx.yml    # Nginx installation playbook
│   └── install_docker.yml   # Docker installation and configuration playbook
├── group_vars/          # Group-specific variables
├── host_vars/           # Host-specific variables
└── README.md
```

## 🎯 Features

- **Multi-Environment Support**: Separate inventories for development and production environments
- **Docker Automation**: Complete Docker installation and user management
- **Web Server Setup**: Nginx installation and configuration
- **Cross-Platform Support**: Compatible with Ubuntu and CentOS/RHEL systems
- **Idempotent Operations**: All playbooks are designed to be run multiple times safely

## 📋 Prerequisites

- Ansible 2.9+ installed on the control node
- SSH access to target hosts
- Sudo privileges on target hosts
- Python 3.6+ on target hosts

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd ansible
```

### 2. Configure Inventory

Update the inventory files with your server details:

**Development Environment** (`inventories/dev`):
```ini
[junoon_servers]
server1 ansible_host=<dev-server-1-ip>
server2 ansible_host=<dev-server-2-ip>

[all:vars]
ansible_user=your-username
ansible_ssh_private_key_file=path/to/your/key.pem
```

**Production Environment** (`inventories/prd`):
```ini
[junoon_servers]
server1 ansible_host=<prod-server-1-ip>
server2 ansible_host=<prod-server-2-ip>

[all:vars]
ansible_user=your-username
ansible_ssh_private_key_file=path/to/your/key.pem
```

### 3. Test Connectivity

```bash
# Test development environment
ansible -i inventories/dev all -m ping

# Test production environment
ansible -i inventories/prd all -m ping
```

## 🔧 Available Playbooks

### Docker Installation (`install_docker.yml`)

Installs and configures Docker on target hosts with the following features:
- Automatic OS detection (Ubuntu/CentOS)
- Docker CE installation
- User addition to docker group
- Service enablement and startup
- Post-installation verification

**Usage:**
```bash
# Development environment
ansible-playbook -i inventories/dev playbooks/install_docker.yml

# Production environment
ansible-playbook -i inventories/prd playbooks/install_docker.yml
```

### Nginx Installation (`install_nginx.yml`)

Installs and configures Nginx web server:
- Package installation
- Service configuration
- Automatic startup enablement

**Usage:**
```bash
# Development environment
ansible-playbook -i inventories/dev playbooks/install_nginx.yml

# Production environment
ansible-playbook -i inventories/prd playbooks/install_nginx.yml
```

## 🎮 Common Commands

### Inventory Management

```bash
# List all hosts in inventory
ansible-inventory -i inventories/dev --list

# Check specific host facts
ansible -i inventories/dev server1 -m setup
```

### Ad-hoc Commands

```bash
# Check system memory
ansible -i inventories/dev junoon_servers -a "free -h"

# Check disk usage
ansible -i inventories/dev junoon_servers -a "df -h"

# Check Docker status
ansible -i inventories/dev all -a "sudo systemctl status docker"

# Run Docker hello-world
ansible -i inventories/dev all -a "sudo docker run hello-world"
```

### System Updates

```bash
# Update packages (Ubuntu)
ansible -i inventories/dev all -a "sudo apt-get update" -b

# Update packages (CentOS/RHEL)
ansible -i inventories/dev all -a "sudo yum update" -b
```

## 🔍 Troubleshooting

### Common Issues

1. **Connection Issues**
   ```bash
   # Verbose output for debugging
   ansible -i inventories/dev server1 -m ping -vvv
   ```

2. **Permission Issues**
   ```bash
   # Check user permissions
   ansible -i inventories/dev server1 -a "id"
   ```

3. **Docker Service Issues**
   ```bash
   # Check Docker service logs
   ansible -i inventories/dev server1 -b -m shell -a "journalctl -xeu docker.service --no-pager | tail -n 50"
   ```

4. **Package Lock Issues (Ubuntu)**
   ```bash
   # Check for lock files
   ansible -i inventories/dev server1 -a "sudo lsof /var/lib/dpkg/lock-frontend"
   ```

## 🏷️ Tags and Filters

Use tags to run specific parts of playbooks:

```bash
# Run only installation tasks
ansible-playbook -i inventories/dev playbooks/install_docker.yml --tags "install"

# Skip certain tasks
ansible-playbook -i inventories/dev playbooks/install_docker.yml --skip-tags "user_management"
```

## 📊 Monitoring and Verification

After running playbooks, verify the installation:

```bash
# Verify Docker installation
ansible -i inventories/dev all -a "docker --version"

# Check running containers
ansible -i inventories/dev all -a "sudo docker ps"

# Verify Nginx status
ansible -i inventories/dev all -a "sudo systemctl status nginx"
```

## 🔐 Security Best Practices

1. **SSH Key Management**: Use dedicated SSH keys for Ansible
2. **Privilege Escalation**: Use `become` only when necessary
3. **Vault Usage**: Encrypt sensitive variables using Ansible Vault
4. **Inventory Security**: Keep inventory files secure and version-controlled

```bash
# Encrypt sensitive data
ansible-vault encrypt group_vars/all/secrets.yml

# Run playbook with vault
ansible-playbook -i inventories/prd playbooks/install_docker.yml --ask-vault-pass
```

## 🌍 Multi-Environment Deployment

Deploy across environments using different inventory files:

```bash
# Deploy to development
ansible-playbook -i inventories/dev playbooks/install_docker.yml

# Deploy to production (with confirmation)
ansible-playbook -i inventories/prd playbooks/install_docker.yml --check --diff
```

## 📈 Performance Optimization

- **Parallel Execution**: Ansible runs tasks in parallel by default
- **Fact Caching**: Enable fact caching for better performance
- **Pipelining**: Enable SSH pipelining in ansible.cfg

```ini
# ansible.cfg
[defaults]
host_key_checking = False
pipelining = True
gathering = smart
fact_caching = memory
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-playbook`)
3. Commit your changes (`git commit -am 'Add new playbook'`)
4. Push to the branch (`git push origin feature/new-playbook`)
5. Create a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the [Ansible Documentation](https://docs.ansible.com/)
- Review the troubleshooting section above

## 📚 Additional Resources

- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)

---

**Author**: DevOps Team  
**Last Updated**: September 2025  
**Version**: 1.0.0
