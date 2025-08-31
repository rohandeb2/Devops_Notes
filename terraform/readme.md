# 🚀 Complete Terraform Handbook for Absolute Beginners

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A comprehensive handbook that takes you from zero to Terraform expert, with theory, examples, and hands-on practice.

---

## 📋 Table of Contents

1. [What is Infrastructure?](#-what-is-infrastructure)
2. [The Old Way vs The New Way](#-the-old-way-vs-the-new-way)
3. [What is Infrastructure as Code?](#-what-is-infrastructure-as-code)
4. [What is Terraform?](#-what-is-terraform)
5. [Installing Terraform](#-installing-terraform)
6. [Understanding HCL Language](#-understanding-hcl-language)
7. [Your First Terraform Project](#-your-first-terraform-project)
8. [Terraform Workflow Explained](#-terraform-workflow-explained)
9. [Understanding Providers](#-understanding-providers)
10. [Working with Resources](#-working-with-resources)
11. [Variables Deep Dive](#-variables-deep-dive)
12. [Outputs Explained](#-outputs-explained)
13. [Terraform State Management](#-terraform-state-management)
14. [Working with Cloud (AWS)](#-working-with-cloud-aws)
15. [Modules - Making Code Reusable](#-modules---making-code-reusable)
16. [Best Practices](#-best-practices)
17. [Common Problems & Solutions](#-common-problems--solutions)
18. [Advanced Concepts](#-advanced-concepts)

---

## 🏗️ What is Infrastructure?

### Think of Infrastructure Like Building a House

When you build a house, you need:
- **Foundation** (servers/computers)
- **Electricity** (networking)
- **Plumbing** (databases)
- **Rooms** (applications)
- **Security** (firewalls)

In the digital world, **infrastructure** is all the technology components that support your applications:

```
Your Website/App
       ↓
   Web Servers ← (Infrastructure)
       ↓
   Databases ← (Infrastructure)
       ↓
   Networks ← (Infrastructure)
       ↓
Physical/Cloud Servers ← (Infrastructure)
```

### Examples of Infrastructure Components:
- **Servers**: Computers that run your applications
- **Databases**: Store your data (like user information)
- **Load Balancers**: Distribute traffic across multiple servers
- **Networks**: Connect everything together
- **Storage**: Save files, images, backups
- **Security Groups**: Control who can access what

---

## 🔄 The Old Way vs The New Way

### 🐌 The Old Way (Manual Infrastructure)

**Scenario**: You need to set up a web server

**Steps**:
1. Call your IT team or cloud provider
2. Wait for them to create a server
3. Manually install software
4. Manually configure settings
5. Manually set up security
6. Document everything manually
7. Hope you remember all steps for next time

**Problems**:
- Takes days or weeks
- Human errors (typos, missed steps)
- Hard to repeat exactly
- No version control
- Difficult to scale
- Hard to rollback changes

### ⚡ The New Way (Infrastructure as Code)

**Scenario**: Same web server setup

**Steps**:
1. Write a configuration file describing what you want
2. Run one command
3. Infrastructure is created automatically
4. Everything is documented in code
5. Can be repeated perfectly every time

**Benefits**:
- Takes minutes, not days
- No human errors
- Perfectly repeatable
- Version controlled like code
- Easy to scale
- Easy to rollback

---

## 🤖 What is Infrastructure as Code?

### Simple Definition
**Infrastructure as Code (IaC)** means describing your infrastructure using code/text files instead of clicking buttons or calling people.

### Think of it Like a Recipe

**Traditional Way** (Manual):
```
"Call the chef, tell them to make pasta, 
hope they remember all ingredients and steps"
```

**IaC Way** (Automated):
```
Recipe File:
- 1 cup pasta
- 2 cups water
- 1 tsp salt
- Boil water, add salt, add pasta, cook 10 minutes
```

### IaC in Real Terms

Instead of:
- Logging into AWS console
- Clicking "Create EC2 Instance"
- Filling forms manually
- Repeating for each server

You write:
```hcl
resource "aws_instance" "my_server" {
  ami           = "ami-12345"
  instance_type = "t2.micro"
}
```

And run: `terraform apply` - Done! Server created automatically.

### Key IaC Benefits:

1. **Reproducible**: Same code = Same infrastructure every time
2. **Version Control**: Track changes like any code
3. **Documentation**: Code IS the documentation
4. **Collaboration**: Teams can work together
5. **Testing**: Test infrastructure changes safely
6. **Automation**: Integrate with CI/CD pipelines

---

## 🌟 What is Terraform?

### Simple Definition
**Terraform** is a tool that lets you write infrastructure as code. Think of it as a translator that takes your infrastructure wishes (written in code) and makes them real in the cloud.

### How Terraform Works - Simple Analogy

**You are like an Architect**, and **Terraform is like a Construction Manager**:

1. **You write blueprints** (Terraform configuration files)
2. **Terraform reads your blueprints** and understands what you want
3. **Terraform talks to cloud providers** (AWS, Azure, Google Cloud)
4. **Terraform builds everything** according to your blueprints

```
You Write Code → Terraform Reads → Cloud Provider Creates → Infrastructure Ready
```

### What Makes Terraform Special?

#### 1. **Multi-Cloud Support**
- Works with AWS, Azure, Google Cloud, and 100+ other providers
- You can manage different clouds with the same tool
- No vendor lock-in

#### 2. **Declarative Language**
- You describe WHAT you want, not HOW to build it
- Terraform figures out the steps
- Like ordering at a restaurant - you say "I want pizza", not "mix flour, add water..."

#### 3. **State Management**
- Terraform remembers what it built
- Can detect changes and fix drift
- Knows what to update, create, or delete

#### 4. **Plan Before Apply**
- Shows you exactly what will change before doing it
- No surprises!

### Terraform Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Your Code     │───▶│    Terraform    │───▶│  Cloud Provider │
│  (.tf files)    │    │     Engine      │    │  (AWS/Azure)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │ Terraform State │
                       │   (memory)      │
                       └─────────────────┘
```

---

## 🔧 Installing Terraform

### Step 1: Check Your Operating System

#### 🐧 Linux (Ubuntu/Debian)
```bash
# Update your package list
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Download HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository to your system
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package list again
sudo apt update

# Install Terraform
sudo apt-get install terraform
```

#### 🍎 macOS
```bash
# If you have Homebrew installed
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# If you don't have Homebrew, install it first:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 🪟 Windows
1. Go to [Terraform Downloads](https://www.terraform.io/downloads.html)
2. Download Windows version
3. Extract to a folder (like `C:\terraform`)
4. Add to system PATH environment variable

**Or use Chocolatey:**
```powershell
choco install terraform
```

### Step 2: Verify Installation
```bash
terraform --version
```
You should see something like: `Terraform v1.6.0`

### Step 3: Install a Code Editor (Recommended)
- **VS Code** with HashiCorp Terraform extension
- **IntelliJ IDEA** with Terraform plugin
- Any text editor works, but these provide syntax highlighting

---

## 📝 Understanding HCL Language

### What is HCL?
**HCL (HashiCorp Configuration Language)** is the language Terraform uses. It's designed to be human-readable and easy to learn.

### Basic HCL Concepts

#### 1. **Comments**
```hcl
# This is a single-line comment

/*
This is a
multi-line comment
*/
```

#### 2. **Arguments** (Key-Value Pairs)
Think of arguments like filling out a form:
```hcl
name = "John"           # String value
age = 25               # Number value
is_student = true      # Boolean value
```

#### 3. **Blocks** (Containers)
Blocks are like sections that contain related information:
```hcl
person {                # Block type: "person"
  name = "John"        # Arguments inside the block
  age = 25
  is_student = true
}
```

#### 4. **Block with Labels**
Some blocks need labels (like IDs or names):
```hcl
resource "aws_instance" "my_server" {  # Block with 2 labels
  ami = "ami-12345"
  instance_type = "t2.micro"
}
```
- `resource` = block type
- `"aws_instance"` = first label (resource type)
- `"my_server"` = second label (resource name)

### Data Types in HCL

#### 1. **String** (Text)
```hcl
server_name = "web-server"
description = "This is my web server"
```

#### 2. **Number**
```hcl
port = 80
instance_count = 3
```

#### 3. **Boolean** (True/False)
```hcl
enable_monitoring = true
is_production = false
```

#### 4. **List** (Array of items)
```hcl
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
ports = [80, 443, 8080]
```

#### 5. **Map** (Key-Value pairs)
```hcl
tags = {
  Environment = "production"
  Owner = "john@company.com"
  Project = "website"
}
```

#### 6. **Object** (Complex structure)
```hcl
database_config = {
  name = "myapp_db"
  port = 5432
  encrypted = true
  backup_enabled = true
}
```

### HCL Syntax Rules

1. **Case Sensitive**: `Name` and `name` are different
2. **Quotes**: Use double quotes for strings `"hello"`
3. **Lists**: Use square brackets `[item1, item2]`
4. **Maps/Objects**: Use curly braces `{key = value}`
5. **Comments**: Use `#` for single line, `/* */` for multi-line

---

## 🚀 Your First Terraform Project

### Understanding the Concept
We'll create a simple text file using Terraform. This helps you understand the workflow without needing cloud accounts.

### Step 1: Create Project Directory
```bash
mkdir my-first-terraform-project
cd my-first-terraform-project
```

### Step 2: Create Your First Terraform File
Create a file named `main.tf`:
```hcl
# This tells Terraform we want to create a local file
resource "local_file" "welcome" {
  # The content of the file
  content = "Welcome to Terraform! This file was created by code."
  
  # Where to save the file
  filename = "welcome.txt"
}
```

**Let's understand each part:**
- `resource` = We're creating a resource (something Terraform manages)
- `"local_file"` = Type of resource (a file on local computer)
- `"welcome"` = Name we give to this resource (like a variable name)
- `content` = What goes inside the file
- `filename` = What to name the file and where to put it

### Step 3: Initialize Terraform
```bash
terraform init
```

**What happens:**
- Terraform scans your `.tf` files
- Downloads the "local" provider (needed to create files)
- Creates `.terraform` directory with provider files
- Creates `.terraform.lock.hcl` file

**You should see:**
```
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Installing hashicorp/local v2.4.0...
Terraform has been successfully initialized!
```

### Step 4: Plan Your Changes
```bash
terraform plan
```

**What happens:**
- Terraform reads your configuration
- Compares with current state (nothing exists yet)
- Shows you what will be created/changed/destroyed

**You should see:**
```
Terraform will perform the following actions:

  # local_file.welcome will be created
  + resource "local_file" "welcome" {
      + content              = "Welcome to Terraform! This file was created by code."
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "welcome.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

### Step 5: Apply Your Changes
```bash
terraform apply
```

Terraform will show the plan again and ask for confirmation. Type `yes`:

**What happens:**
- Terraform creates the file `welcome.txt`
- Saves the current state in `terraform.tfstate`

**Check your directory:**
```bash
ls -la
```
You should see `welcome.txt` has been created!

**Read the file:**
```bash
cat welcome.txt
```
Output: `Welcome to Terraform! This file was created by code.`

### Congratulations! 🎉
You just:
1. Wrote infrastructure as code
2. Planned your changes
3. Applied your infrastructure
4. Created your first Terraform-managed resource

---

## 🔄 Terraform Workflow Explained

### The Three-Step Dance
Terraform follows a simple, predictable workflow:

```
1. INIT  →  2. PLAN  →  3. APPLY
   ↓           ↓           ↓
Download    Preview     Execute
Providers   Changes     Changes
```

### Step 1: `terraform init` 🏁

**Purpose**: Set up your project and download required tools

**What it does:**
- Scans all `.tf` files in current directory
- Identifies required providers (aws, local, docker, etc.)
- Downloads provider plugins
- Sets up backend for state storage
- Creates `.terraform` directory

**When to run:**
- First time in a new project
- After adding new providers
- After changing backend configuration

**Output explained:**
```bash
Initializing the backend...               # Setting up state storage
Initializing provider plugins...          # Getting the tools needed
- Finding latest version of hashicorp/local...  # Checking versions
- Installing hashicorp/local v2.4.0...    # Downloading tools
Terraform has been successfully initialized! # Ready to go!
```

### Step 2: `terraform plan` 📋

**Purpose**: Preview what Terraform will do (like a "dry run")

**What it does:**
- Reads your configuration files
- Compares with current state
- Queries real resources to check current status
- Creates an execution plan
- Shows you exactly what will change

**The Plan Output Symbols:**
- `+` = **Create** (new resource)
- `~` = **Update** (change existing resource)  
- `-` = **Delete** (remove resource)
- `-/+` = **Replace** (delete and recreate)

**Example Plan Output:**
```hcl
# local_file.welcome will be created
+ resource "local_file" "welcome" {
    + content = "Hello World"
    + filename = "hello.txt"
    + id = (known after apply)  # Will be generated
}

Plan: 1 to add, 0 to change, 0 to destroy.
```

**Why Planning is Important:**
- Prevents surprises
- Lets you review changes before applying
- Helps catch errors early
- Shows impact of your changes

### Step 3: `terraform apply` ⚡

**Purpose**: Execute the planned changes

**What it does:**
- Shows the plan again (safety check)
- Asks for your confirmation (unless using `-auto-approve`)
- Executes the changes in correct order
- Updates the state file
- Shows results

**Safety Features:**
- Always shows plan first
- Asks for confirmation
- Can be cancelled with Ctrl+C (before confirmation)
- Atomic operations (all or nothing)

### Additional Workflow Commands

#### `terraform fmt` ✨
```bash
terraform fmt
```
**Purpose**: Format your code nicely (like auto-formatting in code editors)
**When to use**: Before committing code, or anytime your code looks messy

#### `terraform validate` ✅
```bash
terraform validate
```
**Purpose**: Check if your configuration is valid
**When to use**: After writing code, before planning

#### `terraform show` 👀
```bash
terraform show
```
**Purpose**: Display current state in human-readable format
**When to use**: When you want to see what resources exist

#### `terraform destroy` 💥
```bash
terraform destroy
```
**Purpose**: Delete all resources managed by this Terraform configuration
**When to use**: When you want to clean up everything (be careful!)

### Complete Workflow Example

Let's walk through a complete workflow:

```bash
# 1. Create and edit main.tf
echo 'resource "local_file" "test" {
  content = "Testing workflow"
  filename = "test.txt"
}' > main.tf

# 2. Initialize
terraform init

# 3. Validate syntax
terraform validate
# Success! The configuration is valid.

# 4. Format code
terraform fmt

# 5. Plan changes
terraform plan

# 6. Apply changes
terraform apply
# yes

# 7. Check what we built
terraform show

# 8. Clean up when done
terraform destroy
# yes
```

### Workflow Best Practices

1. **Always run `plan` before `apply`**
   - Never skip the planning step
   - Review changes carefully

2. **Use version control**
   - Commit your `.tf` files
   - Never commit `.tfstate` files
   - Use `.gitignore`

3. **Test in stages**
   - Test changes in development environment first
   - Use workspaces for different environments

4. **Keep state safe**
   - Use remote state storage for teams
   - Enable state locking
   - Regular backups

---

## 🔌 Understanding Providers

### What is a Provider?

Think of a **provider** as a translator. Just like you need a translator to speak different languages, Terraform needs providers to speak to different services.

```
You (English) ←→ Translator ←→ French Person
You (HCL) ←→ Provider ←→ Cloud Service (AWS/Azure/etc.)
```

### How Providers Work

1. **You write configuration** in HCL
2. **Provider translates** your configuration into API calls
3. **Cloud service** receives API calls and creates resources
4. **Provider reports back** to Terraform what happened

### Provider Types

#### 1. **Cloud Providers**
- `aws` - Amazon Web Services
- `azurerm` - Microsoft Azure
- `google` - Google Cloud Platform

#### 2. **Infrastructure Providers**  
- `docker` - Docker containers
- `kubernetes` - Kubernetes clusters
- `vsphere` - VMware vSphere

#### 3. **Network Providers**
- `cloudflare` - Cloudflare DNS/CDN
- `dns` - DNS records

#### 4. **Local Providers**
- `local` - Local files and commands
- `random` - Random values
- `time` - Time-based resources

### Configuring Providers

#### Basic Provider Configuration
```hcl
# Tell Terraform which providers you need
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# Configure the provider (if needed)
provider "local" {
  # Local provider doesn't need configuration
}
```

#### Understanding Provider Versions

**Version Constraints:**
- `~> 2.4` = "At least 2.4, but less than 3.0" (pessimistic constraint)
- `>= 2.4` = "At least version 2.4"
- `= 2.4.1` = "Exactly version 2.4.1"
- `>= 2.4, < 3.0` = "Between 2.4 and 3.0"

**Why specify versions?**
- Ensures reproducible deployments
- Prevents breaking changes
- Team consistency

### Working with Docker Provider

Let's use Docker as an example to understand providers better:

#### Step 1: Install Docker
```bash
# Ubuntu/Debian
sudo apt-get install docker.io
sudo usermod -aG docker $USER
# Log out and back in, or:
sudo chown $USER /var/run/docker.sock
```

#### Step 2: Provider Configuration
```hcl
# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  # Docker provider will connect to local Docker daemon
}
```

#### Step 3: Use Docker Resources
```hcl
# Download an image
resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = false
}

# Create a container
resource "docker_container" "nginx_server" {
  name  = "my-nginx-server"
  image = docker_image.nginx.image_id
  
  ports {
    internal = 80
    external = 8080
  }
}
```

#### Step 4: Deploy
```bash
terraform init    # Downloads docker provider
terraform plan    # Shows what will be created
terraform apply   # Creates image and container

# Test your container
curl http://localhost:8080
```

### Provider Resource Naming Convention

All provider resources follow this pattern:
```hcl
resource "PROVIDER_RESOURCETYPE" "NAME" {
  # configuration
}
```

Examples:
```hcl
# AWS provider resources
resource "aws_instance" "web_server" {}        # EC2 instance
resource "aws_s3_bucket" "storage" {}          # S3 bucket

# Docker provider resources  
resource "docker_image" "app" {}               # Docker image
resource "docker_container" "app_container" {} # Docker container

# Local provider resources
resource "local_file" "config" {}              # Local file
```

### Data Sources vs Resources

#### Resources = Things Terraform Creates/Manages
```hcl
resource "docker_container" "web" {
  name = "my-container"
  image = "nginx"
}
```

#### Data Sources = Information Terraform Reads
```hcl
data "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

# Use the data source in a resource
resource "docker_container" "app" {
  name = "my-app"
  image = data.docker_image.ubuntu.image_id
}
```

### Multiple Providers in One Configuration

You can use multiple providers together:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# Generate a random name
resource "random_string" "bucket_name" {
  length = 8
  lower  = true
  upper  = false
  special = false
}

# Use it in AWS resource
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-${random_string.bucket_name.result}"
}
```

### Finding Providers

**Terraform Registry**: [registry.terraform.io](https://registry.terraform.io)
- Browse all available providers
- Read documentation
- See usage examples
- Check version history

---

## 🧩 Working with Resources

### What is a Resource?

A **resource** is anything that Terraform can create, update, or delete. Think of resources as the "nouns" of your infrastructure.

Examples of resources:
- A server (like AWS EC2 instance)
- A database (like AWS RDS)
- A file (like local_file)
- A container (like docker_container)
- A DNS record
- A user account

### Resource Syntax

Every resource follows this pattern:
```hcl
resource "PROVIDER_TYPE" "LOCAL_NAME" {
  argument1 = value1
  argument2 = value2
  
  nested_block {
    nested_arg = value
  }
}
```

Let's break this down:
- `resource` = keyword (tells Terraform this is a resource)
- `"PROVIDER_TYPE"` = what kind of resource (like "local_file", "aws_instance")
- `"LOCAL_NAME"` = what YOU call it (like a variable name)
- Inside `{}` = configuration for this resource

### Resource Examples

#### 1. Creating a Local File
```hcl
resource "local_file" "my_resume" {
  content = <<-EOT
    John Doe
    DevOps Engineer
    Skills: Terraform, AWS, Docker
  EOT
  filename = "resume.txt"
}
```

#### 2. Generating Random Values
```hcl
# First add random provider
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

resource "random_string" "password" {
  length = 16
  special = true
  override_special = "!@#$%&*"
}

# Use the random value in another resource
resource "local_file" "password_file" {
  content = "Generated password: ${random_string.password.result}"
  filename = "password.txt"
  file_permission = "0600"  # Only owner can read
}
```

### Resource Arguments vs Attributes

#### Arguments (Inputs)
Things YOU specify when creating a resource:
```hcl
resource "local_file" "config" {
  content = "Hello World"    # ← You provide this
  filename = "config.txt"    # ← You provide this
}
```

#### Attributes (Outputs)
Things Terraform generates after creating the resource:
```hcl
# After terraform apply, you can reference:
output "file_id" {
  value = local_file.config.id           # ← Terraform generates this
}

output "content_md5" {
  value = local_file.config.content_md5  # ← Terraform generates this
}
```

### Resource Dependencies

#### Implicit Dependencies (Automatic)
When one resource references another, Terraform automatically knows the order:

```hcl
# Terraform knows to create random_string first
resource "random_string" "suffix" {
  length = 4
}

# Then create this file (because it references random_string)
resource "local_file" "named_file" {
  filename = "file_${random_string.suffix.result}.txt"
  content = "This file has a random suffix"
}
```

#### Explicit Dependencies (Manual)
Sometimes you need to specify dependencies manually:

```hcl
resource "local_file" "first" {
  filename = "first.txt"
  content = "I should be created first"
}

resource "local_file" "second" {
  filename = "second.txt"
  content = "I should be created second"
  
  # Force this to wait for 'first' to complete
  depends_on = [local_file.first]
}
```

### Resource Lifecycle

You can control how Terraform manages resources:

```hcl
resource "local_file" "important_file" {
  filename = "important.txt"
  content = "Don't delete me!"
  
  lifecycle {
    prevent_destroy = true           # Never allow terraform destroy
    ignore_changes = [content]       # Ignore changes to content
    create_before_destroy = true     # Create new before destroying old
  }
}
```

### Multiple Resources with Count

Create multiple similar resources:

```hcl
resource "local_file" "numbered_files" {
  count = 3
  
  filename = "file_${count.index}.txt"
  content = "This is file number ${count.index}"
}

# This creates:
# file_0.txt - "This is file number 0"
# file_1.txt - "This is file number 1" 
# file_2.txt - "This is file number 2"
```

### Multiple Resources with for_each

Create resources based on a set or map:

```hcl
variable "file_names" {
  default = ["config", "data", "backup"]
}

resource "local_file" "named_files" {
  for_each = toset(var.file_names)
  
  filename = "${each.value}.txt"
  content = "This is the ${each.value} file"
}

# This creates:
# config.txt - "This is the config file"
# data.txt - "This is the data file"
# backup.txt - "This is the backup file"
```

### Practical Exercise: Multi-Resource Project

Let's create a project with multiple connected resources:

```hcl
# main.tf
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.4"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

# Generate a random project ID
resource "random_string" "project_id" {
  length = 8
  lower = true
  upper = false
  special = false
}

# Create project directory (as a file)
resource "local_file" "project_info" {
  filename = "project_${random_string.project_id.result}/info.txt"
  content = <<-EOT
    Project ID: ${random_string.project_id.result}
    Created: ${timestamp()}
    Status: Active
  EOT
}

# Create configuration file
resource "local_file" "config" {
  filename = "project_${random_string.project_id.result}/config.yml"
  content = <<-EOT
    project:
      id: ${random_string.project_id.result}
      name: "My Terraform Project"
      environment: "development"
      settings:
        debug: true
        auto_backup: false
  EOT
  
  depends_on = [local_file.project_info]
}

# Create a README file
resource "local_file" "readme" {
  filename = "project_${random_string.project_id.result}/README.md"
  content = <<-EOT
    # Project ${random_string.project_id.result}
    
    This project was created using Terraform.
    
    ## Files
    - info.txt: Project information
    - config.yml: Project configuration
    - README.md: This file
    
    ## Created
    ${timestamp()}
  EOT
}
```

**Run this project:**
```bash
terraform init
terraform plan
terraform apply
```

You'll get a complete project directory with multiple connected files!

---

## 🔧 Variables Deep Dive

### Why Use Variables?

Variables make your Terraform code:
- **Reusable**: Same code, different values
- **Flexible**: Easy to change without editing main code
- **Secure**: Sensitive values can be hidden
- **Maintainable**: Changes in one place affect everywhere

### Think of Variables Like Form Fields

**Without Variables** (Hard-coded):
```hcl
resource "local_file" "greeting" {
  filename = "hello.txt"
  content = "Hello, John! You are 25 years old."
}
```
Problem: To change the name or age, you must edit the code.

**With Variables** (Flexible):
```hcl
variable "name" {
  default = "John"
}

variable "age" {
  default = 25
}

resource "local_file" "greeting" {
  filename = "hello.txt"
  content = "Hello, ${var.name}! You are ${var.age} years old."
}
```
Now you can change values without changing code!

### Variable Declaration Syntax

```hcl
variable "VARIABLE_NAME" {
  description = "What this variable is for"
  type        = string  # or number, bool, list, map, object
  default     = "default_value"
  sensitive   = false   # true to hide value in logs
  
  validation {
    condition     = length(var.VARIABLE_NAME) > 0
    error_message = "Variable cannot be empty."
  }
}
```

### Variable Types Explained

#### 1. **String** (Text)
```hcl
variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "web-server"
}

# Usage
resource "local_file" "server_config" {
  filename = "${var.server_name}.conf"
  content  = "Server name: ${var.server_name}"
}
```

#### 2. **Number** (Integer or Decimal)
```hcl
variable "port" {
  description = "Port number for the service"
  type        = number
  default     = 80
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

# Usage
resource "local_file" "config" {
  filename = "server.conf"
  content  = "Port: ${var.port}\nCPU Cores: ${var.cpu_cores}"
}
```

#### 3. **Boolean** (True/False)
```hcl
variable "enable_logging" {
  description = "Enable application logging"
  type        = bool
  default     = true
}

variable "is_production" {
  description = "Is this a production environment"
  type        = bool
  default     = false
}

# Usage with conditional
resource "local_file" "app_config" {
  filename = "app.conf"
  content  = "Logging: ${var.enable_logging ? "enabled" : "disabled"}"
}
```

#### 4. **List** (Array of Items)
```hcl
variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default     = [80, 443, 8080]
}

variable "server_names" {
  description = "List of server names"
  type        = list(string)
  default     = ["web1", "web2", "web3"]
}

# Usage - access by index
resource "local_file" "port_config" {
  filename = "ports.conf"
  content  = "First port: ${var.allowed_ports[0]}"  # 80
}

# Usage - loop through all
resource "local_file" "server_files" {
  count    = length(var.server_names)
  filename = "${var.server_names[count.index]}.conf"
  content  = "Server: ${var.server_names[count.index]}"
}
```

#### 5. **Map** (Key-Value Pairs)
```hcl
variable "server_configs" {
  description = "Server configuration settings"
  type        = map(string)
  default = {
    "web_server"   = "nginx"
    "database"     = "postgresql"
    "cache"        = "redis"
  }
}

# Usage - access by key
resource "local_file" "web_config" {
  filename = "web.conf"
  content  = "Web server: ${var.server_configs["web_server"]}"  # nginx
}
```

#### 6. **Object** (Complex Structure)
```hcl
variable "database" {
  description = "Database configuration"
  type = object({
    name     = string
    port     = number
    ssl      = bool
    replicas = list(string)
  })
  default = {
    name     = "myapp_db"
    port     = 5432
    ssl      = true
    replicas = ["replica1", "replica2"]
  }
}

# Usage - access nested values
resource "local_file" "db_config" {
  filename = "database.conf"
  content  = <<-EOT
    Database: ${var.database.name}
    Port: ${var.database.port}
    SSL: ${var.database.ssl}
    Replicas: ${join(", ", var.database.replicas)}
  EOT
}
```

### Ways to Provide Variable Values

#### 1. **Default Values** (in variable declaration)
```hcl
variable "environment" {
  default = "development"
}
```

#### 2. **Command Line**
```bash
terraform apply -var="environment=production"
terraform apply -var="port=8080" -var="environment=staging"
```

#### 3. **Environment Variables**
```bash
export TF_VAR_environment="production"
export TF_VAR_port="8080"
terraform apply
```

#### 4. **Variable Files** (terraform.tfvars)
```hcl
# terraform.tfvars
environment = "production"
port = 8080
server_name = "prod-web-server"

# Complex values
database = {
  name = "prod_db"
  port = 5432
  ssl = true
  replicas = ["prod-replica1", "prod-replica2"]
}
```

#### 5. **Custom Variable Files**
```hcl
# production.tfvars
environment = "production"
instance_type = "t3.large"

# development.tfvars  
environment = "development"
instance_type = "t2.micro"
```

Usage:
```bash
terraform apply -var-file="production.tfvars"
terraform apply -var-file="development.tfvars"
```

### Variable Validation

Add rules to ensure variables meet requirements:

```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "port" {
  description = "Port number"
  type        = number
  
  validation {
    condition     = var.port > 0 && var.port < 65536
    error_message = "Port must be between 1 and 65535."
  }
}

variable "email" {
  description = "Admin email address"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email))
    error_message = "Must be a valid email address."
  }
}
```

### Sensitive Variables

Hide sensitive values from logs and output:

```hcl
variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  # No default for security
}

variable "api_key" {
  description = "API key for external service"
  type        = string
  sensitive   = true
}

# Usage
resource "local_file" "secret_config" {
  filename = "secrets.conf"
  content  = "DB_PASSWORD=${var.database_password}"
  
  # Make the file readable only by owner
  file_permission = "0600"
}
```

Set sensitive variables:
```bash
# Command line (will be visible in history - not recommended)
terraform apply -var="database_password=secretpassword123"

# Better: Use environment variable
export TF_VAR_database_password="secretpassword123"
terraform apply

# Best: Use .tfvars file (add to .gitignore)
# secrets.tfvars
database_password = "secretpassword123"
api_key = "abc123xyz789"
```

### Complete Variable Example Project

Create a flexible web server configuration:

```hcl
# variables.tf
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-web-project"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "server_config" {
  description = "Server configuration"
  type = object({
    port         = number
    worker_count = number
    enable_ssl   = bool
  })
  default = {
    port         = 80
    worker_count = 4
    enable_ssl   = false
  }
}

variable "allowed_ips" {
  description = "List of allowed IP addresses"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

# main.tf
resource "local_file" "server_config" {
  filename = "${var.project_name}-${var.environment}.conf"
  content = <<-EOT
    # ${var.project_name} Configuration
    # Environment: ${var.environment}
    
    [server]
    port = ${var.server_config.port}
    worker_processes = ${var.server_config.worker_count}
    ssl_enabled = ${var.server_config.enable_ssl}
    
    [security]
    allowed_networks = [
    %{ for ip in var.allowed_ips ~}
      "${ip}",
    %{ endfor ~}
    ]
    
    [metadata]
    created_at = "${timestamp()}"
    terraform_managed = true
  EOT
}

# outputs.tf
output "config_file" {
  description = "Path to generated configuration file"
  value       = local_file.server_config.filename
}

output "server_port" {
  description = "Server port number"
  value       = var.server_config.port
}
```

**Test with different environments:**

```bash
# Development
terraform apply

# Staging  
terraform apply -var="environment=staging" -var='server_config={port=8080,worker_count=8,enable_ssl=true}'

# Production
terraform apply -var-file="production.tfvars"
```

---

## 📤 Outputs Explained

### What are Outputs?

**Outputs** are like return values from functions. They extract information from your Terraform configuration and make it available to:
- You (displayed after `terraform apply`)
- Other Terraform configurations
- External systems

Think of outputs as "exporting" information from your infrastructure.

### Why Use Outputs?

1. **Display Information**: Show important details after creation
2. **Module Integration**: Pass values between modules  
3. **External Integration**: Feed data to other systems
4. **Documentation**: Show what was created

### Basic Output Syntax

```hcl
output "OUTPUT_NAME" {
  description = "What this output represents"
  value       = what_to_output
  sensitive   = false  # true to hide from console output
}
```

### Simple Output Examples

```hcl
# Basic string output
output "welcome_message" {
  description = "A welcome message"
  value       = "Welcome to Terraform!"
}

# Output from resource attribute
resource "local_file" "config" {
  filename = "app.conf"
  content  = "Application configuration"
}

output "config_file_path" {
  description = "Path to the configuration file"
  value       = local_file.config.filename
}

output "config_file_id" {
  description = "Unique ID of the configuration file"
  value       = local_file.config.id
}
```

### Accessing Resource Attributes

Every resource provides different attributes you can output:

```hcl
resource "random_string" "password" {
  length = 16
  special = true
}

resource "local_file" "password_file" {
  filename = "password.txt"
  content  = random_string.password.result
}

# Output various attributes
output "password_length" {
  description = "Length of generated password"
  value       = random_string.password.length
}

output "password_value" {
  description = "The generated password"
  value       = random_string.password.result
  sensitive   = true  # Hide from console output
}

output "file_permissions" {
  description = "File permissions of password file"
  value       = local_file.password_file.file_permission
}

output "file_size" {
  description = "Size of the password file"
  value       = length(local_file.password_file.content)
}
```

### Complex Output Examples

#### 1. **List Outputs** (Multiple Values)
```hcl
variable "environments" {
  default = ["dev", "staging", "prod"]
}

resource "local_file" "env_configs" {
  count    = length(var.environments)
  filename = "${var.environments[count.index]}.conf"
  content  = "Environment: ${var.environments[count.index]}"
}

# Output list of all created files
output "all_config_files" {
  description = "List of all configuration files created"
  value       = local_file.env_configs[*].filename
}

# Output specific environment file
output "production_config" {
  description = "Production configuration file"
  value       = local_file.env_configs[2].filename  # prod is index 2
}
```

#### 2. **Map Outputs** (Key-Value Pairs)
```hcl
variable "services" {
  default = {
    web      = "nginx"
    database = "postgresql"  
    cache    = "redis"
  }
}

resource "local_file" "service_configs" {
  for_each = var.services
  filename = "${each.key}.conf"
  content  = "Service: ${each.value}"
}

# Output map of service names to file paths
output "service_files" {
  description = "Map of service names to their config files"
  value = {
    for service_name, file in local_file.service_configs : 
    service_name => file.filename
  }
}
```

#### 3. **Conditional Outputs**
```hcl
variable "create_backup" {
  description = "Whether to create backup files"
  type        = bool
  default     = false
}

resource "local_file" "main_config" {
  filename = "main.conf"
  content  = "Main configuration"
}

resource "local_file" "backup_config" {
  count    = var.create_backup ? 1 : 0
  filename = "backup.conf"
  content  = "Backup configuration"
}

# Output backup file path only if created
output "backup_file" {
  description = "Backup configuration file (if created)"
  value       = var.create_backup ? local_file.backup_config[0].filename : "No backup created"
}
```

### Using Outputs from Commands

After running `terraform apply`, outputs are displayed:

```bash
$ terraform apply
...
Outputs:

config_file_path = "app.conf"
config_file_id = "a1b2c3d4e5f6"
welcome_message = "Welcome to Terraform!"
```

**View outputs anytime:**
```bash
# Show all outputs
terraform output

# Show specific output
terraform output config_file_path

# Show output in JSON format
terraform output -json

# Show output value only (no quotes)
terraform output -raw config_file_path
```

### Sensitive Outputs

Hide sensitive information from console output:

```hcl
resource "random_string" "api_key" {
  length = 32
  special = false
}

resource "local_file" "api_config" {
  filename = "api.conf"
  content  = "API_KEY=${random_string.api_key.result}"
}

output "api_key" {
  description = "Generated API key"
  value       = random_string.api_key.result
  sensitive   = true  # Won't show in terraform apply output
}

output "config_file" {
  description = "API configuration file"
  value       = local_file.api_config.filename
  # Not sensitive - file path is safe to show
}
```

Console output:
```bash
Outputs:

api_key = <sensitive>
config_file = "api.conf"
```

To see sensitive values:
```bash
terraform output api_key
# Shows the actual value
```

### Outputs in Modules

Outputs are essential when creating reusable modules:

**Module Structure:**
```
modules/
└── web_server/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf      # ← Define what the module returns
```

**modules/web_server/outputs.tf:**
```hcl
output "server_config_file" {
  description = "Path to server configuration file"
  value       = local_file.server_config.filename
}

output "server_port" {
  description = "Port the server listens on"
  value       = var.port
}

output "server_status" {
  description = "Server configuration status"
  value = {
    created_at = timestamp()
    port       = var.port
    ssl_enabled = var.enable_ssl
  }
}
```

**Using module outputs:**
```hcl
module "web_server" {
  source = "./modules/web_server"
  port   = 8080
}

# Use module outputs
output "web_server_file" {
  value = module.web_server.server_config_file
}

output "web_server_port" {
  value = module.web_server.server_port
}

resource "local_file" "summary" {
  filename = "summary.txt"
  content  = "Web server config: ${module.web_server.server_config_file}"
}
```

### Advanced Output Techniques

#### 1. **Computed Outputs**
```hcl
variable "servers" {
  default = ["web1", "web2", "db1"]
}

resource "local_file" "server_configs" {
  count    = length(var.servers)
  filename = "${var.servers[count.index]}.conf"
  content  = "Server: ${var.servers[count.index]}"
}

output "server_summary" {
  description = "Summary of created servers"
  value = {
    total_servers = length(var.servers)
    web_servers   = length([for s in var.servers : s if startswith(s, "web")])
    db_servers    = length([for s in var.servers : s if startswith(s, "db")])
    all_files     = local_file.server_configs[*].filename
  }
}
```

#### 2. **String Interpolation in Outputs**
```hcl
resource "random_string" "project_id" {
  length = 8
  lower  = true
  upper  = false
}

resource "local_file" "project_info" {
  filename = "project.txt"
  content  = "Project ID: ${random_string.project_id.result}"
}

output "project_summary" {
  description = "Project summary information"
  value = <<-EOT
    Project Created Successfully!
    
    Project ID: ${random_string.project_id.result}
    Config File: ${local_file.project_info.filename}
    Created At: ${timestamp()}
    
    Next steps:
    1. Review the configuration file
    2. Test the setup
    3. Deploy to production
  EOT
}
```

### Practical Exercise: Complete Project with Outputs

Let's create a project that demonstrates all output concepts:

```hcl
# variables.tf
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-demo"
}

variable "environments" {
  description = "List of environments to create"
  type        = list(string)
  default     = ["dev", "staging"]
}

# main.tf
terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.4" }
    random = { source = "hashicorp/random", version = "~> 3.4" }
  }
}

# Generate project ID
resource "random_string" "project_id" {
  length = 6
  lower  = true
  upper  = false
  special = false
}

# Create environment configs
resource "local_file" "env_configs" {
  count    = length(var.environments)
  filename = "${var.project_name}-${var.environments[count.index]}.conf"
  content = <<-EOT
    [project]
    name = "${var.project_name}"
    id = "${random_string.project_id.result}"
    environment = "${var.environments[count.index]}"
    
    [metadata]
    created_at = "${timestamp()}"
    file_index = ${count.index}
  EOT
}

# Create project summary
resource "local_file" "summary" {
  filename = "${var.project_name}-summary.md"
  content = <<-EOT
    # ${var.project_name} Summary
    
    **Project ID:** ${random_string.project_id.result}
    **Environments:** ${join(", ", var.environments)}
    **Total Files:** ${length(var.environments)}
    
    ## Configuration Files
    ${join("\n", [for f in local_file.env_configs : "- ${f.filename}"])}
    
    Generated on: ${timestamp()}
  EOT
}

# outputs.tf
output "project_id" {
  description = "Generated project ID"
  value       = random_string.project_id.result
}

output "environment_files" {
  description = "List of environment configuration files"
  value       = local_file.env_configs[*].filename
}

output "summary_file" {
  description = "Project summary file"
  value       = local_file.summary.filename
}

output "project_info" {
  description = "Complete project information"
  value = {
    id            = random_string.project_id.result
    name          = var.project_name
    environments  = var.environments
    files_created = length(local_file.env_configs) + 1  # +1 for summary
    summary_file  = local_file.summary.filename
  }
}

output "next_steps" {
  description = "What to do next"
  value = <<-EOT
    Your ${var.project_name} project is ready!
    
    Files created:
    ${join("\n    ", local_file.env_configs[*].filename)}
    ${local_file.summary.filename}
    
    Run these commands:
    - cat ${local_file.summary.filename}  # View summary
    - ls -la *.conf                       # List config files
  EOT
}
```

**Run the project:**
```bash
terraform init
terraform apply
```

**View outputs:**
```bash
terraform output
terraform output -json project_info
terraform output -raw next_steps
```

This will create a complete project with multiple files and comprehensive outputs showing everything that was created!

---

## 🗃️ Terraform State Management

### What is Terraform State?

**Terraform State** is like a detailed inventory list that Terraform keeps to track what infrastructure it has created and manages.

Think of it like this:
- **You have a garage** (your infrastructure)
- **You have a notebook** (Terraform state) that lists everything in the garage
- **When you add/remove items**, you update the notebook
- **The notebook helps you remember** what you have and where it is

### Why Does Terraform Need State?

#### 1. **Mapping Configuration to Real World**
```hcl
# In your code
resource "aws_instance" "web" {
  ami = "ami-12345"
  instance_type = "t2.micro"
}
```

**State file records:**
- "This resource called `web` corresponds to actual EC2 instance `i-abcd1234` in AWS"
- "The instance has these current properties: IP address, status, etc."

#### 2. **Performance Optimization**
Without state, Terraform would need to:
- Call AWS API to list ALL your EC2 instances
- Compare each one to your configuration
- Figure out which ones belong to this Terraform config

With state:
- Terraform already knows exactly which resources it manages
- Much faster planning and execution

#### 3. **Tracking Metadata**
State stores extra information:
- Dependencies between resources
- Provider-specific data
- Resource creation order

### Understanding the State File

#### Local State File (Default)
When you run Terraform, it creates `terraform.tfstate`:

```bash
ls -la
# You'll see:
# terraform.tfstate      ← Current state
# terraform.tfstate.backup ← Previous state (backup)
```

**State file is JSON:**
```json
{
  "version": 4,
  "terraform_version": "1.6.0",
  "resources": [
    {
      "mode": "managed",
      "type": "local_file",
      "name": "example",
      "instances": [
        {
          "attributes": {
            "filename": "example.txt",
            "content": "Hello World",
            "id": "abc123..."
          }
        }
      ]
    }
  ]
}
```

### State File Locations

#### 1. **Local State** (Default)
- Stored in `terraform.tfstate` in your project directory
- Good for: Learning, personal projects, single-person use
- Problems: Can't share, no locking, easily lost

#### 2. **Remote State** (Recommended)
- Stored in a remote location (AWS S3, Azure Storage, etc.)
- Good for: Team collaboration, production use
- Benefits: Shared access, locking, versioning, backup

### Working with State Commands

#### View State Information
```bash
# List all resources in state
terraform state list

# Show details of a specific resource
terraform state show local_file.example

# Show entire state in human-readable format
terraform show
```

#### Manage State
```bash
# Remove resource from state (doesn't delete the actual resource)
terraform state rm local_file.example

# Move/rename resource in state
terraform state mv local_file.old_name local_file.new_name

# Import existing resource into state
terraform import local_file.example ./example.txt
```

### State Locking

**The Problem:**
- Person A runs `terraform apply`
- Person B runs `terraform apply` at the same time
- Both try to modify the same infrastructure
- Chaos ensues! 🔥

**The Solution - State Locking:**
- When someone runs Terraform, it "locks" the state
- Others must wait until the lock is released
- Prevents concurrent modifications

**How it Works:**
```bash
# Person A runs:
terraform apply
# State gets locked

# Person B tries to run:
terraform apply
# Error: state is locked by Person A
```

### Remote State Setup (AWS S3 Example)

#### Step 1: Create S3 Bucket for State
```hcl
# setup.tf (run this first to create the bucket)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket-unique-name"
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# For state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-state-locking"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
```

#### Step 2: Configure Backend in Main Project
```hcl
# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "my-terraform-state-bucket-unique-name"
    key    = "myproject/terraform.tfstate"
    region = "us-east-1"
    
    # State locking
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

# Your resources here
resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
}
```

#### Step 3: Initialize with Backend
```bash
terraform init
# Terraform will ask if you want to copy existing state to S3
# Type "yes"
```

### State Migration

#### Moving from Local to Remote State
```bash
# 1. Add backend configuration to your terraform block
# 2. Run init
terraform init

# Terraform will ask: "Do you want to copy existing state to the new backend?"
# Type: yes
```

#### Moving Between Remote Backends
```bash
# 1. Update backend configuration
# 2. Run init
terraform init -migrate-state
```

### State File Security

#### Sensitive Data in State
**⚠️ Important:** State files contain sensitive information!

- Resource attributes (including passwords, keys)
- Provider credentials
- Private IP addresses
- Internal configuration details

**Security Best Practices:**

1. **Never commit state files to Git**
```bash
# .gitignore
*.tfstate
*.tfstate.*
.terraform/
```

2. **Use remote state with encryption**
```hcl
backend "s3" {
  bucket  = "my-state-bucket"
  key     = "terraform.tfstate"
  region  = "us-east-1"
  encrypt = true  # ← Encrypt state file
}
```

3. **Restrict access to state storage**
- Use IAM policies to limit who can read state
- Enable versioning and MFA delete
- Monitor access logs

4. **Use sensitive variables**
```hcl
variable "db_password" {
  type      = string
  sensitive = true
}

output "password" {
  value     = var.db_password
  sensitive = true
}
```

### State Troubleshooting

#### Common State Issues

**1. State Lock Stuck**
```bash
# Error: state is locked
terraform force-unlock LOCK_ID
```

**2. State Out of Sync**
```bash
# Refresh state to match reality
terraform refresh

# Or plan with refresh
terraform plan -refresh=true
```

**3. Resource Drift** (Real infrastructure differs from state)
```bash
# Detect drift
terraform plan

# Fix drift - update infrastructure to match config
terraform apply
```

**4. Corrupted State**
```bash
# Restore from backup
cp terraform.tfstate.backup terraform.tfstate

# Or pull from remote
terraform state pull > terraform.tfstate
```

### State Best Practices

1. **Always use remote state for teams**
2. **Enable state locking**
3. **Regular backups** (automatic with S3 versioning)
4. **Separate state files** for different environments
5. **Never manually edit state files**
6. **Use `terraform import`** for existing resources

### Practical State Exercise

Let's practice state management:

```hcl
# main.tf
terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.4" }
  }
}

resource "local_file" "state_demo" {
  filename = "state_demo.txt"
  content  = "This file demonstrates state management"
}

resource "local_file" "backup" {
  filename = "backup.txt"
  content  = "Backup file: ${timestamp()}"
}
```

**Practice Commands:**
```bash
# Apply configuration
terraform apply

# View state
terraform state list
terraform state show local_file.state_demo

# Manually modify the actual file
echo "Modified outside Terraform" > state_demo.txt

# Check for drift
terraform plan

# Fix drift
terraform apply

# Remove from state (file remains)
terraform state rm local_file.backup

# Verify it's gone from state
terraform state list

# Import it back
terraform import local_file.backup backup.txt
```

---

## ☁️ Working with Cloud (AWS)

### Why AWS with Terraform?

**AWS (Amazon Web Services)** is the world's largest cloud provider, offering hundreds of services. Combined with Terraform, you can:
- Create servers, databases, networks automatically
- Scale infrastructure up/down based on demand
- Pay only for what you use
- Deploy globally in minutes

### AWS Fundamentals You Need to Know

#### 1. **Regions and Availability Zones**
- **Region**: Geographic area (like us-east-1, eu-west-1)
- **Availability Zone**: Data center within a region
- **Why it matters**: For reliability and compliance

#### 2. **Key AWS Services**
- **EC2**: Virtual servers (like renting computers)
- **S3**: File storage (like Dropbox but for applications)
- **VPC**: Virtual network (your private corner of AWS)
- **RDS**: Managed databases
- **IAM**: User and permission management

### AWS Account Setup

#### Step 1: Create AWS Account
1. Go to [aws.amazon.com](https://aws.amazon.com)
2. Click "Create an AWS Account"
3. Follow signup process (requires credit card)
4. Use Free Tier for learning

#### Step 2: Create IAM User (Don't Use Root Account!)
**Why?** Root account has unlimited power - too dangerous for daily use.

1. **Login to AWS Console**
2. **Go to IAM service**
3. **Create User:**
   - Username: `terraform-user`
   - Access type: ✅ Programmatic access
   - Permissions: Attach `AdministratorAccess` policy (for learning)
   - **Save Access Key ID and Secret Access Key** - you'll never see them again!

#### Step 3: Install AWS CLI
```bash
# Linux/macOS
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify installation
aws --version
```

#### Step 4: Configure AWS CLI
```bash
aws configure
# AWS Access Key ID: [paste your key]
# AWS Secret Access Key: [paste your secret]
# Default region name: us-east-1
# Default output format: json
```

**Test your setup:**
```bash
aws sts get-caller-identity
# Should show your user information
```

### Your First AWS Resource with Terraform

#### Step 1: AWS Provider Configuration
```hcl
# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2"
}

provider "aws" {
  region = "us-east-1"  # Virginia region
}
```

#### Step 2: Create Your First S3 Bucket
```hcl
# Add to main.tf
resource "random_string" "bucket_suffix" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "my-terraform-bucket-${random_string.bucket_suffix.result}"
  
  tags = {
    Name        = "My First Terraform Bucket"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

# Configure bucket settings
resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_first_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.my_first_bucket.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.my_first_bucket.arn
}
```

#### Step 3: Deploy to AWS
```bash
terraform init    # Download AWS provider
terraform plan    # Preview changes
terraform apply   # Create in AWS!
```

**Check AWS Console:**
- Login to AWS Console
- Go to S3 service
- You should see your bucket!

### Creating EC2 Instances (Virtual Servers)

#### Understanding EC2 Basics
- **AMI (Amazon Machine Image)**: Template for your server (like Ubuntu, Amazon Linux)
- **Instance Type**: Size of server (t2.micro = 1 CPU, 1GB RAM - Free Tier)
- **Key Pair**: SSH keys to access your server
- **Security Group**: Firewall rules

#### Step 1: Create Key Pair for SSH Access
```bash
# Generate SSH key pair on your local machine
ssh-keygen -t rsa -b 2048 -f ~/.ssh/aws-terraform-key

# This creates:
# ~/.ssh/aws-terraform-key (private key - keep secret!)
# ~/.ssh/aws-terraform-key.pub (public key - upload to AWS)
```

#### Step 2: Complete EC2 Example
```hcl
# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Import your SSH public key
resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/aws-terraform-key.pub")  # Path to your public key
}

# Get the latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create security group (firewall rules)
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-security-group"
  description = "Security group for web server"
  
  # Allow SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow from anywhere (not recommended for production!)
  }
  
  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow HTTPS (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "Web Server Security Group"
  }
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = "t2.micro"  # Free Tier eligible
  key_name        = aws_key_pair.terraform_key.key_name
  security_groups = [aws_security_group.web_server_sg.name]
  
  # Install and start web server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
              echo "<p>Server created at: $(date)</p>" >> /var/www/html/index.html
              EOF
  
  tags = {
    Name        = "Web Server"
    Environment = "Learning"
    ManagedBy   = "Terraform"
  }
}

# Outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.web_server.public_ip
}

output "public_dns" {
  description = "Public DNS name of the instance"
  value       = aws_instance.web_server.public_dns
}

output "ssh_command" {
  description = "Command to SSH into the server"
  value       = "ssh -i ~/.ssh/aws-terraform-key ec2-user@${aws_instance.web_server.public_ip}"
}

output "website_url" {
  description = "URL to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}
```

#### Step 3: Deploy Your Web Server
```bash
terraform init
terraform plan
terraform apply

# After applying, you'll see outputs like:
# public_ip = "3.88.123.456"
# website_url = "http://3.88.123.456"
# ssh_command = "ssh -i ~/.ssh/aws-terraform-key ec2-user@3.88.123.456"
```

#### Step 4: Test Your Server
```bash
# Test the website
curl http://YOUR_PUBLIC_IP

# SSH into the server
ssh -i ~/.ssh/aws-terraform-key ec2-user@YOUR_PUBLIC_IP
```

### Multiple Resources Example

Let's create a more complex setup with multiple servers:

```hcl
# variables.tf
variable "server_count" {
  description = "Number of servers to create"
  type        = number
  default     = 2
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "main" {
  key_name   = "${var.environment}-terraform-key"
  public_key = file("~/.ssh/aws-terraform-key.pub")
}

resource "aws_security_group" "web_servers" {
  name        = "${var.environment}-web-servers"
  description = "Security group for ${var.environment} web servers"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name        = "${var.environment} Web Servers"
    Environment = var.environment
  }
}

# Create multiple instances
resource "aws_instance" "web_servers" {
  count           = var.server_count
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.main.key_name
  security_groups = [aws_security_group.web_servers.name]
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Server ${count.index + 1}</h1>" > /var/www/html/index.html
              echo "<p>Environment: ${var.environment}</p>" >> /var/www/html/index.html
              echo "<p>Created: $(date)</p>" >> /var/www/html/index.html
              EOF
  
  tags = {
    Name        = "${var.environment}-web-server-${count.index + 1}"
    Environment = var.environment
    ServerIndex = count.index + 1
  }
}

# Create S3 bucket for application data
resource "random_string" "bucket_suffix" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "aws_s3_bucket" "app_data" {
  bucket = "${var.environment}-app-data-${random_string.bucket_suffix.result}"
  
  tags = {
    Name        = "${var.environment} Application Data"
    Environment = var.environment
  }
}

# outputs.tf
output "server_ips" {
  description = "Public IP addresses of all servers"
  value       = aws_instance.web_servers[*].public_ip
}

output "server_urls" {
  description = "URLs to access all servers"
  value       = [for ip in aws_instance.web_servers[*].public_ip : "http://${ip}"]
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.app_data.bucket
}

output "infrastructure_summary" {
  description = "Summary of created infrastructure"
  value = {
    environment   = var.environment
    server_count  = var.server_count
    server_ips    = aws_instance.web_servers[*].public_ip
    bucket_name   = aws_s3_bucket.app_data.bucket
    total_cost    = "~${var.server_count * 8.5}/month (t2.micro instances)"
  }
}
```

**Deploy with different configurations:**
```bash
# Development environment (2 servers)
terraform apply

# Staging environment (3 servers)
terraform apply -var="environment=staging" -var="server_count=3"

# Production environment (5 servers)  
terraform apply -var="environment=production" -var="server_count=5"
```

### Cost Management Tips

#### 1. **Use Free Tier Resources**
- t2.micro instances (750 hours/month free)
- 5GB S3 storage free
- Always check AWS Free Tier limits

#### 2. **Clean Up Resources**
```bash
# Always destroy when done learning
terraform destroy

# Verify nothing is running
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name]'
```

#### 3. **Monitor Costs**
- Set up AWS billing alerts
- Use AWS Cost Explorer
- Check costs daily when learning

### AWS Best Practices with Terraform

1. **Use data sources for existing resources**
2. **Tag everything** for cost tracking
3. **Use variables** for different environments
4. **Never hardcode credentials** in code
5. **Use least-privilege IAM policies**
6. **Store state remotely** for team collaboration

---

## 📦 Modules - Making Code Reusable

### What are Modules?

**Modules** are like functions in programming - they're reusable pieces of Terraform code that you can use multiple times with different inputs.

Think of modules like **LEGO instruction sets**:
- You have instructions to build a car (module)
- You can use the same instructions to build multiple cars
- You can change colors/sizes (variables) but the basic structure remains the same

### Why Use Modules?

#### Without Modules (Repetitive):
```hcl
# Development environment
resource "aws_instance" "dev_web" {
  ami = "ami-12345"
  instance_type = "t2.micro"
  tags = { Name = "dev-web" }
}

resource "aws_security_group" "dev_sg" {
  name = "dev-sg"
  # ... 20 lines of security group rules
}

# Staging environment  
resource "aws_instance" "staging_web" {
  ami = "ami-12345"
  instance_type = "t2.small"
  tags = { Name = "staging-web" }
}

resource "aws_security_group" "staging_sg" {
  name = "staging-sg"
  # ... same 20 lines repeated
}

# Production environment
# ... repeat everything again
```

#### With Modules (Reusable):
```hcl
module "dev_environment" {
  source = "./web-server-module"
  environment = "dev"
  instance_type = "t2.micro"
}

module "staging_environment" {
  source = "./web-server-module"
  environment = "staging"
  instance_type = "t2.small"
}

module "production_environment" {
  source = "./web-server-module"
  environment = "production"
  instance_type = "t2.large"
}
```

### Module Structure

Every module is just a folder with Terraform files:

```
my-project/
├── main.tf                    # Root configuration
├── modules/                   # All modules go here
│   └── web-server/           # Our web server module
│       ├── main.tf           # Main resources
│       ├── variables.tf      # Input variables
│       ├── outputs.tf        # Output values
│       └── README.md         # Documentation
└── environments/
    ├── dev/
    ├── staging/
    └── prod/
```

### Creating Your First Module

Let's create a reusable web server module:

#### Step 1: Create Module Directory
```bash
mkdir -p modules/web-server
cd modules/web-server
```

#### Step 2: Module Variables (modules/web-server/variables.tf)
```hcl
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "server_count" {
  description = "Number of servers to create"
  type        = number
  default     = 1
  
  validation {
    condition     = var.server_count > 0 && var.server_count <= 10
    error_message = "Server count must be between 1 and 10."
  }
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the server"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}
```

#### Step 3: Module Resources (modules/web-server/main.tf)
```hcl
# Get latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create security group
resource "aws_security_group" "web_server" {
  name        = "${var.environment}-web-server-sg"
  description = "Security group for ${var.environment} web servers"
  
  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }
  
  # HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name        = "${var.environment}-web-server-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Create EC2 instances
resource "aws_instance" "web_server" {
  count                  = var.server_count
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server.id]
  monitoring             = var.enable_monitoring
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              cat > /var/www/html/index.html << 'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>${var.environment} Web Server</title>
                  <style>
                      body { font-family: Arial, sans-serif; margin: 40px; }
                      .header { color: #333; }
                      .info { background: #f0f0f0; padding: 20px; margin: 20px 0; }
                  </style>
              </head>
              <body>
                  <h1 class="header">Welcome to ${var.environment} Environment!</h1>
                  <div class="info">
                      <h3>Server Information:</h3>
                      <p><strong>Environment:</strong> ${var.environment}</p>
                      <p><strong>Server Number:</strong> ${count.index + 1} of ${var.server_count}</p>
                      <p><strong>Instance Type:</strong> ${var.instance_type}</p>
                      <p><strong>Created:</strong> $(date)</p>
                      <p><strong>Hostname:</strong> $(hostname)</p>
                  </div>
                  <p>This server was created using a Terraform module!</p>
              </body>
              </html>
              HTML
              EOF
  
  tags = {
    Name        = "${var.environment}-web-server-${count.index + 1}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    ServerIndex = count.index + 1
  }
}

# Create S3 bucket for environment data
resource "random_string" "bucket_suffix" {
  length  = 8
  lower   = true
  upper   = false
  special = false
}

resource "aws_s3_bucket" "environment_data" {
  bucket = "${var.environment}-data-${random_string.bucket_suffix.result}"
  
  tags = {
    Name        = "${var.environment}-data-bucket"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
```

#### Step 4: Module Outputs (modules/web-server/outputs.tf)
```hcl
output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.web_server[*].id
}

output "public_ips" {
  description = "Public IP addresses of the instances"
  value       = aws_instance.web_server[*].public_ip
}

output "private_ips" {
  description = "Private IP addresses of the instances"
  value       = aws_instance.web_server[*].private_ip
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.web_server.id
}

output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.environment_data.bucket
}

output "server_urls" {
  description = "URLs to access the web servers"
  value       = [for ip in aws_instance.web_server[*].public_ip : "http://${ip}"]
}

output "environment_info" {
  description = "Summary information about this environment"
  value = {
    environment    = var.environment
    server_count   = var.server_count
    instance_type  = var.instance_type
    monitoring     = var.enable_monitoring
    bucket_name    = aws_s3_bucket.environment_data.bucket
  }
}
```

#### Step 5: Module Documentation (modules/web-server/README.md)
```markdown
# Web Server Module

This module creates a complete web server environment with:
- EC2 instances running Apache web server
- Security group with appropriate rules
- S3 bucket for environment data

## Usage

```hcl
module "my_web_environment" {
  source = "./modules/web-server"
  
  environment         = "dev"
  instance_type      = "t2.micro"
  server_count       = 2
  enable_monitoring  = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| environment | Environment name | string | n/a | yes |
| instance_type | EC2 instance type | string | "t2.micro" | no |
| server_count | Number of servers | number | 1 | no |
| allowed_cidr_blocks | Allowed CIDR blocks | list(string) | ["0.0.0.0/0"] | no |
| enable_monitoring | Enable monitoring | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_ids | EC2 instance IDs |
| public_ips | Public IP addresses |
| server_urls | Web server URLs |
```

### Using Your Module

Now let's use our module to create different environments:

#### Root Configuration (main.tf)
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Development Environment
module "development" {
  source = "./modules/web-server"
  
  environment    = "dev"
  instance_type  = "t2.micro"
  server_count   = 1
  enable_monitoring = false
}

# Staging Environment
module "staging" {
  source = "./modules/web-server"
  
  environment    = "staging"
  instance_type  = "t2.small"
  server_count   = 2
  enable_monitoring = true
}

# Production Environment
module "production" {
  source = "./modules/web-server"
  
  environment       = "prod"
  instance_type     = "t2.medium"
  server_count      = 3
  enable_monitoring = true
  allowed_cidr_blocks = ["10.0.0.0/8"]  # More restrictive
}

# Outputs from modules
output "development_urls" {
  description = "URLs for development servers"
  value       = module.development.server_urls
}

output "staging_urls" {
  description = "URLs for staging servers"
  value       = module.staging.server_urls
}

output "production_info" {
  description = "Production environment information"
  value       = module.production.environment_info
}

output "all_environments_summary" {
  description = "Summary of all environments"
  value = {
    dev = {
      server_count = length(module.development.instance_ids)
      urls         = module.development.server_urls
    }
    staging = {
      server_count = length(module.staging.instance_ids)
      urls         = module.staging.server_urls
    }
    prod = {
      server_count = length(module.production.instance_ids)
      urls         = module.production.server_urls
    }
  }
}
```

#### Deploy Everything
```bash
terraform init    # Downloads providers and initializes modules
terraform plan    # Shows all resources that will be created
terraform apply   # Creates all three environments!

# You'll get outputs showing URLs for all environments:
# development_urls = ["http://1.2.3.4"]
# staging_urls = ["http://5.6.7.8", "http://9.10.11.12"] 
# production_info = { environment = "prod", server_count = 3, ... }
```

### Module Sources

Modules can come from different sources:

#### 1. **Local Modules** (what we just did)
```hcl
module "web_server" {
  source = "./modules/web-server"  # Relative path
}
```

#### 2. **Git Repository**
```hcl
module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git"
}

# Specific branch or tag
module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.0"
}
```

#### 3. **Terraform Registry** (Recommended)
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.14"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = true
  
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
```

### Module Versioning

Always specify versions for external modules:

```hcl
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.9"  # Allow patch updates, lock minor version
  
  # module configuration...
}
```

**Version Constraints:**
- `~> 4.9` = "At least 4.9, but less than 5.0"
- `>= 4.9, < 5.0` = Same as above, explicit
- `= 4.9.1` = Exactly version 4.9.1
- `>= 4.9` = At least 4.9 (risky - could break)

### Nested Modules

Modules can use other modules:

```
modules/
├── infrastructure/           # Parent module
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── networking/              # Child module
│   ├── main.tf
│   └── ...
└── compute/                # Child module
    ├── main.tf
    └── ...
```

**modules/infrastructure/main.tf:**
```hcl
module "networking" {
  source = "../networking"
  
  environment = var.environment
  cidr_block  = var.vpc_cidr
}

module "compute" {
  source = "../compute"
  
  environment = var.environment
  subnet_ids  = module.networking.private_subnet_ids
  vpc_id      = module.networking.vpc_id
}
```

### Module Best Practices

#### 1. **Keep Modules Focused**
- One module = one logical unit
- Web server module ≠ entire application stack

#### 2. **Use Descriptive Variable Names**
```hcl
# Good
variable "database_instance_class" {
  description = "RDS instance class (e.g., db.t3.micro)"
}

# Bad
variable "class" {
  description = "Instance class"
}
```

#### 3. **Provide Good Defaults**
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  # Sensible default
}
```

#### 4. **Document Your Modules**
- Always include README.md
- Explain what the module does
- Provide usage examples
- Document all variables and outputs

#### 5. **Validate Input Variables**
```hcl
variable "environment" {
  type = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}
```

#### 6. **Tag Everything Consistently**
```hcl
locals {
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "web-server"
    Owner       = var.owner
    Project     = var.project_name
  }
}

resource "aws_instance" "web" {
  # ... configuration ...
  
  tags = merge(local.common_tags, {
    Name = "${var.environment}-web-server-${count.index + 1}"
  })
}
```

### Advanced Module Example

Let's create a more sophisticated module with multiple resource types:

**modules/complete-web-app/variables.tf:**
```hcl
variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "instance_config" {
  description = "Configuration for EC2 instances"
  type = object({
    type  = string
    count = number
  })
  
  validation {
    condition     = var.instance_config.count > 0 && var.instance_config.count <= 5
    error_message = "Instance count must be between 1 and 5."
  }
}

variable "database_config" {
  description = "Database configuration"
  type = object({
    engine         = string
    instance_class = string
    storage_size   = number
  })
  default = {
    engine         = "mysql"
    instance_class = "db.t3.micro"
    storage_size   = 20
  }
}

variable "domain_name" {
  description = "Domain name for the application (optional)"
  type        = string
  default     = ""
}
```

**modules/complete-web-app/main.tf:**
```hcl
# Local values for consistent naming and tagging
locals {
  name_prefix = "${var.app_name}-${var.environment}"
  
  common_tags = {
    Application = var.app_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# VPC for network isolation
resource "aws_vpc" "app_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

# Internet Gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = aws_vpc.app_vpc.id
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-igw"
  })
}

# Public Subnets
resource "aws_subnet" "public" {
  count = 2
  
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-${count.index + 1}"
    Type = "Public"
  })
}

# Private Subnets
resource "aws_subnet" "private" {
  count = 2
  
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-private-${count.index + 1}"
    Type = "Private"
  })
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_igw.id
  }
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)
  
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets           = aws_subnet.public[*].id
  
  tags = local.common_tags
}

# Security Groups
resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_vpc.app_vpc.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb-sg"
  })
}

resource "aws_security_group" "web_servers" {
  name        = "${local.name_prefix}-web-sg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.app_vpc.id
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.app_vpc.cidr_block]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-web-sg"
  })
}

# Launch Template for Auto Scaling
resource "aws_launch_template" "web_server" {
  name_prefix   = "${local.name_prefix}-"
  description   = "Launch template for ${var.app_name} web servers"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_config.type
  
  vpc_security_group_ids = [aws_security_group.web_servers.id]
  
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              cat > /var/www/html/index.html << 'HTML'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>${var.app_name} - ${var.environment}</title>
                  <style>
                      body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
                      .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
                      .header { color: #2c3e50; margin-bottom: 30px; }
                      .info { background: #ecf0f1; padding: 20px; margin: 20px 0; border-radius: 5px; }
                      .status { color: #27ae60; font-weight: bold; }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1 class="header">${var.app_name}</h1>
                      <div class="status">✓ Application is running successfully!</div>
                      
                      <div class="info">
                          <h3>Environment Information:</h3>
                          <p><strong>Application:</strong> ${var.app_name}</p>
                          <p><strong>Environment:</strong> ${var.environment}</p>
                          <p><strong>Instance Type:</strong> ${var.instance_config.type}</p>
                          <p><strong>Server:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
                          <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
                      </div>
                      
                      <p><em>Deployed with Terraform modules</em></p>
                  </div>
              </body>
              </html>
              HTML
              EOF
  )
  
  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-web-server"
    })
  }
  
  tags = local.common_tags
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_servers" {
  name                = "${local.name_prefix}-asg"
  vpc_zone_identifier = aws_subnet.private[*].id
  target_group_arns   = [aws_lb_target_group.web.arn]
  health_check_type   = "ELB"
  min_size            = var.instance_config.count
  max_size            = var.instance_config.count * 2
  desired_capacity    = var.instance_config.count
  
  launch_template {
    id      = aws_launch_template.web_server.id
    version = "$Latest"
  }
  
  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg"
    propagate_at_launch = false
  }
  
  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# Load Balancer Target Group
resource "aws_lb_target_group" "web" {
  name     = "${local.name_prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app_vpc.id
  
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
  
  tags = local.common_tags
}

# Load Balancer Listener
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# Database Subnet Group
resource "aws_db_subnet_group" "app_db" {
  name       = "${local.name_prefix}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-subnet-group"
  })
}

# Database Security Group
resource "aws_security_group" "database" {
  name        = "${local.name_prefix}-db-sg"
  description = "Security group for database"
  vpc_id      = aws_vpc.app_vpc.id
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_servers.id]
  }
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-sg"
  })
}

# RDS Database
resource "aws_db_instance" "app_database" {
  identifier             = "${local.name_prefix}-db"
  engine                 = var.database_config.engine
  engine_version         = "8.0"
  instance_class         = var.database_config.instance_class
  allocated_storage      = var.database_config.storage_size
  storage_type           = "gp2"
  
  db_name  = replace(var.app_name, "-", "")
  username = "admin"
  password = random_password.db_password.result
  
  db_subnet_group_name   = aws_db_subnet_group.app_db.name
  vpc_security_group_ids = [aws_security_group.database.id]
  
  backup_retention_period = var.environment == "prod" ? 30 : 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  skip_final_snapshot = true
  deletion_protection = var.environment == "prod"
  
  tags = local.common_tags
}

# Generate random database password
resource "random_password" "db_password" {
  length = 16
  special = true
}

# Store database password in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "${local.name_prefix}-db-password"
  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = aws_db_instance.app_database.username
    password = random_password.db_password.result
    engine   = "mysql"
    host     = aws_db_instance.app_database.endpoint
    port     = 3306
    dbname   = aws_db_instance.app_database.db_name
  })
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```

**modules/complete-web-app/outputs.tf:**
```hcl
output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.app_lb.dns_name
}

output "load_balancer_url" {
  description = "URL to access the application"
  value       = "http://${aws_lb.app_lb.dns_name}"
}

output "database_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.app_database.endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.app_vpc.id
}

output "application_info" {
  description = "Complete application information"
  value = {
    app_name          = var.app_name
    environment       = var.environment
    load_balancer_url = "http://${aws_lb.app_lb.dns_name}"
    instance_count    = var.instance_config.count
    instance_type     = var.instance_config.type
    database_engine   = var.database_config.engine
    vpc_cidr          = aws_vpc.app_vpc.cidr_block
  }
}
```

**Using the Complete Web App Module:**
```hcl
# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "my_web_app" {
  source = "./modules/complete-web-app"
  
  app_name    = "my-awesome-app"
  environment = "dev"
  
  instance_config = {
    type  = "t2.micro"
    count = 2
  }
  
  database_config = {
    engine         = "mysql"
    instance_class = "db.t3.micro"
    storage_size   = 20
  }
}

output "application_url" {
  description = "URL to access your application"
  value       = module.my_web_app.load_balancer_url
}

output "app_info" {
  description = "Application information"
  value       = module.my_web_app.application_info
}
```

This creates a complete, production-ready web application with:
- ✅ VPC with public and private subnets
- ✅ Application Load Balancer
- ✅ Auto Scaling Group
- ✅ RDS Database
- ✅ Security Groups
- ✅ Secrets Management

**Deploy it:**
```bash
terraform init
terraform apply

# Wait 5-10 minutes for everything to be created
# Then visit the URL shown in the output!
```

This demonstrates the power of modules - a single module call creates an entire application infrastructure!

---

## 🎯 Best Practices

### Code Organization

#### Project Structure
```
terraform-project/
├── main.tf                 # Root configuration
├── variables.tf            # Input variables
├── outputs.tf             # Output values
├── terraform.tf           # Terraform and provider requirements
├── .gitignore            # Git ignore file
├── README.md             # Project documentation
│
├── environments/         # Environment-specific configurations
│   ├── dev/
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── prod/
│       ├── terraform.tfvars
│       └── backend.tf
│
├── modules/             # Reusable modules
│   ├── networking/
│   ├── compute/
│   └── database/
│
└── scripts/            # Helper scripts
    ├── deploy.sh
    └── cleanup.sh
```

#### File Naming Conventions
- `main.tf` - Primary configuration
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `terraform.tf` - Provider requirements
- `locals.tf` - Local values (if many)
- `data.tf` - Data sources (if many)

### Terraform Configuration Best Practices

#### 1. **Always Specify Provider Versions**
```hcl
# Good
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2"
}

# Bad - no version constraints
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
```

#### 2. **Use Meaningful Resource Names**
```hcl
# Good - descriptive names
resource "aws_instance" "web_server" {
  # configuration
}

resource "aws_security_group" "web_server_sg" {
  # configuration
}

# Bad - generic names
resource "aws_instance" "server1" {
  # configuration
}

resource "aws_security_group" "sg" {
  # configuration
}
```

#### 3. **Consistent Naming and Tagging**
```hcl
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-web-server"
    Role = "WebServer"
  })
}
```

#### 4. **Use Variables with Validation**
```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  
  validation {
    condition     = can(regex("^t[2-3]\\.(nano|micro|small|medium|large|xlarge|2xlarge)$", var.instance_type))
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
}
```

#### 5. **Document Everything**
```hcl
variable "database_config" {
  description = <<EOT
Configuration for the RDS database instance.
This includes the engine type, instance class, and storage settings.
The password will be auto-generated and stored in AWS Secrets Manager.
EOT
  type = object({
    engine         = string
    instance_class = string
    storage_size   = number
  })
  
  default = {
    engine         = "mysql"
    instance_class = "db.t3.micro"
    storage_size   = 20
  }
}
```

### Security Best Practices

#### 1. **Never Hardcode Secrets**
```hcl
# Bad - hardcoded password
resource "aws_db_instance" "database" {
  username = "admin"
  password = "supersecret123"  # ❌ Never do this!
}

# Good - generated password
resource "random_password" "db_password" {
  length = 16
  special = true
}

resource "aws_db_instance" "database" {
  username = "admin"
  password = random_password.db_password.result
}

# Store in secrets manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "${var.project_name}-db-password"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}
```

#### 2. **Use Least Privilege Access**
```hcl
# Good - specific permissions
data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.app_data.arn}/*"
    ]
  }
}

# Bad - overly broad permissions
data "aws_iam_policy_document" "bad_policy" {
  statement {
    effect = "Allow"
    actions = ["*"]  # ❌ Too broad!
    resources = ["*"]
  }
}
```

#### 3. **Secure State Storage**
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "myproject/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    
    # Additional security
    kms_key_id = "alias/terraform-state-key"
  }
}
```

#### 4. **Use .gitignore**
```bash
# .gitignore
*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl
*.tfvars
*.auto.tfvars
crash.log
crash.*.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraformrc
terraform.rc
```

### Performance and Efficiency

#### 1. **Use Data Sources Wisely**
```hcl
# Cache expensive data lookups
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Use the cached data
resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.available.names)
  
  availability_zone = data.aws_availability_zones.available.names[count.index]
  # ... other configuration
}
```

#### 2. **Minimize Provider Calls**
```hcl
# Good - single call to get all subnets
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
  
  filter {
    name   = "tag:Type"
    values = ["Private"]
  }
}

# Bad - multiple individual calls
data "aws_subnet" "private_1" {
  id = "subnet-12345"
}

data "aws_subnet" "private_2" {
  id = "subnet-67890"
}
```

### State Management Best Practices

#### 1. **Separate State Files**
```
project/
├── global/                    # Global resources (IAM, Route53)
│   └── terraform.tfstate
├── networking/                # VPC, subnets, gateways
│   └── terraform.tfstate
├── security/                  # Security groups, NACLs
│   └── terraform.tfstate
└── applications/
    ├── web-app/              # Web application
    │   └── terraform.tfstate
    └── database/             # Database resources
        └── terraform.tfstate
```

#### 2. **Use Remote State Data Sources**
```hcl
# In applications/web-app/main.tf
data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.networking.outputs.private_subnet_ids[0]
}
```

#### 3. **State Locking and Backup**
```hcl
terraform {
  backend "s3" {
    bucket         = "company-terraform-state"
    key            = "myproject/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
    
    # Enable versioning for backup
    versioning = true
  }
}
```

### Environment Management

#### 1. **Use Workspaces for Simple Cases**
```bash
# Create workspaces
terraform workspace new dev
terraform workspace new staging  
terraform workspace new prod

# Switch between workspaces
terraform workspace select dev
terraform apply

terraform workspace select prod
terraform apply
```

#### 2. **Directory Structure for Complex Cases**
```
project/
├── modules/
│   └── web-app/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── prod/
│       ├── main.tf
│       ├── terraform.tfvars
│       └── backend.tf
```

**environments/dev/terraform.tfvars:**
```hcl
environment    = "dev"
instance_type  = "t2.micro"
min_size       = 1
max_size       = 2
database_size  = "db.t3.micro"
enable_logging = false
```

**environments/prod/terraform.tfvars:**
```hcl
environment    = "prod"
instance_type  = "t3.large"
min_size       = 3
max_size       = 10
database_size  = "db.r5.xlarge"
enable_logging = true
```

### Testing and Validation

#### 1. **Use terraform validate**
```bash
# Check syntax and configuration
terraform validate

# Format code
terraform fmt -recursive

# Check for security issues (using external tools)
checkov -f main.tf
tflint
```

#### 2. **Plan Before Apply**
```bash
# Always review plans
terraform plan -out=tfplan

# Review the plan file
terraform show tfplan

# Apply only if satisfied
terraform apply tfplan
```

#### 3. **Test Infrastructure Changes**
```hcl
# Use local testing
resource "local_file" "test_config" {
  content  = "Testing configuration changes"
  filename = "/tmp/test.conf"
  
  lifecycle {
    # Prevent accidental deletion during testing
    prevent_destroy = true
  }
}
```

### CI/CD Integration

#### 1. **GitHub Actions Example**
```yaml
# .github/workflows/terraform.yml
name: Terraform

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  terraform:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: 1.6.0
    
    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: us-east-1
    
    - name: Terraform Init
      run: terraform init
    
    - name: Terraform Validate
      run: terraform validate
    
    - name: Terraform Format Check
      run: terraform fmt -check
    
    - name: Terraform Plan
      run: terraform plan
      
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      run: terraform apply -auto-approve
```

#### 2. **Deployment Script**
```bash
#!/bin/bash
# scripts/deploy.sh

set -e  # Exit on error

ENVIRONMENT=$1
if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: $0 <environment>"
    echo "Example: $0 dev"
    exit 1
fi

echo "Deploying to $ENVIRONMENT environment..."

# Change to environment directory
cd "environments/$ENVIRONMENT"

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Validate configuration
echo "Validating configuration..."
terraform validate

# Format code
echo "Formatting code..."
terraform fmt

# Plan deployment
echo "Planning deployment..."
terraform plan -out=tfplan

# Ask for confirmation
read -p "Do you want to apply these changes? (yes/no): " confirm
if [ "$confirm" = "yes" ]; then
    echo "Applying changes..."
    terraform apply tfplan
    echo "Deployment completed successfully!"
else
    echo "Deployment cancelled."
    rm -f tfplan
fi
```

### Monitoring and Observability

#### 1. **Add Monitoring to Resources**
```hcl
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}

resource "aws_sns_topic" "alerts" {
  name = "${var.project_name}-alerts"
}
```

#### 2. **Log Resource Creation**
```hcl
resource "local_file" "deployment_log" {
  filename = "deployment-${formatdate("YYYY-MM-DD-hhmm", timestamp())}.log"
  content = <<EOT
Deployment Log
==============
Project: ${var.project_name}
Environment: ${var.environment}
Timestamp: ${timestamp()}
Terraform Version: ${terraform.version}

Resources Created:
- EC2 Instances: ${var.instance_count}
- Load Balancer: ${aws_lb.main.arn}
- Database: ${aws_db_instance.main.identifier}

Configuration:
${jsonencode({
  project = var.project_name
  environment = var.environment
  instance_type = var.instance_type
  database_engine = var.database_engine
})}
EOT
}
```

### Error Handling and Recovery

#### 1. **Use Lifecycle Rules**
```hcl
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  lifecycle {
    # Prevent accidental destruction of critical resources
    prevent_destroy = true
    
    # Ignore changes to AMI (handled by auto-scaling)
    ignore_changes = [ami]
    
    # Create new resource before destroying old one
    create_before_destroy = true
  }
}
```

#### 2. **Handle Resource Dependencies**
```hcl
resource "aws_security_group" "database" {
  name   = "database-sg"
  vpc_id = aws_vpc.main.id
  
  # Ensure VPC is created first
  depends_on = [aws_vpc.main]
}

resource "aws_db_instance" "main" {
  # ... configuration ...
  
  # Ensure subnet group and security group exist
  depends_on = [
    aws_db_subnet_group.main,
    aws_security_group.database
  ]
}
```

#### 3. **Backup Critical Data**
```hcl
resource "aws_db_instance" "main" {
  identifier     = "${var.project_name}-database"
  engine         = "mysql"
  instance_class = var.db_instance_class
  
  # Automated backups
  backup_retention_period = var.environment == "prod" ? 30 : 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  # Final snapshot on deletion
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.project_name}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  
  # Deletion protection for production
  deletion_protection = var.environment == "prod"
}
```

### Cost Optimization

#### 1. **Use Appropriate Instance Types**
```hcl
locals {
  instance_types = {
    dev     = "t2.micro"    # Free tier
    staging = "t3.small"    # Cost-effective
    prod    = "t3.medium"   # Performance balanced
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.instance_types[var.environment]
}
```

#### 2. **Schedule Resources**
```hcl
# Auto-scaling schedule for cost savings
resource "aws_autoscaling_schedule" "scale_down_evening" {
  scheduled_action_name  = "scale-down-evening"
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence            = "0 18 * * *"  # 6 PM daily
  autoscaling_group_name = aws_autoscaling_group.web_servers.name
}

resource "aws_autoscaling_schedule" "scale_up_morning" {
  scheduled_action_name  = "scale-up-morning"
  min_size               = var.min_size
  max_size               = var.max_size
  desired_capacity       = var.desired_capacity
  recurrence            = "0 8 * * *"   # 8 AM daily
  autoscaling_group_name = aws_autoscaling_group.web_servers.name
}
```

#### 3. **Resource Tagging for Cost Tracking**
```hcl
locals {
  cost_tags = {
    CostCenter  = var.cost_center
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    
    # Automatic cost tracking
    "aws:cost-allocation:environment" = var.environment
    "aws:cost-allocation:project"     = var.project_name
  }
}

resource "aws_instance" "web_server" {
  # ... configuration ...
  
  tags = merge(local.cost_tags, {
    Name = "${var.project_name}-web-server"
  })
}
```

### Documentation Best Practices

#### 1. **Comprehensive README**
```markdown
# Project Name

Brief description of what this Terraform configuration does.

## Architecture

Diagram or description of the infrastructure created.

## Prerequisites

- AWS CLI configured
- Terraform >= 1.2
- Required IAM permissions

## Usage

### Quick Start
```bash
git clone <repository>
cd terraform-project
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
terraform init
terraform plan
terraform apply
```

### Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_name | Name of the project | string | n/a | yes |
| environment | Environment name | string | "dev" | no |

### Outputs

| Name | Description |
|------|-------------|
| load_balancer_url | URL to access the application |
| database_endpoint | Database connection endpoint |

## Environments

- **dev**: Development environment with minimal resources
- **staging**: Staging environment for testing
- **prod**: Production environment with high availability

## Cost Estimates

- **dev**: ~$20/month
- **staging**: ~$100/month  
- **prod**: ~$500/month

## Support

For questions or issues, contact the DevOps team.
```

#### 2. **Inline Documentation**
```hcl
# This module creates a complete web application infrastructure
# including load balancer, auto-scaling group, database, and monitoring
module "web_application" {
  source = "./modules/web-app"
  
  # Project identification
  project_name = "my-awesome-app"  # Used in resource naming
  environment  = "prod"            # Affects sizing and availability
  
  # Compute configuration
  instance_config = {
    type  = "t3.medium"  # Balanced performance for production
    count = 3            # High availability across AZs
  }
  
  # Database configuration  
  database_config = {
    engine         = "mysql"      # MySQL 8.0 for compatibility
    instance_class = "db.t3.small"  # Cost-effective for moderate load
    storage_size   = 100          # GB, with auto-scaling enabled
  }
}
```

These best practices will help you write maintainable, secure, and efficient Terraform code that scales with your infrastructure needs!

---

## 🔧 Common Problems & Solutions

### Terraform Installation Issues

#### Problem: "terraform: command not found"
**Symptoms:**
```bash
$ terraform --version
bash: terraform: command not found
```

**Solutions:**
```bash
# Check if Terraform is installed
which terraform

# If not found, install it:
# Ubuntu/Debian:
sudo apt-get update
sudo apt-get install terraform

# macOS with Homebrew:
brew install terraform

# Verify PATH variable includes Terraform
echo $PATH

# If installed but not in PATH, add to ~/.bashrc or ~/.zshrc:
export PATH=$PATH:/usr/local/bin
```

#### Problem: Version conflicts
**Symptoms:**
```bash
Error: Unsupported Terraform Core version
```

**Solution:**
```bash
# Check your Terraform version
terraform version

# Check required version in your terraform {} block
cat main.tf | grep -A 5 "terraform {"

# Install correct version using tfenv (version manager)
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
export PATH="$HOME/.tfenv/bin:$PATH"
tfenv install 1.6.0
tfenv use 1.6.0
```

### Provider Issues

#### Problem: Provider download failures
**Symptoms:**
```bash
Error: Failed to install provider
Could not retrieve the list of available versions
```

**Solutions:**
```bash
# Clear Terraform cache
rm -rf .terraform/
rm .terraform.lock.hcl

# Re-initialize with verbose output
terraform init -upgrade

# If behind corporate firewall, configure proxy
export HTTP_PROXY=http://proxy.company.com:8080
export HTTPS_PROXY=http://proxy.company.com:8080

# Or use alternative registry
terraform {
  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

#### Problem: Provider authentication failures
**Symptoms:**
```bash
Error: No valid credential sources found for AWS Provider
```

**Solutions:**
```bash
# Check AWS credentials
aws sts get-caller-identity

# Configure AWS CLI if not done
aws configure

# Or set environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"

# Verify credentials file exists
cat ~/.aws/credentials
```

### State File Problems

#### Problem: State file locked
**Symptoms:**
```bash
Error: Error locking state: Error acquiring the state lock
```

**Solutions:**
```bash
# Check if another terraform process is running
ps aux | grep terraform

# If no process found, force unlock (use carefully!)
terraform force-unlock LOCK_ID

# Get LOCK_ID from error message, example:
terraform force-unlock 12345678-1234-1234-1234-123456789abc

# If using remote state, check who has the lock
aws dynamodb get-item --table-name terraform-state-lock --key '{"LockID":{"S":"terraform-state-lock"}}'
```

#### Problem: State file corruption
**Symptoms:**
```bash
Error: Failed to load state: state file is corrupt
```

**Solutions:**
```bash
# If you have backup (terraform.tfstate.backup)
cp terraform.tfstate.backup terraform.tfstate

# For remote state, restore from S3 version
aws s3api list-object-versions --bucket my-terraform-state --prefix terraform.tfstate

# Download previous version
aws s3api get-object --bucket my-terraform-state --key terraform.tfstate --version-id VERSION_ID terraform.tfstate

# Import resources if state is completely lost
terraform import aws_instance.web i-1234567890abcdef0
```

#### Problem: Resource drift
**Symptoms:**
```bash
# Resources exist but plan shows they'll be created
Plan: 1 to add, 0 to change, 0 to destroy.
```

**Solutions:**
```bash
# Refresh state to sync with reality
terraform refresh

# Check what's in current state
terraform state list
terraform state show aws_instance.web

# Import existing resources
terraform import aws_instance.web i-1234567890abcdef0

# If resource was modified outside Terraform
terraform plan  # Shows what needs to be fixed
terraform apply # Fixes the drift
```

### Configuration Errors

#### Problem: Syntax errors in HCL
**Symptoms:**
```bash
Error: Argument or block definition required
```

**Solutions:**
```bash
# Validate syntax
terraform validate

# Format code to spot issues
terraform fmt

# Common syntax mistakes:
# Missing quotes around strings
resource "aws_instance" "web" {
  ami = ami-12345  # ❌ Wrong - missing quotes
  ami = "ami-12345"  # ✅ Correct
}

# Missing commas in maps
variable "tags" {
  default = {
    Name = "web"  # ❌ Missing comma
    Environment = "dev"  # ✅ This line is fine
  }
}
```

#### Problem: Variable validation failures
**Symptoms:**
```bash
Error: Invalid value for variable
```

**Solutions:**
```hcl
variable "environment" {
  type = string
  
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

# Check your terraform.tfvars file
environment = "development"  # ❌ Not in allowed list

# Fix it
environment = "dev"  # ✅ Correct
```

### Resource Creation Failures

#### Problem: AWS resource limits exceeded
**Symptoms:**
```bash
Error: Error launching source instance: InstanceLimitExceeded
```

**Solutions:**
```bash
# Check your AWS service quotas
aws service-quotas get-service-quota --service-code ec2 --quota-code L-1216C47A

# Request quota increase through AWS console
# Or modify your configuration to use fewer resources

# Use data source to check availability
data "aws_ec2_instance_type_offerings" "available" {
  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }
  
  filter {
    name   = "location"
    values = [data.aws_availability_zones.available.names[0]]
  }
}
```

#### Problem: Insufficient permissions
**Symptoms:**
```bash
Error: UnauthorizedOperation: You are not authorized to perform this operation
```

**Solutions:**
```bash
# Check current IAM user/role
aws sts get-caller-identity

# Check what permissions you have
aws iam get-user-policy --user-name terraform-user --policy-name terraform-policy

# Add required permissions to IAM policy
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances",
                "ec2:DescribeInstances",
                "ec2:CreateSecurityGroup"
            ],
            "Resource": "*"
        }
    ]
}
```

### Dependency Issues

#### Problem: Resource dependency cycles
**Symptoms:**
```bash
Error: Cycle: aws_instance.web, aws_security_group.web
```

**Solutions:**
```hcl
# ❌ Problem: Circular dependency
resource "aws_instance" "web" {
  security_groups = [aws_security_group.web.name]
  # This references the security group
}

resource "aws_security_group" "web" {
  name = "web-sg"
  
  # This tries to reference the instance
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.web.private_ip}/32"]  # ❌ Circular reference
  }
}

# ✅ Solution: Remove circular reference
resource "aws_security_group" "web" {
  name = "web-sg"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]  # ✅ Use CIDR instead
  }
}

resource "aws_instance" "web" {
  security_groups = [aws_security_group.web.name]
}
```

### Module Issues

#### Problem: Module source not found
**Symptoms:**
```bash
Error: Module not found
Could not download module "web_server" source
```

**Solutions:**
```bash
# Check module source path
ls -la modules/web_server/

# For local modules, use relative paths
module "web_server" {
  source = "./modules/web-server"  # Note the ./ prefix
}

# For Git modules, check URL and branch
module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.0"
}

# Reinitialize to download modules
terraform init -upgrade
```

#### Problem: Module variable conflicts
**Symptoms:**
```bash
Error: Unsupported argument
An argument named "instance_count" is not expected here
```

**Solutions:**
```bash
# Check module's variables.tf file
cat modules/web-server/variables.tf

# Make sure you're passing correct variable names
module "web_server" {
  source = "./modules/web-server"
  
  # ❌ Wrong variable name
  instance_count = 3
  
  # ✅ Correct variable name (check module's variables.tf)
  server_count = 3
}
```

### Performance Issues

#### Problem: Slow terraform plan/apply
**Symptoms:**
```bash
# Taking 10+ minutes for simple operations
```

**Solutions:**
```bash
# Use -parallelism flag to control concurrent operations
terraform apply -parallelism=2

# Use -refresh=false if state is known to be current
terraform plan -refresh=false

# Use -target to operate on specific resources
terraform apply -target=aws_instance.web

# Split large configurations into smaller modules
# Use data sources instead of multiple provider calls

# Enable debug logging to identify bottlenecks
export TF_LOG=DEBUG
terraform apply
```

### Cleanup and Recovery

#### Problem: Resources stuck in "destroying" state
**Symptoms:**
```bash
Still destroying... [id=i-1234567890abcdef0, 10m0s elapsed]
```

**Solutions:**
```bash
# Cancel the operation (Ctrl+C) and try again
terraform apply  # Sometimes this fixes stuck resources

# Use terraform refresh to sync state
terraform refresh

# Remove from state and clean up manually
terraform state rm aws_instance.stuck_instance
# Then manually delete the resource in AWS console

# Force deletion (last resort)
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

### Troubleshooting Commands

#### Essential Debugging Commands
```bash
# Enable detailed logging
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log

# Validate configuration
terraform validate

# Check formatting
terraform fmt -check -recursive

# Show current state
terraform show

# List state resources
terraform state list

# Show specific resource
terraform state show aws_instance.web

# Plan with detailed output
terraform plan -detailed-exitcode

# Apply with backup
terraform apply -backup=terraform.tfstate.backup

# Show Terraform version and providers
terraform version

# Show configuration
terraform show -json | jq .
```

#### Recovery Procedures

**1. Complete State Recovery:**
```bash
# Create new state file
terraform init

# Import all existing resources
terraform import aws_instance.web i-1234567890abcdef0
terraform import aws_security_group.web sg-1234567890abcdef0

# Verify with plan (should show no changes)
terraform plan
```

**2. Partial Resource Recovery:**
```bash
# Remove problematic resource from state
terraform state rm aws_instance.problematic

# Let Terraform recreate it
terraform apply
```

**3. Emergency Cleanup:**
```bash
# List all AWS resources created by Terraform
aws ec2 describe-instances --filters "Name=tag:ManagedBy,Values=Terraform"

# Script to clean up all resources
#!/bin/bash
# cleanup.sh
terraform destroy -auto-approve
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].InstanceId' --output text | xargs -I {} aws ec2 terminate-instances --instance-ids {}
```

### Prevention Tips

1. **Always use version control**
   - Commit your .tf files
   - Use .gitignore for state and secrets
   - Tag releases

2. **Test in development first**
   - Use separate AWS accounts for dev/prod
   - Test all changes in dev environment

3. **Use terraform plan consistently**
   - Never skip the plan step
   - Review plans carefully
   - Save plans for audit trail

4. **Monitor your resources**
   - Set up billing alerts
   - Use AWS Config for compliance
   - Regular state file backups

5. **Document everything**
   - Keep README files updated
   - Document manual changes
   - Maintain runbooks for common issues

Remember: When in doubt, start with `terraform plan` and work from there!

---

## 🚀 Advanced Concepts

### Dynamic Blocks

Dynamic blocks allow you to generate nested blocks based on data structures, making your code more flexible and DRY (Don't Repeat Yourself).

#### Basic Dynamic Block Syntax
```hcl
resource "resource_type" "example" {
  # Static configuration
  name = "example"
  
  # Dynamic block
  dynamic "nested_block" {
    for_each = var.list_or_map
    content {
      # Access current item as nested_block.value
      name  = nested_block.value.name
      value = nested_block.value.value
    }
  }
}
```

#### Real-World Example: Security Group Rules
```hcl
# Without dynamic blocks (repetitive)
resource "aws_security_group" "web" {
  name = "web-sg"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

# With dynamic blocks (flexible)
variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP access"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS access"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      description = "SSH access from private networks"
    }
  ]
}

resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Security group for web servers"
  
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### Complex Dynamic Block Example
```hcl
variable "load_balancer_config" {
  type = object({
    name = string
    listeners = list(object({
      port     = number
      protocol = string
      rules = list(object({
        priority = number
        actions = list(object({
          type               = string
          target_group_arn   = string
        }))
        conditions = list(object({
          field  = string
          values = list(string)
        }))
      }))
    }))
  })
}

resource "aws_lb" "main" {
  name               = var.load_balancer_config.name
  load_balancer_type = "application"
  
  # Dynamic listeners
  dynamic "listener" {
    for_each = var.load_balancer_config.listeners
    content {
      port     = listener.value.port
      protocol = listener.value.protocol
      
      # Dynamic rules within each listener
      dynamic "default_action" {
        for_each = listener.value.rules
        content {
          type             = default_action.value.actions[0].type
          target_group_arn = default_action.value.actions[0].target_group_arn
          
          # Dynamic conditions within each rule
          dynamic "condition" {
            for_each = default_action.value.conditions
            content# 🚀 Complete Terraform Handbook for Absolute Beginners
