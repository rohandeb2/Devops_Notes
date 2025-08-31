# Complete Shell Scripting Guide
### FROM ABSOLUTE BEGINNER TO ADVANCED

---

## 📚 Table of Contents

### **Part 1: Foundation (Basics)**
1. [What is Shell Scripting?](#what-is-shell-scripting)
2. [Understanding the Shell](#understanding-the-shell)
3. [Your First Shell Script](#your-first-shell-script)
4. [Making Scripts Executable](#making-scripts-executable)
5. [Comments in Shell Scripts](#comments-in-shell-scripts)

### **Part 2: Variables and Data**
6. [Variables - Your First Data Storage](#variables---your-first-data-storage)
7. [Different Types of Variables](#different-types-of-variables)
8. [Special Variables ($0, $1, $$, etc.)](#special-variables)
9. [Environment Variables](#environment-variables)
10. [Variable Naming Rules](#variable-naming-rules)

### **Part 3: Getting Input**
11. [Reading User Input](#reading-user-input)
12. [Command Line Arguments](#command-line-arguments)
13. [Interactive Scripts](#interactive-scripts)

### **Part 4: Making Decisions**
14. [Conditional Statements (if/then/else)](#conditional-statements)
15. [Comparison Operators](#comparison-operators)
16. [File Testing](#file-testing)
17. [Logical Operators](#logical-operators)
18. [Case Statements](#case-statements)

### **Part 5: Repetition (Loops)**
19. [For Loops](#for-loops)
20. [While Loops](#while-loops)
21. [Until Loops](#until-loops)
22. [Loop Control (break/continue)](#loop-control)
23. [Nested Loops](#nested-loops)

### **Part 6: Functions**
24. [What are Functions?](#what-are-functions)
25. [Creating and Using Functions](#creating-and-using-functions)
26. [Function Parameters](#function-parameters)
27. [Return Values](#return-values)
28. [Local vs Global Variables](#local-vs-global-variables)

### **Part 7: Working with Files**
29. [File Operations](#file-operations)
30. [Reading Files](#reading-files)
31. [Writing to Files](#writing-to-files)
32. [File Permissions](#file-permissions)
33. [Directory Operations](#directory-operations)

### **Part 8: Text Processing**
34. [String Operations](#string-operations)
35. [Pattern Matching](#pattern-matching)
36. [Regular Expressions](#regular-expressions)
37. [Text Processing Tools (grep, sed, awk)](#text-processing-tools)

### **Part 9: Arrays and Advanced Data**
38. [Understanding Arrays](#understanding-arrays)
39. [Working with Arrays](#working-with-arrays)
40. [Associative Arrays](#associative-arrays)

### **Part 10: Advanced Topics**
41. [Process Management](#process-management)
42. [Signal Handling](#signal-handling)
43. [Error Handling](#error-handling)
44. [Debugging Scripts](#debugging-scripts)
45. [Performance Optimization](#performance-optimization)

### **Part 11: Real-World Applications**
46. [System Administration Scripts](#system-administration-scripts)
47. [Automation Examples](#automation-examples)
48. [Best Practices](#best-practices)
49. [Common Pitfalls](#common-pitfalls)
50. [Next Steps](#next-steps)

---

# Part 1: Foundation (Basics)

## What is Shell Scripting?

Imagine you have to do the same computer tasks every day - like backing up files, checking system status, or organizing photos. Instead of clicking buttons repeatedly, you can write a **shell script** - a file containing commands that the computer can run automatically.

### Real-World Analogy
Think of shell scripting like writing a recipe:
- **Recipe**: Step-by-step instructions for cooking
- **Shell Script**: Step-by-step instructions for the computer

### What Can Shell Scripts Do?
- **Automate repetitive tasks** (like daily backups)
- **Manage files and folders** (organize, move, copy)
- **Monitor system health** (check disk space, memory)
- **Install and configure software**
- **Process large amounts of data**

### Why Learn Shell Scripting?
✅ **Save Time**: Automate boring, repetitive tasks  
✅ **Reduce Errors**: Computer follows instructions exactly  
✅ **Increase Productivity**: Do more work with less effort  
✅ **Career Growth**: Essential skill for IT professionals  

---

## Understanding the Shell

### What is a Shell?
A **shell** is a program that acts as an interface between you and the operating system. When you type commands in a terminal, you're talking to the shell.

### Types of Shells (Don't worry, we'll use Bash)

| Shell Name | Description | When to Use |
|------------|-------------|-------------|
| **Bash** | Most common, user-friendly | **Start here!** (We'll use this) |
| sh | Original shell, basic | Legacy systems |
| zsh | Advanced features | Power users |
| fish | Very user-friendly | Alternative to Bash |

### Check Your Shell
```bash
# See what shell you're using
echo $SHELL
```

**Example Output:**
```
/bin/bash
```

This means you're using Bash - perfect!

---

## Your First Shell Script

Let's create your very first shell script! Don't worry if you don't understand everything yet.

### Step 1: Open a Text Editor
Use any text editor:
- **nano** (beginner-friendly)
- **vim** (advanced)
- **gedit** (graphical)
- **VS Code** (if available)

```bash
# Using nano (easiest for beginners)
nano my_first_script.sh
```

### Step 2: Write Your First Script
```bash
#!/bin/bash
# This is my first shell script!

echo "Hello, World!"
echo "Today is: $(date)"
echo "I am learning shell scripting!"
```

### Step 3: Save the File
- In nano: Press `Ctrl+X`, then `Y`, then `Enter`

### Let's Understand Each Line:

```bash
#!/bin/bash
```
**What it is:** Shebang (pronounced "she-bang")  
**What it does:** Tells the system "use Bash to run this script"  
**Why needed:** Without this, the system might not know how to run your script  

```bash
# This is my first shell script!
```
**What it is:** A comment  
**What it does:** Nothing! It's just a note for humans to read  
**Why useful:** Helps you remember what the script does  

```bash
echo "Hello, World!"
```
**What it is:** A command  
**What it does:** Prints text to the screen  
**echo** = the command to print  
**"Hello, World!"** = the text to print  

```bash
echo "Today is: $(date)"
```
**What it is:** Command with command substitution  
**What it does:** Runs the `date` command and includes its output  
**$(date)** = run the date command and use its result here  

---

## Making Scripts Executable

Your script file exists, but the system doesn't know it's supposed to run it yet. We need to make it **executable**.

### Understanding File Permissions (Simple Version)
Every file has permissions that control:
- **r** = read (can view the file)
- **w** = write (can modify the file)  
- **x** = execute (can run the file as a program)

### Make Your Script Executable
```bash
chmod +x my_first_script.sh
```

**What this means:**
- **chmod** = change mode (permissions)
- **+x** = add execute permission
- **my_first_script.sh** = the file to modify

### Run Your Script
```bash
# Method 1: Direct execution
./my_first_script.sh

# Method 2: Using bash explicitly
bash my_first_script.sh
```

**Expected Output:**
```
Hello, World!
Today is: Mon Dec 25 10:30:45 PST 2023
I am learning shell scripting!
```

### Why the `./` ?
- **`.`** = current directory
- **`/`** = separator
- So `./my_first_script.sh` means "run the script in the current directory"

### Common Beginner Mistake
```bash
# This WON'T work:
my_first_script.sh

# Error: command not found
```

**Why?** The system looks for commands in specific directories (like `/bin`). Your current directory isn't included for security reasons.

---

## Comments in Shell Scripts

Comments are notes for humans - the computer ignores them completely.

### Why Use Comments?
✅ **Remember what you did** (when you look at the script later)  
✅ **Help others understand** your script  
✅ **Temporarily disable code** without deleting it  

### Single-Line Comments
```bash
#!/bin/bash

# This is a comment - it explains what the script does
echo "This line runs"  # This comment explains this specific line

# The next line is temporarily disabled
# echo "This line won't run"
```

### Multi-Line Comments (Hack)
```bash
#!/bin/bash

: '
This is a multi-line comment.
Everything between the single quotes
will be ignored by the shell.
Useful for longer explanations.
'

echo "Script continues here"
```

### Comment Best Practices
```bash
#!/bin/bash
# Script Name: backup_files.sh
# Description: Backs up important files to external drive
# Author: Your Name
# Date Created: 2023-12-25
# Last Modified: 2023-12-25

# Set the backup directory
backup_dir="/external/backup"

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"  # -p creates parent directories if needed

# Copy files to backup location
cp /home/user/documents/* "$backup_dir/"  # Copy all files
```

---

# Part 2: Variables and Data

## Variables - Your First Data Storage

Variables are like labeled boxes where you can store information to use later.

### Real-World Analogy
Imagine you have a box labeled "favorite_color". Inside the box, you put "blue". Later, when someone asks your favorite color, you look in the box labeled "favorite_color" and find "blue".

### Creating Your First Variable
```bash
#!/bin/bash

# Create a variable (no spaces around =)
name="Alice"
age=25
favorite_color="blue"

# Use the variables (notice the $ symbol)
echo "Hello, $name!"
echo "You are $age years old."
echo "Your favorite color is $favorite_color."
```

**Output:**
```
Hello, Alice!
You are 25 years old.
Your favorite color is blue.
```

### Important Rules for Variables

#### ✅ Correct Way
```bash
# Correct - no spaces around =
name="John"
age=30
city="New York"
```

#### ❌ Common Mistakes
```bash
# WRONG - spaces around =
name = "John"     # Error!
age = 30          # Error!

# WRONG - forgetting $ when using variable
echo name         # Prints "name", not "John"

# WRONG - using $ when creating variable
$name="John"      # Error!
```

### Different Ways to Use Variables
```bash
#!/bin/bash

name="Sarah"

# Method 1: Simple usage
echo "Hello $name"

# Method 2: With curly braces (clearer, safer)
echo "Hello ${name}!"

# Method 3: When combining with other text
echo "Hello ${name}Smith"  # HelloSarahSmith
echo "Hello $nameSmith"    # Won't work as expected!
```

### Why Use Curly Braces `{}`?
```bash
#!/bin/bash

filename="report"
extension="txt"

# Without braces - confusing!
echo "$filename.backup.$extension"  # Works, but hard to read

# With braces - crystal clear!
echo "${filename}.backup.${extension}"  # report.backup.txt
```

---

## Different Types of Variables

### 1. String Variables (Text)
```bash
#!/bin/bash

# Single quotes - everything is literal
message='Hello $USER'  # Prints exactly: Hello $USER

# Double quotes - variables are expanded
message="Hello $USER"  # Prints: Hello john (if your username is john)

# No quotes - works for single words
color=blue
```

### 2. Numeric Variables
```bash
#!/bin/bash

# Shell treats everything as text, but can do math
number1=10
number2=5

# Arithmetic expansion
sum=$((number1 + number2))
echo "Sum: $sum"  # Output: Sum: 15

# Other operations
echo "Subtraction: $((number1 - number2))"  # 5
echo "Multiplication: $((number1 * number2))"  # 50
echo "Division: $((number1 / number2))"  # 2
echo "Remainder: $((number1 % 3))"  # 1
```

### 3. Array Variables (Lists)
```bash
#!/bin/bash

# Create an array
fruits=("apple" "banana" "orange")

# Access elements (starts from 0)
echo "First fruit: ${fruits[0]}"   # apple
echo "Second fruit: ${fruits[1]}"  # banana
echo "All fruits: ${fruits[@]}"    # apple banana orange
echo "Number of fruits: ${#fruits[@]}"  # 3
```

### Practical Example: Personal Information Script
```bash
#!/bin/bash
# Personal Information Manager

# Collect information
first_name="John"
last_name="Doe"
age=28
city="San Francisco"
hobbies=("reading" "cycling" "cooking")

# Display information
echo "=== Personal Information ==="
echo "Name: ${first_name} ${last_name}"
echo "Age: ${age} years old"
echo "Location: ${city}"
echo "Hobbies: ${hobbies[@]}"
echo "Number of hobbies: ${#hobbies[@]}"

# Calculate birth year (approximately)
current_year=$(date +%Y)
birth_year=$((current_year - age))
echo "Approximate birth year: ${birth_year}"
```

---

## Special Variables

The shell automatically creates special variables that contain useful information.

### Command Line Related Variables

```bash
#!/bin/bash
# Save this as special_vars.sh

echo "Script name: $0"
echo "First argument: $1" 
echo "Second argument: $2"
echo "Third argument: $3"
echo "All arguments: $@"
echo "Number of arguments: $#"
echo "Exit status of last command: $?"
```

**Run it like this:**
```bash
./special_vars.sh apple banana cherry
```

**Output:**
```
Script name: ./special_vars.sh
First argument: apple
Second argument: banana  
Third argument: cherry
All arguments: apple banana cherry
Number of arguments: 3
Exit status of last command: 0
```

### Process Related Variables
```bash
#!/bin/bash

echo "Current process ID: $$"
echo "Parent process ID: $PPID"
echo "Current user: $USER"
echo "Home directory: $HOME"
echo "Current directory: $PWD"
echo "Previous directory: $OLDPWD"
```

### Practical Example: Script Information
```bash
#!/bin/bash
# Script: show_info.sh
# Shows information about how the script was called

echo "=== Script Execution Information ==="
echo "Script location: $0"
echo "Executed by user: $USER"
echo "From directory: $PWD"
echo "Process ID: $$"
echo ""

if [ $# -eq 0 ]; then
    echo "No arguments provided."
    echo "Usage: $0 <arg1> <arg2> ..."
else
    echo "You provided $# arguments:"
    counter=1
    for arg in "$@"; do
        echo "  Argument $counter: $arg"
        ((counter++))
    done
fi
```

---

## Environment Variables

Environment variables are special variables that are available to all programs running on your system.

### Common Environment Variables
```bash
#!/bin/bash

echo "=== Important Environment Variables ==="
echo "Your username: $USER"
echo "Your home directory: $HOME" 
echo "Your current shell: $SHELL"
echo "System PATH: $PATH"
echo "Current language: $LANG"
echo "Terminal type: $TERM"
```

### Creating Your Own Environment Variables

```bash
#!/bin/bash

# Regular variable (only available in this script)
local_var="I'm only in this script"

# Environment variable (available to child processes)
export GLOBAL_VAR="I'm available everywhere!"

# Show the difference
echo "Local variable: $local_var"
echo "Environment variable: $GLOBAL_VAR"

# Start a new shell to test
echo "Starting new shell - type 'exit' to return"
bash  # In this new shell, try: echo $GLOBAL_VAR
```

### Checking Environment Variables
```bash
#!/bin/bash

# Check if variable exists
if [ -n "$HOME" ]; then
    echo "HOME is set to: $HOME"
else
    echo "HOME is not set"
fi

# Set default value if variable doesn't exist
DATABASE_URL="${DATABASE_URL:-http://localhost:3306}"
echo "Database URL: $DATABASE_URL"

# List all environment variables
echo "All environment variables:"
env | head -10  # Show first 10
```

---

## Variable Naming Rules

### ✅ Good Variable Names
```bash
#!/bin/bash

# Use descriptive names
user_name="john_doe"
file_count=42
database_connection="mysql://localhost"
is_debug_mode=true

# Use UPPERCASE for constants
readonly MAX_USERS=100
readonly CONFIG_FILE="/etc/myapp.conf"

# Use lowercase for regular variables  
current_date=$(date)
temp_directory="/tmp/myapp"
```

### ❌ Bad Variable Names
```bash
#!/bin/bash

# Don't use these patterns:
1name="bad"        # Can't start with number
user-name="bad"    # Can't use hyphens
user name="bad"    # Can't have spaces
$name="bad"        # Don't use $ when creating
```

### Naming Conventions
```bash
#!/bin/bash

# Constants - ALL UPPERCASE
readonly PI=3.14159
readonly MAX_RETRIES=3

# Regular variables - lowercase with underscores
first_name="Alice"
last_name="Smith"
full_name="${first_name} ${last_name}"

# Boolean variables - use is_, has_, can_
is_logged_in=true
has_permission=false
can_write_file=true

# Counters and indices
file_counter=0
current_index=1

# Paths and URLs
home_directory="$HOME"
config_file_path="/etc/app.conf"
api_base_url="https://api.example.com"
```

---

# Part 3: Getting Input

## Reading User Input

Making your scripts interactive by getting input from users.

### Basic Input Reading
```bash
#!/bin/bash

# Ask for user's name
echo "What is your name?"
read user_name

# Use the input
echo "Hello, $user_name! Nice to meet you."
```

**How it works:**
1. `echo` displays a question
2. `read` waits for user to type something and press Enter
3. Whatever they type gets stored in `user_name`
4. We use `$user_name` to access what they typed

### Input with Prompt (One Line)
```bash
#!/bin/bash

# Prompt and read in one line
read -p "Enter your age: " user_age
read -p "Enter your city: " user_city

echo "You are $user_age years old and live in $user_city."
```

### Reading Multiple Values
```bash
#!/bin/bash

echo "Enter your first and last name:"
read first_name last_name

echo "Hello, $first_name $last_name!"

# Or with prompt
read -p "Enter three favorite colors: " color1 color2 color3
echo "Your favorite colors are: $color1, $color2, and $color3"
```

### Reading Passwords (Hidden Input)
```bash
#!/bin/bash

read -p "Username: " username
read -s -p "Password: " password  # -s makes input invisible
echo ""  # New line after hidden input

echo "Login attempt for user: $username"
# Don't echo the password in real scripts!
```

### Input Validation Example
```bash
#!/bin/bash

# Keep asking until valid input
while true; do
    read -p "Enter your age (18-100): " age
    
    # Check if it's a number
    if [[ "$age" =~ ^[0-9]+$ ]]; then
        # Check if in valid range
        if [ "$age" -ge 18 ] && [ "$age" -le 100 ]; then
            echo "Thank you! Age $age is valid."
            break
        else
            echo "Age must be between 18 and 100."
        fi
    else
        echo "Please enter a valid number."
    fi
done
```

---

## Command Line Arguments

Command line arguments let users provide information when they run your script.

### Understanding Arguments
```bash
#!/bin/bash
# Save as: greet.sh

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

**Usage:**
```bash
./greet.sh Alice 25
```

**Output:**
```
Script name: ./greet.sh
First argument: Alice
Second argument: 25
All arguments: Alice 25
Number of arguments: 2
```

### Practical Example: File Backup Script
```bash
#!/bin/bash
# Save as: backup.sh
# Usage: ./backup.sh source_file destination_directory

# Check if correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_file> <destination_directory>"
    echo "Example: $0 /home/user/document.txt /backup/"
    exit 1
fi

source_file="$1"
destination_dir="$2"

# Check if source file exists
if [ ! -f "$source_file" ]; then
    echo "Error: Source file '$source_file' does not exist."
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$destination_dir" ]; then
    echo "Error: Destination directory '$destination_dir' does not exist."
    exit 1
fi

# Perform backup
filename=$(basename "$source_file")
timestamp=$(date +%Y%m%d_%H%M%S)
backup_name="${filename}.backup_${timestamp}"

cp "$source_file" "$destination_dir/$backup_name"

if [ $? -eq 0 ]; then
    echo "Backup successful: $destination_dir/$backup_name"
else
    echo "Backup failed!"
    exit 1
fi
```

### Named Arguments (Advanced)
```bash
#!/bin/bash
# Save as: advanced_args.sh
# Usage: ./advanced_args.sh -n "John" -a 25 -c "New York"

# Initialize variables
name=""
age=""
city=""

# Process arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            name="$2"
            shift 2  # Skip both -n and the value
            ;;
        -a|--age)
            age="$2"
            shift 2
            ;;
        -c|--city)
            city="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "  -n, --name    Specify name"
            echo "  -a, --age     Specify age"
            echo "  -c, --city    Specify city"
            echo "  -h, --help    Show this help"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h for help"
            exit 1
            ;;
    esac
done

# Display information
echo "=== User Information ==="
echo "Name: ${name:-Not provided}"
echo "Age: ${age:-Not provided}"
echo "City: ${city:-Not provided}"
```

---

## Interactive Scripts

Creating user-friendly, interactive scripts.

### Menu-Driven Script
```bash
#!/bin/bash
# Interactive System Information Script

show_menu() {
    clear
    echo "=============================="
    echo "    System Information Menu"
    echo "=============================="
    echo "1. Show current date and time"
    echo "2. Show disk usage"
    echo "3. Show memory usage"
    echo "4. Show running processes"
    echo "5. Show network information"
    echo "6. Exit"
    echo "=============================="
}

while true; do
    show_menu
    read -p "Please select an option (1-6): " choice
    
    case $choice in
        1)
            echo ""
            echo "Current Date and Time:"
            date
            ;;
        2)
            echo ""
            echo "Disk Usage:"
            df -h
            ;;
        3)
            echo ""
            echo "Memory Usage:"
            free -h
            ;;
        4)
            echo ""
            echo "Top 10 Running Processes:"
            ps aux | head -11
            ;;
        5)
            echo ""
            echo "Network Interfaces:"
            ip addr show
            ;;
        6)
            echo "Thank you for using the system information script!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select 1-6."
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
done
```

### Yes/No Confirmation
```bash
#!/bin/bash
# File deletion with confirmation

ask_confirmation() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;  # Yes
            [Nn]* ) return 1;;  # No
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done
}

file_to_delete="$1"

if [ -z "$file_to_delete" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

if [ ! -f "$file_to_delete" ]; then
    echo "File '$file_to_delete' does not exist."
    exit 1
fi

echo "File: $file_to_delete"
echo "Size: $(ls -lh "$file_to_delete" | awk '{print $5}')"

if ask_confirmation "Are you sure you want to delete this file?"; then
    rm "$file_to_delete"
    echo "File deleted successfully."
else
    echo "File deletion cancelled."
fi
```

### Progress Indicator
```bash
#!/bin/bash
# Script with progress indicator

show_progress() {
    local duration=$1
    local bar_length=50
    
    for ((i=0; i<=duration; i++)); do
        # Calculate percentage
        percent=$((i * 100 / duration))
        
        # Calculate number of filled bars
        filled_bars=$((i * bar_length / duration))
        
        # Create progress bar
        bar=""
        for ((j=0; j<bar_length; j++)); do
            if [ $j -lt $filled_bars ]; then
                bar="${bar}#"
            else
                bar="${bar}-"
            fi
        done
        
        # Print progress (carriage return to overwrite)
        printf "\rProgress: [%s] %d%%" "$bar" "$percent"
        
        sleep 0.1
    done
    echo ""  # New line when complete
}

echo "Starting file processing..."
show_progress 100
echo "Processing complete!"
```

---

# Part 4: Making Decisions

## Conditional Statements

Conditional statements let your script make decisions based on different conditions.

### Basic If Statement
```bash
#!/bin/bash

age=20

if [ $age -ge 18 ]; then
    echo "You are an adult."
fi

echo "Script continues here."
```

**How it works:**
- `if` - starts the condition
- `[ $age -ge 18 ]` - the condition to test
- `-ge` means "greater than or equal to"
- `then` - what to do if condition is true
- `fi` - ends the if statement (it's "if" backwards!)

### If-Else Statement
```bash
#!/bin/bash

score=75

if [ $score -ge 80 ]; then
    echo "Great job! You passed with a good score."
else
    echo "You passed, but there's room for improvement."
fi
```

### If-Elif-Else Statement (Multiple Conditions)
```bash
#!/bin/bash

temperature=75

if [ $temperature -ge 90 ]; then
    echo "It's very hot! Stay hydrated."
elif [ $temperature -ge 70 ]; then
    echo "Nice weather for outdoor activities."
elif [ $temperature -ge 50 ]; then
    echo "A bit cool, maybe wear a light jacket."
else
    echo "It's cold! Wear warm clothes."
fi
```

### Nested If Statements
```bash
#!/bin/bash

age=25
has_license="yes"

if [ $age -ge 18 ]; then
    echo "You're old enough to drive."
    
    if [ "$has_license" = "yes" ]; then
        echo "You can legally drive!"
    else
        echo "But you need to get a license first."
    fi
else
    echo "You're too young to drive."
fi
```

---

## Comparison Operators

### Numeric Comparisons
```bash
#!/bin/bash

num1=10
num2=20

# Equal
if [ $num1 -eq $num2 ]; then
    echo "$num1 equals $num2"
fi

# Not equal  
if [ $num1 -ne $num2 ]; then
    echo "$num1 does not equal $num2"
fi

# Less than
if [ $num1 -lt $num2 ]; then
    echo "$num1 is less than $num2"
fi

# Less than or equal
if [ $num1 -le $num2 ]; then
    echo "$num1 is less than or equal to $num2"
fi

# Greater than
if [ $num1 -gt $num2 ]; then
    echo "$num1 is greater than $num2"
fi

# Greater than or equal
if [ $num1 -ge $num2 ]; then
    echo "$num1 is greater than or equal to $num2"  
fi
```

### String Comparisons
```bash
#!/bin/bash

name1="Alice"
name2="Bob"
empty_string=""

# String equality
if [ "$name1" = "$name2" ]; then
    echo "Names are the same"
else
    echo "Names are different"
fi

# String inequality
if [ "$name1" != "$name2" ]; then
    echo "Names are different"
fi

# Check if string is empty
if [ -z "$empty_string" ]; then
    echo "String is empty"
fi

# Check if string is not empty
if [ -n "$name1" ]; then
    echo "String is not empty"
fi

# Check if string contains substring
if [[ "$name1" == *"lic"* ]]; then
    echo "Name contains 'lic'"
fi
```

### Quick Reference Table

| Operator | Meaning | Example |
|----------|---------|---------|
| **Numeric** |
| `-eq` | Equal | `[ $a -eq $b ]` |
| `-ne` | Not equal | `[ $a -ne $b ]` |
| `-lt` | Less than | `[ $a -lt $b ]` |
| `-le` | Less than or equal | `[ $a -le $b ]` |
| `-gt` | Greater than | `[ $a -gt $b ]` |
| `-ge` | Greater than or equal | `[ $a -ge $b ]` |
| **String** |
| `=` | Equal | `[ "$a" = "$b" ]` |
| `!=` | Not equal | `[ "$a" != "$b" ]` |
| `-z` | String is empty | `[ -z "$a" ]` |
| `-n` | String is not empty | `[ -n "$a" ]` |

---

## File Testing

Testing files and directories is very common in shell scripts.

### Basic File Tests
```bash
#!/bin/bash

filename="test.txt"

# Check if file exists
if [ -f "$filename" ]; then
    echo "File $filename exists"
else
    echo "File $filename does not exist"
fi

# Check if directory exists
directory="my_folder"
if [ -d "$directory" ]; then
    echo "Directory $directory exists"
else
    echo "Directory $directory does not exist"
fi
```

### File Permission Tests
```bash
#!/bin/bash

filename="script.sh"

if [ -r "$filename" ]; then
    echo "File is readable"
fi

if [ -w "$filename" ]; then
    echo "File is writable"
fi

if [ -x "$filename" ]; then
    echo "File is executable"
fi

if [ -s "$filename" ]; then
    echo "File is not empty"
else
    echo "File is empty"
fi
```

### File Test Reference Table

| Test | Meaning | Example |
|------|---------|---------|
| `-f` | Regular file exists | `[ -f "file.txt" ]` |
| `-d` | Directory exists | `[ -d "folder" ]` |
| `-e` | File/directory exists | `[ -e "anything" ]` |
| `-r` | File is readable | `[ -r "file.txt" ]` |
| `-w` | File is writable | `[ -w "file.txt" ]` |
| `-x` | File is executable | `[ -x "script.sh" ]` |
| `-s` | File is not empty | `[ -s "file.txt" ]` |

### Practical File Testing Example
```bash
#!/bin/bash
# Backup script with file checking

source_file="$1"
backup_dir="$2"

# Check if user provided arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_file> <backup_directory>"
    exit 1
fi

# Check if source file exists and is readable
if [ ! -f "$source_file" ]; then
    echo "Error: Source file '$source_file' does not exist"
    exit 1
fi

if [ ! -r "$source_file" ]; then
    echo "Error: Cannot read source file '$source_file'"
    exit 1
fi

# Check if backup directory exists and is writable
if [ ! -d "$backup_dir" ]; then
    echo "Error: Backup directory '$backup_dir' does not exist"
    exit 1
fi

if [ ! -w "$backup_dir" ]; then
    echo "Error: Cannot write to backup directory '$backup_dir'"
    exit 1
fi

# Everything looks good, perform backup
filename=$(basename "$source_file")
timestamp=$(date +%Y%m%d_%H%M%S)
backup_file="$backup_dir/${filename}.backup.$timestamp"

cp "$source_file" "$backup_file"

if [ $? -eq 0 ]; then
    echo "Backup successful: $backup_file"
else
    echo "Backup failed"
    exit 1
fi
```

---

## Logical Operators

Combine multiple conditions using logical operators.

### AND Operator (`&&`)
```bash
#!/bin/bash

age=25
has_job="yes"

# Both conditions must be true
if [ $age -ge 18 ] && [ "$has_job" = "yes" ]; then
    echo "Eligible for a credit card"
else
    echo "Not eligible for a credit card"
fi

# Alternative syntax using -a
if [ $age -ge 18 -a "$has_job" = "yes" ]; then
    echo "Eligible for a credit card (alternative syntax)"
fi
```

### OR Operator (`||`)
```bash
#!/bin/bash

day="Saturday"

# Either condition can be true
if [ "$day" = "Saturday" ] || [ "$day" = "Sunday" ]; then
    echo "It's weekend! Time to relax."
else
    echo "It's a weekday. Time to work."
fi

# Alternative syntax using -o
if [ "$day" = "Saturday" -o "$day" = "Sunday" ]; then
    echo "It's weekend! (alternative syntax)"
fi
```

### NOT Operator (`!`)
```bash
#!/bin/bash

file="important.txt"

# Negate a condition
if [ ! -f "$file" ]; then
    echo "File $file does not exist, creating it..."
    touch "$file"
else
    echo "File $file already exists"
fi
```

### Complex Logical Expressions
```bash
#!/bin/bash

username="$1"
password="$2"
is_admin="no"

# Check multiple conditions
if [ -n "$username" ] && [ -n "$password" ] && [ ${#password} -ge 8 ]; then
    echo "Login credentials format is valid"
    
    if [ "$username" = "admin" ] && [ "$password" = "secretpassword" ]; then
        is_admin="yes"
        echo "Admin login successful"
    elif [ "$username" = "user" ] && [ "$password" = "userpass123" ]; then
        echo "User login successful"
    else
        echo "Invalid credentials"
        exit 1
    fi
else
    echo "Error: Username and password required (password must be 8+ chars)"
    exit 1
fi

# Use the login result
if [ "$is_admin" = "yes" ]; then
    echo "Welcome to admin panel"
else
    echo "Welcome to user panel"
fi
```

---

## Case Statements

When you need to check a variable against many different values, `case` statements are cleaner than multiple `if-elif` statements.

### Basic Case Statement
```bash
#!/bin/bash

read -p "Enter a grade (A, B, C, D, F): " grade

case $grade in
    A)
        echo "Excellent! 90-100%"
        ;;
    B)
        echo "Good job! 80-89%"
        ;;
    C)
        echo "Average. 70-79%"
        ;;
    D)
        echo "Below average. 60-69%"
        ;;
    F)
        echo "Failed. Below 60%"
        ;;
    *)
        echo "Invalid grade. Please enter A, B, C, D, or F"
        ;;
esac
```

**How case statements work:**
- `case $variable in` - starts the case statement
- `A)` - matches if variable equals "A"
- `;;` - ends each case (like a break statement)
- `*)` - matches anything else (default case)
- `esac` - ends the case statement ("case" backwards)

### Case with Multiple Patterns
```bash
#!/bin/bash

read -p "Enter a file extension: " extension

case $extension in
    txt|doc|docx)
        echo "Text document"
        ;;
    jpg|jpeg|png|gif)
        echo "Image file"
        ;;
    mp3|wav|flac)
        echo "Audio file"
        ;;
    mp4|avi|mkv)
        echo "Video file"
        ;;
    zip|tar|gz)
        echo "Archive file"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac
```

### Case with Wildcards
```bash
#!/bin/bash

filename="$1"

case $filename in
    *.txt)
        echo "Text file: $filename"
        ;;
    *.jpg|*.png)
        echo "Image file: $filename"
        ;;
    backup_*)
        echo "Backup file: $filename"
        ;;
    [0-9]*)
        echo "Filename starts with a number: $filename"
        ;;
    *)
        echo "Regular file: $filename"
        ;;
esac
```

### Menu System with Case
```bash
#!/bin/bash

show_menu() {
    echo "==========================="
    echo "     File Operations"
    echo "==========================="
    echo "1. List files"
    echo "2. Create file"
    echo "3. Delete file"
    echo "4. Copy file"
    echo "5. Exit"
    echo "==========================="
}

while true; do
    show_menu
    read -p "Select an option (1-5): " choice
    
    case $choice in
        1)
            echo "Files in current directory:"
            ls -la
            ;;
        2)
            read -p "Enter filename to create: " filename
            touch "$filename"
            echo "File '$filename' created"
            ;;
        3)
            read -p "Enter filename to delete: " filename
            if [ -f "$filename" ]; then
                rm "$filename"
                echo "File '$filename' deleted"
            else
                echo "File '$filename' not found"
            fi
            ;;
        4)
            read -p "Enter source file: " source
            read -p "Enter destination: " dest
            if [ -f "$source" ]; then
                cp "$source" "$dest"
                echo "File copied from '$source' to '$dest'"
            else
                echo "Source file '$source' not found"
            fi
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select 1-5."
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    echo ""
done
```

---

# Part 5: Repetition (Loops)

## For Loops

Loops let you repeat actions multiple times without writing the same code over and over.

### Basic For Loop
```bash
#!/bin/bash

# Loop through a list of items
for fruit in apple banana orange grape; do
    echo "I like $fruit"
done

echo "That's all the fruits!"
```

**Output:**
```
I like apple
I like banana
I like orange
I like grape
That's all the fruits!
```

### For Loop with Numbers
```bash
#!/bin/bash

# Loop through numbers 1 to 5
for number in 1 2 3 4 5; do
    echo "Count: $number"
done

# Using range (brace expansion)
echo "Using range:"
for number in {1..10}; do
    echo "Number: $number"
done

# With step (every 2)
echo "Every second number:"
for number in {1..10..2}; do
    echo "Odd number: $number"
done
```

### For Loop with Files
```bash
#!/bin/bash

# Process all text files in current directory
for file in *.txt; do
    if [ -f "$file" ]; then  # Check if file exists
        echo "Processing: $file"
        echo "Size: $(ls -lh "$file" | awk '{print $5}')"
        echo "---"
    fi
done
```

### C-Style For Loop
```bash
#!/bin/bash

# Traditional programming style loop
for ((i=1; i<=10; i++)); do
    echo "Iteration $i"
done

# Countdown
for ((countdown=10; countdown>=1; countdown--)); do
    echo "Countdown: $countdown"
    sleep 1
done
echo "Blast off! 🚀"
```

### Practical Example: Batch File Renaming
```bash
#!/bin/bash

# Rename all .tmp files to .backup
counter=1
for file in *.tmp; do
    if [ -f "$file" ]; then
        new_name="backup_${counter}.backup"
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
        ((counter++))
    fi
done

echo "Renamed $((counter-1)) files"
```

---

## While Loops

While loops continue as long as a condition is true.

### Basic While Loop
```bash
#!/bin/bash

counter=1

while [ $counter -le 5 ]; do
    echo "Counter: $counter"
    ((counter++))  # Increment counter
done

echo "Loop finished"
```

### While Loop Reading File
```bash
#!/bin/bash

filename="users.txt"

# Create sample file
cat > "$filename" << EOF
Alice
Bob
Charlie
Diana
EOF

echo "Reading users from $filename:"
while IFS= read -r line; do
    echo "User: $line"
done < "$filename"
```

### Interactive While Loop
```bash
#!/bin/bash

echo "Guessing Game!"
secret_number=7
attempts=0
max_attempts=3

while [ $attempts -lt $max_attempts ]; do
    read -p "Guess a number between 1-10: " guess
    ((attempts++))
    
    if [ $guess -eq $secret_number ]; then
        echo "Congratulations! You guessed it in $attempts attempts!"
        exit 0
    elif [ $guess -lt $secret_number ]; then
        echo "Too low!"
    else
        echo "Too high!"
    fi
    
    remaining=$((max_attempts - attempts))
    if [ $remaining -gt 0 ]; then
        echo "You have $remaining attempts left."
    fi
done

echo "Game over! The number was $secret_number"
```

### Infinite Loop with Break
```bash
#!/bin/bash

echo "Type 'quit' to exit"

while true; do
    read -p "Enter command: " command
    
    case $command in
        quit|exit)
            echo "Goodbye!"
            break
            ;;
        date)
            date
            ;;
        pwd)
            pwd
            ;;
        ls)
            ls
            ;;
        *)
            echo "Unknown command: $command"
            echo "Available commands: date, pwd, ls, quit"
            ;;
    esac
done
```

---

## Until Loops

Until loops continue as long as a condition is false (opposite of while).

### Basic Until Loop
```bash
#!/bin/bash

counter=1

until [ $counter -gt 5 ]; do
    echo "Counter: $counter"
    ((counter++))
done

echo "Loop finished"
```

### Practical Until Loop Example
```bash
#!/bin/bash

# Wait for a file to be created
target_file="ready.txt"

echo "Waiting for $target_file to be created..."
echo "(Create the file in another terminal to continue)"

until [ -f "$target_file" ]; do
    echo "Still waiting... $(date)"
    sleep 2
done

echo "File $target_file found! Continuing script..."
```

### Until Loop for User Input
```bash
#!/bin/bash

echo "Password must be at least 8 characters"

until [ ${#password} -ge 8 ]; do
    read -s -p "Enter password: " password
    echo ""
    
    if [ ${#password} -lt 8 ]; then
        echo "Password too short (${#password} chars). Must be 8+ characters."
    fi
done

echo "Password accepted!"
```

---

## Loop Control

Control the flow of loops with `break` and `continue`.

### Break Statement
```bash
#!/bin/bash

echo "Counting until we find 7..."

for number in {1..20}; do
    echo "Current number: $number"
    
    if [ $number -eq 7 ]; then
        echo "Found 7! Stopping loop."
        break
    fi
done

echo "Loop ended"
```

### Continue Statement
```bash
#!/bin/bash

echo "Printing odd numbers from 1 to 10:"

for number in {1..10}; do
    # Skip even numbers
    if [ $((number % 2)) -eq 0 ]; then
        continue
    fi
    
    echo "Odd number: $number"
done
```

### Break and Continue in Nested Loops
```bash
#!/bin/bash

echo "Multiplication table (stopping at 5x5):"

for i in {1..10}; do
    for j in {1..10}; do
        product=$((i * j))
        
        # Skip products greater than 25
        if [ $product -gt 25 ]; then
            continue
        fi
        
        echo "$i x $j = $product"
        
        # Stop outer loop when we reach 5x5
        if [ $i -eq 5 ] && [ $j -eq 5 ]; then
            break 2  # Break 2 levels (outer loop)
        fi
    done
done
```

---

## Nested Loops

Loops inside loops for more complex operations.

### Simple Nested Loop
```bash
#!/bin/bash

echo "Multiplication Table:"

for i in {1..5}; do
    for j in {1..5}; do
        product=$((i * j))
        printf "%2d " $product  # Printf for formatting
    done
    echo ""  # New line after each row
done
```

### File Organization Example
```bash
#!/bin/bash

# Create organized directory structure
base_dir="organized_files"
categories=("documents" "images" "videos" "music")
years=("2021" "2022" "2023")

echo "Creating directory structure..."

for category in "${categories[@]}"; do
    for year in "${years[@]}"; do
        dir_path="$base_dir/$category/$year"
        mkdir -p "$dir_path"
        echo "Created: $dir_path"
    done
done

echo "Directory structure created!"
```

### Processing Multiple Files
```bash
#!/bin/bash

# Process different types of files differently
file_types=("txt" "log" "conf")
directories=("/etc" "/var/log" "/tmp")

for dir in "${directories[@]}"; do
    echo "Processing directory: $dir"
    
    if [ ! -d "$dir" ]; then
        echo "Directory $dir doesn't exist, skipping..."
        continue
    fi
    
    for file_type in "${file_types[@]}"; do
        echo "  Looking for .$file_type files..."
        
        for file in "$dir"/*."$file_type"; do
            if [ -f "$file" ]; then
                echo "    Found: $file ($(ls -lh "$file" | awk '{print $5}'))"
            fi
        done
    done
    echo ""
done
```

---

# Part 6: Functions

## What are Functions?

Functions are reusable blocks of code that perform specific tasks. Think of them as mini-programs within your script.

### Why Use Functions?
✅ **Avoid repetition** - Write once, use many times  
✅ **Organize code** - Keep related code together  
✅ **Easier debugging** - Fix bugs in one place  
✅ **Reusability** - Use in multiple scripts  

### Real-World Analogy
A function is like a recipe:
- **Recipe name**: Function name
- **Ingredients**: Parameters/inputs  
- **Instructions**: Function code
- **Final dish**: Return value/output

---

## Creating and Using Functions

### Basic Function Declaration
```bash
#!/bin/bash

# Method 1: function keyword
function say_hello() {
    echo "Hello, World!"
}

# Method 2: without function keyword (more common)
say_goodbye() {
    echo "Goodbye!"
}

# Call the functions
say_hello
say_goodbye
```

### Function with Simple Logic
```bash
#!/bin/bash

# Function to check if a number is even
is_even() {
    local number=$1
    
    if [ $((number % 2)) -eq 0 ]; then
        echo "$number is even"
    else
        echo "$number is odd"
    fi
}

# Test the function
is_even 4
is_even 7
is_even 10
```

---

## Function Parameters

Functions can accept inputs (parameters) to work with different data.

### Functions with Parameters
```bash
#!/bin/bash

# Function that greets a person
greet_person() {
    local name=$1
    local age=$2
    
    echo "Hello, $name!"
    echo "You are $age years old."
}

# Function with default parameter
greet_with_default() {
    local name=${1:-"Friend"}  # Default to "Friend" if no parameter
    echo "Hello, $name!"
}

# Call functions with parameters
greet_person "Alice" 25
greet_person "Bob" 30

echo ""
greet_with_default
greet_with_default "Charlie"
```

### Multiple Parameters Example
```bash
#!/bin/bash

# Calculator function
calculate() {
    local num1=$1
    local operator=$2
    local num2=$3
    
    case $operator in
        +)
            echo "$num1 + $num2 = $((num1 + num2))"
            ;;
        -)
            echo "$num1 - $num2 = $((num1 - num2))"
            ;;
        \*)
            echo "$num1 * $num2 = $((num1 * num2))"
            ;;
        /)
            if [ $num2 -ne 0 ]; then
                echo "$num1 / $num2 = $((num1 / num2))"
            else
                echo "Error: Division by zero!"
            fi
            ;;
        *)
            echo "Error: Unknown operator '$operator'"
            ;;
    esac
}

# Test the calculator
calculate 10 + 5
calculate 15 - 3
calculate 4 \* 6
calculate 20 / 4
calculate 10 / 0
```

### Variable Number of Parameters
```bash
#!/bin/bash

# Function that works with any number of parameters
show_all_params() {
    echo "Function called with $# parameters:"
    
    local counter=1
    for param in "$@"; do
        echo "  Parameter $counter: $param"
        ((counter++))
    done
}

# Test with different numbers of parameters
show_all_params one
show_all_params one two three
show_all_params "hello world" "test" "123"
```

---

## Return Values

Functions can return values to be used by the calling code.

### Return Status (Exit Code)
```bash
#!/bin/bash

# Function that returns success/failure
check_file_exists() {
    local filename=$1
    
    if [ -f "$filename" ]; then
        echo "File '$filename' exists"
        return 0  # Success
    else
        echo "File '$filename' does not exist"
        return 1  # Failure
    fi
}

# Use the return value
if check_file_exists "test.txt"; then
    echo "✓ File check passed"
else
    echo "✗ File check failed"
fi
```

### Return Data Using Echo
```bash
#!/bin/bash

# Function that returns calculated value
get_file_count() {
    local directory=$1
    local count=$(ls -1 "$directory" 2>/dev/null | wc -l)
    echo $count  # This becomes the return value
}

# Capture the returned value
current_dir_files=$(get_file_count ".")
home_dir_files=$(get_file_count "$HOME")

echo "Files in current directory: $current_dir_files"
echo "Files in home directory: $home_dir_files"
```

### Complex Return Example
```bash
#!/bin/bash

# Function that validates email and returns status
validate_email() {
    local email=$1
    local pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if [[ $email =~ $pattern ]]; then
        echo "valid"
        return 0
    else
        echo "invalid"
        return 1
    fi
}

# Test email validation
test_emails=("user@example.com" "invalid.email" "test@domain.org" "bad@")

for email in "${test_emails[@]}"; do
    result=$(validate_email "$email")
    if [ $? -eq 0 ]; then
        echo "✓ $email is $result"
    else
        echo "✗ $email is $result"
    fi
done
```

---

## Local vs Global Variables

Understanding variable scope in functions.

### Global Variables (Default)
```bash
#!/bin/bash

# Global variable
global_counter=0

increment_global() {
    global_counter=$((global_counter + 1))
    echo "Global counter in function: $global_counter"
}

echo "Global counter before: $global_counter"
increment_global
echo "Global counter after: $global_counter"
increment_global
echo "Global counter final: $global_counter"
```

### Local Variables
```bash
#!/bin/bash

global_name="Global Alice"

test_local_scope() {
    local local_name="Local Bob"  # Only exists in this function
    local global_name="Function Alice"  # Shadows global variable
    
    echo "Inside function:"
    echo "  Local name: $local_name"
    echo "  Global name: $global_name"
}

echo "Before function call:"
echo "  Global name: $global_name"

test_local_scope

echo "After function call:"
echo "  Global name: $global_name"
# echo "  Local name: $local_name"  # This would cause an error!
```

### Best Practice Example
```bash
#!/bin/bash

# Good function with proper local variables
process_user_data() {
    local username=$1
    local age=$2
    local email=$3
    
    # Local variables for processing
    local formatted_name=$(echo "$username" | tr '[:lower:]' '[:upper:]')
    local status
    
    # Determine status based on age
    if [ $age -ge 18 ]; then
        status="adult"
    else
        status="minor"
    fi
    
    # Return formatted information
    echo "$formatted_name|$age|$email|$status"
}

# Process multiple users
users=(
    "alice 25 alice@example.com"
    "bob 17 bob@test.com"
    "charlie 30 charlie@work.org"
)

echo "User Processing Results:"
echo "========================"
for user_data in "${users[@]}"; do
    # Split user data
    read -r name age email <<< "$user_data"
    
    # Process and display
    result=$(process_user_data "$name" "$age" "$email")
    IFS='|' read -r formatted_name user_age user_email user_status <<< "$result"
    
    echo "Name: $formatted_name"
    echo "Age: $user_age ($user_status)"
    echo "Email: $user_email"
    echo "---"
done
```

### Function Library Example
```bash
#!/bin/bash

# Utility functions library

# String utilities
string_length() {
    local str=$1
    echo ${#str}
}

string_upper() {
    local str=$1
    echo "$str" | tr '[:lower:]' '[:upper:]'
}

string_lower() {
    local str=$1
    echo "$str" | tr '[:upper:]' '[:lower:]'
}

# Math utilities
add() {
    local a=$1
    local b=$2
    echo $((a + b))
}

multiply() {
    local a=$1
    local b=$2
    echo $((a * b))
}

# File utilities
file_size() {
    local filename=$1
    if [ -f "$filename" ]; then
        ls -lh "$filename" | awk '{print $5}'
    else
        echo "File not found"
    fi
}

# Demo the functions
echo "=== String Functions ==="
text="Hello World"
echo "Original: $text"
echo "Length: $(string_length "$text")"
echo "Upper: $(string_upper "$text")"
echo "Lower: $(string_lower "$text")"

echo ""
echo "=== Math Functions ==="
echo "5 + 3 = $(add 5 3)"
echo "4 * 7 = $(multiply 4 7)"

echo ""
echo "=== File Functions ==="
echo "Size of this script: $(file_size "$0")"
```

---

# Part 7: Working with Files

## File Operations

Working with files is one of the most common tasks in shell scripting.

### Creating Files and Directories
```bash
#!/bin/bash

# Create a single file
touch "new_file.txt"

# Create multiple files
touch file1.txt file2.txt file3.txt

# Create files with current timestamp
timestamp=$(date +%Y%m%d_%H%M%S)
touch "backup_$timestamp.log"

# Create directory
mkdir "new_directory"

# Create nested directories
mkdir -p "path/to/nested/directory"

# Create directory with specific permissions
mkdir -m 755 "public_directory"

echo "Files and directories created successfully!"
```

### Copying and Moving Files
```bash
#!/bin/bash

# Copy file
cp "source.txt" "destination.txt"

# Copy with backup (if destination exists)
cp --backup=numbered "source.txt" "destination.txt"

# Copy directory recursively
cp -r "source_directory" "destination_directory"

# Move (rename) file
mv "old_name.txt" "new_name.txt"

# Move file to different directory
mv "file.txt" "/path/to/destination/"

# Move multiple files
mv *.txt "/destination/directory/"

echo "File operations completed!"
```

### File Information
```bash
#!/bin/bash

get_file_info() {
    local filename=$1
    
    if [ ! -f "$filename" ]; then
        echo "File '$filename' does not exist"
        return 1
    fi
    
    echo "=== File Information: $filename ==="
    echo "Size: $(ls -lh "$filename" | awk '{print $5}')"
    echo "Permissions: $(ls -l "$filename" | awk '{print $1}')"
    echo "Owner: $(ls -l "$filename" | awk '{print $3}')"
    echo "Group: $(ls -l "$filename" | awk '{print $4}')"
    echo "Last modified: $(stat -c %y "$filename")"
    echo "Line count: $(wc -l < "$filename")"
    echo "Word count: $(wc -w < "$filename")"
    echo "Character count: $(wc -c < "$filename")"
}

# Create sample file for testing
cat > sample.txt << EOF
This is a sample file.
It has multiple lines.
We can analyze this file.
EOF

get_file_info "sample.txt"
```

---

## Reading Files

Different ways to read and process file content.

### Reading Entire File at Once
```bash
#!/bin/bash

filename="data.txt"

# Create sample file
cat > "$filename" << EOF
Alice,25,Engineer
Bob,30,Designer
Charlie,28,Manager
Diana,35,Developer
EOF

echo "=== Reading entire file ==="
cat "$filename"

echo ""
echo "=== File content in variable ==="
file_content=$(cat "$filename")
echo "File has $(echo "$file_content" | wc -l) lines"
```

### Reading File Line by Line
```bash
#!/bin/bash

filename="employees.txt"

# Create sample employee file
cat > "$filename" << EOF
Alice Johnson,Engineer,5000
Bob Smith,Designer,4500
Charlie Brown,Manager,6000
Diana Prince,Developer,5500
EOF

echo "=== Processing employees ==="

line_number=1
while IFS= read -r line; do
    echo "Line $line_number: $line"
    
    # Split line by comma
    IFS=',' read -r name position salary <<< "$line"
    
    echo "  Name: $name"
    echo "  Position: $position"
    echo "  Salary: \${salary}"
    echo ""
    
    ((line_number++))
done < "$filename"
```

### Processing CSV Files
```bash
#!/bin/bash

process_csv() {
    local csv_file=$1
    local total_salary=0
    local employee_count=0
    
    echo "=== Employee Report ==="
    
    while IFS=',' read -r name position salary; do
        echo "Employee: $name | Position: $position | Salary: \${salary}"
        
        total_salary=$((total_salary + salary))
        ((employee_count++))
    done < "$csv_file"
    
    if [ $employee_count -gt 0 ]; then
        average_salary=$((total_salary / employee_count))
        echo ""
        echo "Summary:"
        echo "Total employees: $employee_count"
        echo "Total salary budget: \${total_salary}"
        echo "Average salary: \${average_salary}"
    fi
}

# Create sample CSV
cat > employees.csv << EOF
John Doe,Software Engineer,75000
Jane Smith,Product Manager,85000
Mike Johnson,Designer,65000
Sarah Williams,Data Scientist,80000
EOF

process_csv "employees.csv"
```

### Reading Configuration Files
```bash
#!/bin/bash

# Create sample configuration file
cat > app.conf << EOF
# Application Configuration
database_host=localhost
database_port=5432
database_name=myapp
max_connections=100
debug_mode=true
# End of config
EOF

read_config() {
    local config_file=$1
    
    # Declare associative array for config values
    declare -A config
    
    # Read configuration file
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        if [[ $key =~ ^[[:space:]]*# ]] || [[ -z $key ]]; then
            continue
        fi
        
        # Remove leading/trailing whitespace
        key=$(echo "$key" | xargs)
        value=$(echo "$value" | xargs)
        
        config["$key"]="$value"
        
    done < "$config_file"
    
    # Display configuration
    echo "=== Application Configuration ==="
    for key in "${!config[@]}"; do
        echo "$key: ${config[$key]}"
    done
    
    # Use configuration values
    echo ""
    echo "=== Using Configuration ==="
    echo "Connecting to database: ${config[database_host]}:${config[database_port]}/${config[database_name]}"
    echo "Max connections: ${config[max_connections]}"
    
    if [ "${config[debug_mode]}" = "true" ]; then
        echo "Debug mode is enabled"
    fi
}

read_config "app.conf"
```

---

## Writing to Files

Different methods to create and modify file content.

### Basic File Writing
```bash
#!/bin/bash

filename="output.txt"

# Overwrite file (create new or replace existing)
echo "This is the first line" > "$filename"

# Append to file
echo "This is the second line" >> "$filename"
echo "This is the third line" >> "$filename"

# Write multiple lines at once
cat >> "$filename" << EOF
This is line four
This is line five
This is the final line
EOF

echo "Content written to $filename:"
cat "$filename"
```

### Generating Reports
```bash
#!/bin/bash

generate_system_report() {
    local report_file="system_report_$(date +%Y%m%d_%H%M%S).txt"
    
    echo "Generating system report: $report_file"
    
    # Write report header
    cat > "$report_file" << EOF
========================================
    SYSTEM REPORT
========================================
Generated on: $(date)
Hostname: $(hostname)
User: $(whoami)
========================================

EOF
    
    # Add system information
    echo "SYSTEM INFORMATION:" >> "$report_file"
    echo "Operating System: $(uname -s)" >> "$report_file"
    echo "Kernel Version: $(uname -r)" >> "$report_file"
    echo "Architecture: $(uname -m)" >> "$report_file"
    echo "" >> "$report_file"
    
    # Add disk usage
    echo "DISK USAGE:" >> "$report_file"
    df -h >> "$report_file"
    echo "" >> "$report_file"
    
    # Add memory usage
    echo "MEMORY USAGE:" >> "$report_file"
    free -h >> "$report_file"
    echo "" >> "$report_file"
    
    # Add process information
    echo "TOP PROCESSES:" >> "$report_file"
    ps aux | head -10 >> "$report_file"
    
    # Add footer
    echo "" >> "$report_file"
    echo "========================================" >> "$report_file"
    echo "Report generated successfully!" >> "$report_file"
    
    echo "Report saved as: $report_file"
}

generate_system_report
```

### Log File Management
```bash
#!/bin/bash

LOG_FILE="application.log"
MAX_LOG_SIZE=1048576  # 1MB in bytes

# Function to write log entry
write_log() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

# Function to rotate log if too large
rotate_log() {
    if [ -f "$LOG_FILE" ]; then
        local file_size=$(stat -c%s "$LOG_FILE")
        
        if [ $file_size -gt $MAX_LOG_SIZE ]; then
            local backup_file="${LOG_FILE}.$(date +%Y%m%d_%H%M%S)"
            mv "$LOG_FILE" "$backup_file"
            echo "Log rotated: $backup_file"
            write_log "INFO" "Log file rotated"
        fi
    fi
}

# Function to clean old logs
clean_old_logs() {
    local days_to_keep=7
    find . -name "${LOG_FILE}.*" -type f -mtime +$days_to_keep -delete
    write_log "INFO" "Old log files cleaned (older than $days_to_keep days)"
}

# Demo the logging system
write_log "INFO" "Application started"
write_log "DEBUG" "Processing user request"
write_log "WARNING" "Low disk space detected"
write_log "ERROR" "Database connection failed"
write_log "INFO" "Application stopped"

rotate_log
clean_old_logs

echo "Log entries written to $LOG_FILE:"
cat "$LOG_FILE"
```

---

## File Permissions

Understanding and managing file permissions.

### Understanding Permission Numbers
```bash
#!/bin/bash

explain_permissions() {
    local file=$1
    
    if [ ! -e "$file" ]; then
        echo "File '$file' does not exist"
        return 1
    fi
    
    # Get permission string
    local perms=$(ls -l "$file" | awk '{print $1}')
    
    echo "=== Permission Analysis for: $file ==="
    echo "Permission string: $perms"
    echo ""
    
    # Break down permissions
    echo "File type: ${perms:0:1}"
    echo "Owner permissions: ${perms:1:3}"
    echo "Group permissions: ${perms:4:3}"
    echo "Other permissions: ${perms:7:3}"
    echo ""
    
    # Get numeric permissions
    local numeric=$(stat -c %a "$file")
    echo "Numeric permissions: $numeric"
    
    # Explain numeric permissions
    local owner_num=${numeric:0:1}
    local group_num=${numeric:1:1}
    local other_num=${numeric:2:1}
    
    echo ""
    echo "Permission breakdown:"
    echo "Owner ($owner_num): $(explain_permission_digit $owner_num)"
    echo "Group ($group_num): $(explain_permission_digit $group_num)"
    echo "Other ($other_num): $(explain_permission_digit $other_num)"
}

explain_permission_digit() {
    local digit=$1
    local result=""
    
    if [ $((digit & 4)) -ne 0 ]; then result="${result}read "; fi
    if [ $((digit & 2)) -ne 0 ]; then result="${result}write "; fi
    if [ $((digit & 1)) -ne 0 ]; then result="${result}execute "; fi
    
    if [ -z "$result" ]; then
        echo "no permissions"
    else
        echo "$result"
    fi
}

# Create test files with different permissions
echo "Creating test files..."

touch test_readonly.txt
chmod 444 test_readonly.txt

touch test_executable.sh
chmod 755 test_executable.sh

touch test_private.txt
chmod 600 test_private.txt

mkdir test_directory
chmod 755 test_directory

# Analyze each file
for file in test_readonly.txt test_executable.sh test_private.txt test_directory; do
    explain_permissions "$file"
    echo ""
done
```

### Permission Management Examples
```bash
#!/bin/bash

# Function to set safe permissions for different file types
set_safe_permissions() {
    local file=$1
    local file_type=$2
    
    case $file_type in
        "script")
            chmod 755 "$file"  # Owner: rwx, Group: rx, Other: rx
            echo "Set script permissions (755) for: $file"
            ;;
        "config")
            chmod 644 "$file"  # Owner: rw, Group: r, Other: r
            echo "Set config permissions (644) for: $file"
            ;;
        "private")
            chmod 600 "$file"  # Owner: rw, Group: none, Other: none
            echo "Set private permissions (600) for: $file"
            ;;
        "directory")
            chmod 755 "$file"  # Directory needs execute for access
            echo "Set directory permissions (755) for: $file"
            ;;
        *)
            echo "Unknown file type: $file_type"
            return 1
            ;;
    esac
}

# Create example files
echo "#!/bin/bash" > deploy.sh
echo "echo 'Deployment script'" >> deploy.sh

echo "database_password=secret123" > database.conf
echo "api_key=abc123xyz" > private_keys.txt

mkdir logs

# Set appropriate permissions
set_safe_permissions "deploy.sh" "script"
set_safe_permissions "database.conf" "config"
set_safe_permissions "private_keys.txt" "private"
set_safe_permissions "logs" "directory"

echo ""
echo "File permissions set:"
ls -la deploy.sh database.conf private_keys.txt logs
```

---

## Directory Operations

Working with directories and directory structures.

### Directory Navigation and Information
```bash
#!/bin/bash

# Function to analyze directory
analyze_directory() {
    local dir=${1:-.}  # Default to current directory
    
    if [ ! -d "$dir" ]; then
        echo "Error: '$dir' is not a directory"
        return 1
    fi
    
    echo "=== Directory Analysis: $dir ==="
    echo "Full path: $(realpath "$dir")"
    echo "Permissions: $(ls -ld "$dir" | awk '{print $1}')"
    echo ""
    
    # Count different types of files
    local total_files=$(find "$dir" -maxdepth 1 -type f | wc -l)
    local total_dirs=$(find "$dir" -maxdepth 1 -type d | wc -l)
    local hidden_files=$(find "$dir" -maxdepth 1 -name ".*" -type f | wc -l)
    
    echo "Contents:"
    echo "  Regular files: $total_files"
    echo "  Directories: $((total_dirs - 1))"  # Subtract 1 for the directory itself
    echo "  Hidden files: $hidden_files"
    
    # Calculate total size
    local total_size=$(du -sh "$dir" | cut -f1)
    echo "  Total size: $total_size"
    
    echo ""
    echo "Largest files:"
    find "$dir" -maxdepth 1 -type f -exec ls -lh {} \; | sort -rh -k5 | head -5 | awk '{print "  " $9 " (" $5 ")"}'
}

# Create sample directory structure
mkdir -p test_analysis/{documents,images,scripts}
echo "Sample document" > test_analysis/documents/readme.txt
echo "#!/bin/bash" > test_analysis/scripts/test.sh
touch test_analysis/.hidden_file

analyze_directory "test_analysis"
analyze_directory "test_analysis/documents"
```

### Directory Cleanup and Organization
```bash
#!/bin/bash

organize_downloads() {
    local downloads_dir=${1:-"$HOME/Downloads"}
    local organize_dir="$downloads_dir/organized"
    
    if [ ! -d "$downloads_dir" ]; then
        echo "Downloads directory not found: $downloads_dir"
        return 1
    fi
    
    echo "Organizing files in: $downloads_dir"
    
    # Create organization directories
    mkdir -p "$organize_dir"/{documents,images,videos,music,archives,others}
    
    # Count organized files
    local count=0
    
    # Process each file
    for file in "$downloads_dir"/*; do
        # Skip if not a regular file
        if [ ! -f "$file" ]; then
            continue
        fi
        
        # Get file extension
        local basename_file=$(basename "$file")
        local extension="${basename_file##*.}"
        local destination=""
        
        # Determine destination based on extension
        case "${extension,,}" in  # Convert to lowercase
            txt|doc|docx|pdf|rtf|odt)
                destination="$organize_dir/documents"
                ;;
            jpg|jpeg|png|gif|bmp|tiff|svg)
                destination="$organize_dir/images"
                ;;
            mp4|avi|mkv|mov|wmv|flv|webm)
                destination="$organize_dir/videos"
                ;;
            mp3|wav|flac|aac|ogg|wma)
                destination="$organize_dir/music"
                ;;
            zip|tar|gz|rar|7z|bz2)
                destination="$organize_dir/archives"
                ;;
            *)
                destination="$organize_dir/others"
                ;;
        esac
        
        # Move file
        mv "$file" "$destination/"
        echo "Moved: $basename_file -> $(basename "$destination")"
        ((count++))
    done
    
    echo ""
    echo "Organization complete! $count files organized."
    
    # Show results
    echo ""
    echo "Organization results:"
    for category in documents images videos music archives others; do
        local file_count=$(find "$organize_dir/$category" -maxdepth 1 -type f | wc -l)
        if [ $file_count -gt 0 ]; then
            echo "  $category: $file_count files"
        fi
    done
}

# Create sample downloads directory for testing
test_downloads="test_downloads"
mkdir -p "$test_downloads"

# Create sample files
echo "Sample document" > "$test_downloads/document.txt"
echo "Sample PDF content" > "$test_downloads/manual.pdf"
touch "$test_downloads/photo.jpg"
touch "$test_downloads/video.mp4"
touch "$test_downloads/song.mp3"
touch "$test_downloads/archive.zip"
touch "$test_downloads/unknown.xyz"

organize_downloads "$test_downloads"
```

### Backup Directory Structure
```bash
#!/bin/bash

create_backup() {
    local source_dir=$1
    local backup_base_dir=${2:-"./backups"}
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="$backup_base_dir/backup_$timestamp"
    
    if [ ! -d "$source_dir" ]; then
        echo "Error: Source directory '$source_dir' does not exist"
        return 1
    fi
    
    echo "Creating backup of '$source_dir'..."
    echo "Backup location: $backup_dir"
    
    # Create backup directory
    mkdir -p "$backup_dir"
    
    # Copy files with progress
    cp -r "$source_dir"/* "$backup_dir/" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully!"
        
        # Create backup info file
        cat > "$backup_dir/backup_info.txt" << EOF
Backup Information
==================
Source Directory: $source_dir
Backup Created: $(date)
Backup Location: $backup_dir
Files Backed Up: $(find "$backup_dir" -type f | wc -l)
Total Size: $(du -sh "$backup_dir" | cut -f1)
EOF
        
        echo "Backup info saved to: $backup_dir/backup_info.txt"
    else
        echo "Backup failed!"
        return 1
    fi
}

# Clean old backups (keep only last 5)
clean_old_backups() {
    local backup_base_dir=${1:-"./backups"}
    local keep_count=${2:-5}
    
    if [ ! -d "$backup_base_dir" ]; then
        echo "Backup directory does not exist: $backup_base_dir"
        return 0
    fi
    
    echo "Cleaning old backups (keeping last $keep_count)..."
    
    # Find and remove old backups
    local backup_count=$(find "$backup_base_dir" -maxdepth 1 -name "backup_*" -type d | wc -l)
    
    if [ $backup_count -gt $keep_count ]; then
        local to_remove=$((backup_count - keep_count))
        find "$backup_base_dir" -maxdepth 1 -name "backup_*" -type d | sort | head -$to_remove | while read -r old_backup; do
            echo "Removing old backup: $(basename "$old_backup")"
            rm -rf "$old_backup"
        done
    else
        echo "No old backups to clean (found $backup_count, keeping $keep_count)"
    fi
}

# Demo the backup system
mkdir -p important_data
echo "Important document 1" > important_data/doc1.txt
echo "Important document 2" > important_data/doc2.txt
mkdir -p important_data/subfolder
echo "Nested file" > important_data/subfolder/nested.txt

create_backup "important_data"
sleep 2  # Wait 2 seconds
create_backup "important_data"  # Create second backup

clean_old_backups "./backups" 1  # Keep only 1 backup
```

---

# Part 8: Text Processing

## String Operations

Working with strings is fundamental in shell scripting.

### Basic String Operations
```bash
#!/bin/bash

text="Hello World Shell Scripting"

echo "=== Basic String Operations ==="
echo "Original text: $text"

# String length
echo "Length: ${#text}"

# Convert to uppercase
echo "Uppercase: ${text^^}"

# Convert to lowercase  
echo "Lowercase: ${text,,}"

# First character to uppercase
echo "Title case: ${text^}"

# Extract substring (start:length)
echo "Substring (6:5): ${text:6:5}"  # "World"

# Extract from position to end
echo "From position 12: ${text:12}"  # "Shell Scripting"
```

### String Replacement and Manipulation
```bash
#!/bin/bash

filename="document.backup.old.txt"

echo "=== String Replacement ==="
echo "Original: $filename"

# Replace first occurrence
echo "Replace first 'old': ${filename/old/new}"

# Replace all occurrences  
echo "Replace all '.': ${filename//./_}"

# Remove from beginning (shortest match)
echo "Remove extension: ${filename%.*}"

# Remove from beginning (longest match)
echo "Remove all extensions: ${filename%%.*}"

# Remove from end (shortest match)
echo "Remove path prefix: ${filename#*.}"

# Remove from end (longest match)
echo "Get filename only: ${filename##*/}"
```

### Practical String Processing Examples
```bash
#!/bin/bash

# Function to process email addresses
process_email() {
    local email=$1
    
    # Extract username and domain
    local username=${email%@*}
    local domain=${email#*@}
    
    echo "=== Email Analysis ==="
    echo "Full email: $email"
    echo "Username: $username"
    echo "Domain: $domain"
    
    # Check domain type
    local tld=${domain##*.}
    case $tld in
        com|org|net)
            echo "Domain type: Commercial/Standard"
            ;;
        edu)
            echo "Domain type: Educational"
            ;;
        gov)
            echo "Domain type: Government"
            ;;
        *)
            echo "Domain type: Other ($tld)"
            ;;
    esac
}

# Function to format phone numbers
format_phone() {
    local phone=$1
    
    # Remove all non-digit characters
    local digits_only=${phone//[^0-9]/}
    
    echo "=== Phone Number Formatting ==="
    echo "Original: $phone"
    echo "Digits only: $digits_only"
    
    # Format based on length
    local length=${#digits_only}
    
    if [ $length -eq 10 ]; then
        local formatted="${digits_only:0:3}-${digits_only:3:3}-${digits_only:6:4}"
        echo "Formatted: $formatted"
    elif [ $length -eq 11 ] && [ "${digits_only:0:1}" = "1" ]; then
        local formatted="1-${digits_only:1:3}-${digits_only:4:3}-${digits_only:7:4}"
        echo "Formatted: $formatted"
    else
        echo "Invalid phone number length: $length digits"
    fi
}

# Test the functions
process_email "john.doe@company.com"
echo ""
process_email "student@university.edu"
echo ""

format_phone "1234567890"
echo ""
format_phone "+1 (555) 123-4567"
echo ""
format_phone "555.123.4567"
```

---

## Pattern Matching

Advanced pattern matching techniques for text processing.

### Wildcard Pattern Matching
```bash
#!/bin/bash

# Function to categorize files by pattern
categorize_files() {
    local directory=${1:-.}
    
    echo "=== File Categorization ==="
    echo "Scanning directory: $directory"
    echo ""
    
    # Create sample files for demo
    mkdir -p "$directory/sample_files"
    touch "$directory/sample_files"/{report_2023.pdf,data_backup.sql,image001.jpg,script.sh,config.ini,temp123.tmp}
    
    local temp_count=0
    local backup_count=0
    local report_count=0
    local image_count=0
    local script_count=0
    local config_count=0
    local other_count=0
    
    for file in "$directory/sample_files"/*; do
        if [ -f "$file" ]; then
            local basename_file=$(basename "$file")
            
            case "$basename_file" in
                temp*|*.tmp)
                    echo "Temporary file: $basename_file"
                    ((temp_count++))
                    ;;
                *backup*|*.bak)
                    echo "Backup file: $basename_file"
                    ((backup_count++))
                    ;;
                report*|*report*)
                    echo "Report file: $basename_file"
                    ((report_count++))
                    ;;
                *.jpg|*.png|*.gif|image*)
                    echo "Image file: $basename_file"
                    ((image_count++))
                    ;;
                *.sh|*.py|*.pl)
                    echo "Script file: $basename_file"
                    ((script_count++))
                    ;;
                *.ini|*.conf|*.cfg|config*)
                    echo "Configuration file: $basename_file"
                    ((config_count++))
                    ;;
                *)
                    echo "Other file: $basename_file"
                    ((other_count++))
                    ;;
            esac
        fi
    done
    
    echo ""
    echo "=== Summary ==="
    echo "Temporary files: $temp_count"
    echo "Backup files: $backup_count"
    echo "Report files: $report_count"
    echo "Image files: $image_count"
    echo "Script files: $script_count"
    echo "Configuration files: $config_count"
    echo "Other files: $other_count"
}

categorize_files
```

### Advanced Pattern Matching with Bash
```bash
#!/bin/bash

# Function to validate various input formats
validate_input() {
    local input=$1
    local type=$2
    
    case $type in
        "email")
            if [[ $input =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                echo "✓ Valid email: $input"
                return 0
            else
                echo "✗ Invalid email: $input"
                return 1
            fi
            ;;
        "phone")
            if [[ $input =~ ^(\+1[-.]?)?(\([0-9]{3}\)|[0-9]{3})[-.]?[0-9]{3}[-.]?[0-9]{4}$ ]]; then
                echo "✓ Valid phone: $input"
                return 0
            else
                echo "✗ Invalid phone: $input"
                return 1
            fi
            ;;
        "ip")
            if [[ $input =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
                # Additional validation for IP range
                IFS='.' read -r a b c d <<< "$input"
                if [ $a -le 255 ] && [ $b -le 255 ] && [ $c -le 255 ] && [ $d -le 255 ]; then
                    echo "✓ Valid IP: $input"
                    return 0
                fi
            fi
            echo "✗ Invalid IP: $input"
            return 1
            ;;
        "date")
            if [[ $input =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
                echo "✓ Valid date format: $input"
                return 0
            else
                echo "✗ Invalid date format (use YYYY-MM-DD): $input"
                return 1
            fi
            ;;
        *)
            echo "Unknown validation type: $type"
            return 1
            ;;
    esac
}

# Test validation function
echo "=== Input Validation Tests ==="

test_cases=(
    "user@example.com email"
    "invalid.email email"
    "+1 (555) 123-4567 phone"
    "555-123-4567 phone"
    "invalid-phone phone"
    "192.168.1.1 ip"
    "256.300.400.500 ip"
    "2023-12-25 date"
    "12/25/2023 date"
)

for test_case in "${test_cases[@]}"; do
    read -r input type <<< "$test_case"
    validate_input "$input" "$type"
done
```

---

## Regular Expressions

Using regular expressions for complex pattern matching and text processing.

### Introduction to Regular Expressions
```bash
#!/bin/bash

# Function to demonstrate regex patterns
demo_regex() {
    local text="The quick brown fox jumps over the lazy dog. Phone: 555-123-4567. Email: fox@example.com"
    
    echo "=== Regular Expression Examples ==="
    echo "Text: $text"
    echo ""
    
    # Find words starting with specific letters
    echo "Words starting with 't' (case insensitive):"
    echo "$text" | grep -oiE '\bt[a-z]*'
    echo ""
    
    # Find all numbers
    echo "All numbers:"
    echo "$text" | grep -oE '[0-9]+'
    echo ""
    
    # Find phone number
    echo "Phone number:"
    echo "$text" | grep -oE '[0-9]{3}-[0-9]{3}-[0-9]{4}'
    echo ""
    
    # Find email address
    echo "Email address:"
    echo "$text" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
    echo ""
    
    # Find words with specific length
    echo "Words with exactly 4 characters:"
    echo "$text" | grep -oE '\b[a-zA-Z]{4}\b'
}

demo_regex
```

### Log File Analysis with Regex
```bash
#!/bin/bash

# Create sample log file
create_sample_log() {
    local log_file="access.log"
    
    cat > "$log_file" << EOF
192.168.1.100 - - [25/Dec/2023:10:00:01 +0000] "GET /home HTTP/1.1" 200 1234
10.0.0.50 - - [25/Dec/2023:10:00:02 +0000] "POST /login HTTP/1.1" 401 567
192.168.1.100 - - [25/Dec/2023:10:00:03 +0000] "GET /dashboard HTTP/1.1" 200 2345
203.0.113.15 - - [25/Dec/2023:10:00:04 +0000] "GET /api/data HTTP/1.1" 500 89
192.168.1.100 - - [25/Dec/2023:10:00:05 +0000] "GET /profile HTTP/1.1" 200 1567
10.0.0.75 - - [25/Dec/2023:10:00:06 +0000] "DELETE /user/123 HTTP/1.1" 404 234
EOF
    
    echo "Sample log file created: $log_file"
}

# Function to analyze log file
analyze_log() {
    local log_file=$1
    
    if [ ! -f "$log_file" ]; then
        echo "Log file not found: $log_file"
        return 1
    fi
    
    echo "=== Log File Analysis ==="
    echo ""
    
    # Count total requests
    local total_requests=$(wc -l < "$log_file")
    echo "Total requests: $total_requests"
    
    # Count unique IP addresses
    echo "Unique IP addresses:"
    grep -oE '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' "$log_file" | sort -u
    
    echo ""
    echo "Request methods:"
    grep -oE '"[A-Z]+ ' "$log_file" | sed 's/"//g' | sort | uniq -c
    
    echo ""
    echo "HTTP status codes:"
    grep -oE ' [0-9]{3} ' "$log_file" | sort | uniq -c
    
    echo ""
    echo "Error requests (4xx and 5xx):"
    grep -E ' [45][0-9]{2} ' "$log_file"
    
    echo ""
    echo "Most requested URLs:"
    grep -oE '"[A-Z]+ [^"]*"' "$log_file" | cut -d' ' -f2 | sort | uniq -c | sort -nr
    
    echo ""
    echo "Requests by IP address:"
    grep -oE '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' "$log_file" | sort | uniq -c | sort -nr
}

create_sample_log
analyze_log "access.log"
```

---

## Text Processing Tools

### grep, sed, and awk - The Power Trio

### GREP - Global Regular Expression Print
```bash
#!/bin/bash

# Create sample data file
create_employee_data() {
    cat > employees.txt << EOF
John Doe,Software Engineer,Engineering,75000,2020-01-15
Jane Smith,Product Manager,Product,85000,2019-03-20
Mike Johnson,Designer,Design,65000,2021-06-10
Sarah Williams,Data Scientist,Engineering,80000,2020-11-05
Tom Brown,Marketing Manager,Marketing,70000,2018-05-12
Lisa Davis,QA Engineer,Engineering,68000,2021-02-28
David Wilson,Sales Representative,Sales,55000,2022-01-10
Emily Chen,DevOps Engineer,Engineering,78000,2019-08-15
EOF
    echo "Employee data file created: employees.txt"
}

# Comprehensive grep examples
demo_grep() {
    local file="employees.txt"
    
    echo "=== GREP Examples ==="
    echo "Data file: $file"
    echo ""
    
    # Basic search
    echo "1. All Engineering employees:"
    grep "Engineering" "$file"
    echo ""
    
    # Case insensitive search
    echo "2. All employees with 'engineer' in title (case insensitive):"
    grep -i "engineer" "$file"
    echo ""
    
    # Count matches
    echo "3. Number of Engineering employees:"
    grep -c "Engineering" "$file"
    echo ""
    
    # Show line numbers
    echo "4. Engineering employees with line numbers:"
    grep -n "Engineering" "$file"
    echo ""
    
    # Invert match (show lines that DON'T match)
    echo "5. Non-Engineering employees:"
    grep -v "Engineering" "$file"
    echo ""
    
    # Multiple patterns
    echo "6. Engineering OR Marketing employees:"
    grep -E "(Engineering|Marketing)" "$file"
    echo ""
    
    # Show only the matched part
    echo "7. Extract only salary information:"
    grep -oE "[0-9]{5,6}" "$file"
    echo ""
    
    # Using regex patterns
    echo "8. Employees hired in 2020:"
    grep "2020-" "$file"
    echo ""
    
    # Find employees with specific salary range
    echo "9. Employees with salary 70000-80000:"
    grep -E "7[0-9]{4}|80000" "$file"
    echo ""
    
    # Context lines (show lines before and after match)
    echo "10. Data Scientist with context (1 line before and after):"
    grep -C 1 "Data Scientist" "$file"
}

create_employee_data
demo_grep
```

### SED - Stream Editor
```bash
#!/bin/bash

# SED examples for text manipulation
demo_sed() {
    local file="employees.txt"
    
    echo "=== SED Examples ==="
    echo "Original data:"
    cat "$file"
    echo ""
    
    # Basic substitution
    echo "1. Replace 'Engineering' with 'Tech':"
    sed 's/Engineering/Tech/' "$file"
    echo ""
    
    # Global substitution (all occurrences in a line)
    echo "2. Replace all commas with pipe symbols:"
    sed 's/,/|/g' "$file"
    echo ""
    
    # Delete lines
    echo "3. Delete lines containing 'Marketing':"
    sed '/Marketing/d' "$file"
    echo ""
    
    # Print specific lines
    echo "4. Print only lines 2-4:"
    sed -n '2,4p' "$file"
    echo ""
    
    # Add text before/after lines
    echo "5. Add header and footer:"
    sed '1i\=== EMPLOYEE REPORT ===' "$file" | sed '$a\=== END OF REPORT ==='
    echo ""
    
    # Multiple operations
    echo "6. Multiple operations (replace Engineering, delete Sales):"
    sed -e 's/Engineering/Tech/g' -e '/Sales/d' "$file"
    echo ""
    
    # Extract specific fields (using delimiter)
    echo "7. Extract names and departments:"
    sed 's/^\([^,]*\),\([^,]*\),\([^,]*\).*/Name: \1, Department: \3/' "$file"
    echo ""
    
    # Conditional replacement
    echo "8. Add 'Senior' title to employees with salary > 75000:"
    sed 's/^\([^,]*\),\([^,]*\),\([^,]*\),\(7[6-9][0-9][0-9][0-9]\|8[0-9][0-9][0-9][0-9]\)/\1,Senior \2,\3,\4/' "$file"
}

demo_sed
```

### AWK - Pattern Scanning and Processing
```bash
#!/bin/bash

# AWK examples for advanced text processing
demo_awk() {
    local file="employees.txt"
    
    echo "=== AWK Examples ==="
    echo ""
    
    # Basic field processing
    echo "1. Print names and salaries (fields 1 and 4):"
    awk -F',' '{print $1 " earns $" $4}' "$file"
    echo ""
    
    # Conditional processing
    echo "2. High earners (salary > 75000):"
    awk -F',' '$4 > 75000 {print $1 " - $" $4}' "$file"
    echo ""
    
    # Calculate totals and averages
    echo "3. Salary statistics:"
    awk -F',' '
    {
        total += $4
        count++
        if ($4 > max || NR == 1) max = $4
        if ($4 < min || NR == 1) min = $4
    }
    END {
        print "Total employees: " count
        print "Total salary budget: $" total
        print "Average salary: $" total/count
        print "Highest salary: $" max
        print "Lowest salary: $" min
    }' "$file"
    echo ""
    
    # Group by department
    echo "4. Count by department:"
    awk -F',' '{dept[$3]++} END {for (d in dept) print d ": " dept[d] " employees"}' "$file"
    echo ""
    
    # Department salary totals
    echo "5. Total salary by department:"
    awk -F',' '{dept_salary[$3] += $4} END {for (d in dept_salary) print d ": $" dept_salary[d]}' "$file"
    echo ""
    
    # Format output nicely
    echo "6. Formatted employee report:"
    awk -F',' '
    BEGIN {
        print "================================="
        print "         EMPLOYEE REPORT"
        print "================================="
        printf "%-20s %-20s %-15s %10s\n", "Name", "Title", "Department", "Salary"
        print "---------------------------------"
    }
    {
        printf "%-20s %-20s %-15s %10s\n", $1, $2, $3, "$"$4
    }
    END {
        print "================================="
    }' "$file"
    echo ""
    
    # Hire date analysis
    echo "7. Employees hired each year:"
    awk -F',' '{
        split($5, date, "-")
        year_count[date[1]]++
    }
    END {
        for (year in year_count) {
            print year ": " year_count[year] " employees"
        }
    }' "$file"
}

demo_awk
```

### Combined Text Processing Pipeline
```bash
#!/bin/bash

# Advanced text processing combining all tools
process_sales_data() {
    # Create sample sales data
    cat > sales_data.txt << EOF
2023-01-15,John Smith,Electronics,Laptop,1200,North
2023-01-16,Jane Doe,Books,Programming Guide,45,South  
2023-01-17,Mike Johnson,Electronics,Smartphone,800,East
2023-01-18,Sarah Wilson,Clothing,Jacket,120,West
2023-01-19,Tom Brown,Electronics,Tablet,600,North
2023-01-20,Lisa Davis,Books,Database Design,65,South
2023-01-21,David Chen,Clothing,Shoes,85,East
2023-01-22,Emily White,Electronics,Headphones,150,West
EOF
    
    echo "=== Advanced Text Processing Pipeline ==="
    echo "Raw sales data:"
    cat sales_data.txt
    echo ""
    
    # Processing pipeline
    echo "Processing pipeline:"
    echo "1. Filter Electronics sales"
    echo "2. Sort by amount (descending)"
    echo "3. Format output"
    echo "4. Calculate statistics"
    echo ""
    
    # Step 1: Process the data
    grep "Electronics" sales_data.txt | \
    sort -t',' -k5 -nr | \
    awk -F',' '
    BEGIN {
        print "=========================================="
        print "        ELECTRONICS SALES REPORT"
        print "=========================================="
        printf "%-12s %-15s %-15s %8s %8s\n", "Date", "Salesperson", "Product", "Amount", "Region"
        print "------------------------------------------"
        total = 0
        count = 0
    }
    {
        printf "%-12s %-15s %-15s $%7.2f %8s\n", $1, $2, $4, $5, $6
        total += $5
        count++
        region_sales[$6] += $5
        product_sales[$4] += $5
    }
    END {
        print "=========================================="
        printf "Total Sales: $%.2f\n", total
        printf "Average Sale: $%.2f\n", total/count
        printf "Number of Sales: %d\n", count
        print ""
        print "Sales by Region:"
        for (region in region_sales) {
            printf "  %s: $%.2f\n", region, region_sales[region]
        }
        print ""
        print "Sales by Product:"
        for (product in product_sales) {
            printf "  %s: $%.2f\n", product, product_sales[product]
        }
        print "=========================================="
    }'
    
    echo ""
    echo "Top 3 sales across all categories:"
    sort -t',' -k5 -nr sales_data.txt | head -3 | \
    awk -F',' '{printf "%s: %s sold %s for $%s in %s region\n", $1, $2, $4, $5, $6}'
    
    # Cleanup
    rm -f sales_data.txt
}

process_sales_data
```

---

# Part 9: Arrays and Advanced Data

## Understanding Arrays

Arrays let you store multiple values in a single variable, like a list of items.

### Basic Array Concepts
```bash
#!/bin/bash

echo "=== Array Basics ==="

# Method 1: Declare array with values
fruits=("apple" "banana" "orange" "grape")

# Method 2: Declare empty array and add elements
declare -a colors
colors[0]="red"
colors[1]="green"
colors[2]="blue"

# Method 3: Add elements to existing array
numbers=(1 2 3)
numbers+=(4 5 6)  # Append elements

echo "Fruits array: ${fruits[@]}"
echo "Colors array: ${colors[@]}"
echo "Numbers array: ${numbers[@]}"

echo ""
echo "Array lengths:"
echo "Fruits: ${#fruits[@]} elements"
echo "Colors: ${#colors[@]} elements"
echo "Numbers: ${#numbers[@]} elements"
```

---

## Working with Arrays

### Accessing Array Elements
```bash
#!/bin/bash

servers=("web1.example.com" "web2.example.com" "db1.example.com" "cache1.example.com")

echo "=== Accessing Array Elements ==="
echo "All servers: ${servers[@]}"
echo "First server: ${servers[0]}"
echo "Last server: ${servers[-1]}"  # Bash 4.3+
echo "Second and third: ${servers[@]:1:2}"
echo ""

# Loop through array with indices
echo "Servers with indices:"
for i in "${!servers[@]}"; do
    echo "Server $i: ${servers[i]}"
done

echo ""

# Loop through array values
echo "Processing each server:"
for server in "${servers[@]}"; do
    echo "Connecting to $server..."
    # Simulate some operation
    if [[ $server == *"db"* ]]; then
        echo "  -> Database server detected"
    elif [[ $server == *"web"* ]]; then
        echo "  -> Web server detected"
    else
        echo "  -> Other service detected"
    fi
done
```

### Array Manipulation
```bash
#!/bin/bash

# Start with an array
tasks=("backup" "update" "restart" "monitor")

echo "=== Array Manipulation ==="
echo "Initial tasks: ${tasks[@]}"

# Add element to end
tasks+=("cleanup")
echo "After adding cleanup: ${tasks[@]}"

# Add element to beginning (requires reconstruction)
tasks=("prepare" "${tasks[@]}")
echo "After adding prepare: ${tasks[@]}"

# Remove element by index (create new array without that element)
remove_element() {
    local array_name=$1
    local index=$2
    local -n arr_ref=$array_name
    
    # Create new array without the specified index
    local new_array=()
    for i in "${!arr_ref[@]}"; do
        if [ $i -ne $index ]; then
            new_array+=("${arr_ref[i]}")
        fi
    done
    
    # Replace original array
    arr_ref=("${new_array[@]}")
}

echo ""
echo "Removing task at index 2 (${tasks[2]}):"
remove_element tasks 2
echo "After removal: ${tasks[@]}"

# Find and remove element by value
remove_by_value() {
    local array_name=$1
    local value=$2
    local -n arr_ref=$array_name
    
    local new_array=()
    for element in "${arr_ref[@]}"; do
        if [ "$element" != "$value" ]; then
            new_array+=("$element")
        fi
    done
    
    arr_ref=("${new_array[@]}")
}

echo ""
echo "Removing 'update' task:"
remove_by_value tasks "update"
echo "Final tasks: ${tasks[@]}"
```

### Practical Array Examples
```bash
#!/bin/bash

# System monitoring script using arrays
system_monitor() {
    echo "=== System Monitoring with Arrays ==="
    
    # Define what to monitor
    services=("ssh" "nginx" "mysql" "docker")
    directories=("/var/log" "/tmp" "/home" "/var/www")
    processes=("sshd" "nginx" "mysqld" "dockerd")
    
    echo "Checking services:"
    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service" 2>/dev/null; then
            echo "✓ $service is running"
        else
            echo "✗ $service is not running"
        fi
    done
    
    echo ""
    echo "Checking disk usage:"
    for dir in "${directories[@]}"; do
        if [ -d "$dir" ]; then
            local usage=$(df "$dir" | tail -1 | awk '{print $5}' | sed 's/%//')
            if [ "$usage" -gt 80 ]; then
                echo "⚠ $dir is ${usage}% full"
            else
                echo "✓ $dir usage: ${usage}%"
            fi
        else
            echo "✗ $dir does not exist"
        fi
    done
    
    echo ""
    echo "Process memory usage:"
    for process in "${processes[@]}"; do
        local mem_usage=$(ps aux | grep "[${process:0:1}]${process:1}" | awk '{sum+=$6} END {print sum/1024}')
        if [ -n "$mem_usage" ] && [ "$mem_usage" != "0" ]; then
            printf "%-10s: %.1f MB\n" "$process" "$mem_usage"
        else
            printf "%-10s: Not running\n" "$process"
        fi
    done
}

# User management with arrays
user_management_demo() {
    echo ""
    echo "=== User Management Demo ==="
    
    # Sample user data
    usernames=("alice" "bob" "charlie" "diana")
    departments=("IT" "Sales" "Marketing" "Finance")
    permissions=("admin" "user" "user" "manager")
    
    echo "User account summary:"
    for i in "${!usernames[@]}"; do
        printf "%-10s | %-10s | %-8s\n" "${usernames[i]}" "${departments[i]}" "${permissions[i]}"
    done
    
    echo ""
    echo "Users by permission level:"
    
    # Group users by permission
    declare -A perm_groups
    for i in "${!usernames[@]}"; do
        local perm="${permissions[i]}"
        if [ -z "${perm_groups[$perm]}" ]; then
            perm_groups[$perm]="${usernames[i]}"
        else
            perm_groups[$perm]="${perm_groups[$perm]}, ${usernames[i]}"
        fi
    done
    
    for perm in "${!perm_groups[@]}"; do
        echo "$perm: ${perm_groups[$perm]}"
    done
}

# File backup script with arrays
backup_demo() {
    echo ""
    echo "=== Backup Script Demo ==="
    
    # Define backup sources and destinations
    backup_sources=("/home/user/documents" "/home/user/pictures" "/etc/nginx")
    backup_destinations=("/backup/daily" "/backup/weekly" "/backup/config")
    backup_types=("incremental" "full" "config")
    
    echo "Backup plan:"
    for i in "${!backup_sources[@]}"; do
        local source="${backup_sources[i]}"
        local destination="${backup_destinations[i]}"
        local type="${backup_types[i]}"
        
        printf "%-25s -> %-20s (%s)\n" "$source" "$destination" "$type"
        
        # Simulate backup process
        if [ -d "$source" ] || [ -f "$source" ]; then
            echo "  ✓ Source accessible"
        else
            echo "  ✗ Source not found"
        fi
    done
    
    # Calculate total backup size (simulated)
    echo ""
    echo "Estimated backup sizes:"
    local total_size=0
    for source in "${backup_sources[@]}"; do
        local size=$((RANDOM % 1000 + 100))  # Simulate size
        echo "  $source: ${size}MB"
        total_size=$((total_size + size))
    done
    echo "Total estimated size: ${total_size}MB"
}

# Run all demos
system_monitor
user_management_demo  
backup_demo
```

---

## Associative Arrays

Associative arrays use strings as keys instead of numbers, like a dictionary.

### Basic Associative Arrays
```bash
#!/bin/bash

echo "=== Associative Arrays Basics ==="

# Declare associative array
declare -A server_info

# Add key-value pairs
server_info[web1]="192.168.1.10"
server_info[web2]="192.168.1.11"
server_info[database]="192.168.1.20"
server_info[cache]="192.168.1.30"

echo "Server information:"
for server in "${!server_info[@]}"; do
    echo "$server: ${server_info[$server]}"
done

echo ""
echo "Access specific server:"
echo "Web1 IP: ${server_info[web1]}"
echo "Database IP: ${server_info[database]}"

# Check if key exists
if [ -n "${server_info[web3]}" ]; then
    echo "Web3 exists: ${server_info[web3]}"
else
    echo "Web3 server not found"
fi
```

### Advanced Associative Array Usage
```bash
#!/bin/bash

# Configuration management with associative arrays
config_manager() {
    echo "=== Configuration Manager ==="
    
    # Application configuration
    declare -A app_config
    app_config[database_host]="localhost"
    app_config[database_port]="5432"
    app_config[database_name]="myapp"
    app_config[cache_enabled]="true"
    app_config[debug_mode]="false"
    app_config[max_connections]="100"
    
    # Environment-specific overrides
    declare -A prod_config
    prod_config[database_host]="prod-db.example.com"
    prod_config[cache_enabled]="true"
    prod_config[debug_mode]="false"
    prod_config[max_connections]="500"
    
    declare -A dev_config
    dev_config[database_host]="dev-db.example.com"
    dev_config[debug_mode]="true"
    dev_config[max_connections]="10"
    
    # Function to merge configurations
    merge_config() {
        local environment=$1
        declare -A final_config
        
        # Start with base config
        for key in "${!app_config[@]}"; do
            final_config[$key]="${app_config[$key]}"
        done
        
        # Override with environment-specific config
        if [ "$environment" = "production" ]; then
            for key in "${!prod_config[@]}"; do
                final_config[$key]="${prod_config[$key]}"
            done
        elif [ "$environment" = "development" ]; then
            for key in "${!dev_config[@]}"; do
                final_config[$key]="${dev_config[$key]}"
            done
        fi
        
        # Display final configuration
        echo "Configuration for $environment:"
        echo "================================"
        for key in "${!final_config[@]}"; do
            printf "%-20s: %s\n" "$key" "${final_config[$key]}"
        done
        echo ""
    }
    
    merge_config "development"
    merge_config "production"
}

# Error code management
error_handler() {
    echo "=== Error Handler with Associative Arrays ==="
    
    # Define error codes and messages
    declare -A error_codes
    error_codes[001]="File not found"
    error_codes[002]="Permission denied"
    error_codes[003]="Network connection failed"
    error_codes[004]="Invalid input format"
    error_codes[005]="Database connection error"
    
    # Define error severity
    declare -A error_severity
    error_severity[001]="WARNING"
    error_severity[002]="ERROR"
    error_severity[003]="CRITICAL"
    error_severity[004]="WARNING"
    error_severity[005]="CRITICAL"
    
    # Function to report error
    report_error() {
        local error_code=$1
        local context=${2:-"Unknown"}
        
        if [ -n "${error_codes[$error_code]}" ]; then
            local message="${error_codes[$error_code]}"
            local severity="${error_severity[$error_code]}"
            local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
            
            echo "[$timestamp] [$severity] Error $error_code: $message (Context: $context)"
            
            # Take action based on severity
            case $severity in
                "CRITICAL")
                    echo "  -> CRITICAL error detected. Immediate action required!"
                    ;;
                "ERROR")
                    echo "  -> Error logged. Please investigate."
                    ;;
                "WARNING")
                    echo "  -> Warning noted. Monitor situation."
                    ;;
            esac
        else
            echo "Unknown error code: $error_code"
        fi
    }
    
    # Simulate some errors
    report_error "001" "Processing user file"
    report_error "003" "Connecting to remote server"
    report_error "004" "User input validation"
    report_error "999" "Unknown operation"
}

# Inventory management system
inventory_system() {
    echo ""
    echo "=== Inventory Management System ==="
    
    # Product information
    declare -A product_names
    declare -A product_prices
    declare -A product_stock
    
    # Initialize inventory
    product_names[001]="Laptop Computer"
    product_prices[001]=1200.00
    product_stock[001]=15
    
    product_names[002]="Wireless Mouse"
    product_prices[002]=25.99
    product_stock[002]=50
    
    product_names[003]="Mechanical Keyboard"
    product_prices[003]=89.99
    product_stock[003]=30
    
    product_names[004]="USB-C Hub"
    product_prices[004]=45.50
    product_stock[004]=25
    
    # Function to display inventory
    show_inventory() {
        echo "Current Inventory:"
        echo "======================================"
        printf "%-4s %-20s %-10s %-8s\n" "ID" "Product" "Price" "Stock"
        echo "--------------------------------------"
        
        for id in "${!product_names[@]}"; do
            printf "%-4s %-20s $%-9.2f %-8d\n" "$id" "${product_names[$id]}" "${product_prices[$id]}" "${product_stock[$id]}"
        done
        echo "======================================"
    }
    
    # Function to update stock
    update_stock() {
        local product_id=$1
        local quantity_change=$2
        
        if [ -n "${product_stock[$product_id]}" ]; then
            local old_stock=${product_stock[$product_id]}
            local new_stock=$((old_stock + quantity_change))
            
            if [ $new_stock -lt 0 ]; then
                echo "Error: Cannot reduce stock below 0 for ${product_names[$product_id]}"
                return 1
            fi
            
            product_stock[$product_id]=$new_stock
            echo "Updated ${product_names[$product_id]}: $old_stock -> $new_stock units"
        else
            echo "Product ID $product_id not found"
            return 1
        fi
    }
    
    # Function to calculate total inventory value
    calculate_total_value() {
        local total_value=0
        
        echo ""
        echo "Inventory Value Calculation:"
        echo "================================"
        
        for id in "${!product_names[@]}"; do
            local value=$(echo "${product_prices[$id]} * ${product_stock[$id]}" | bc -l)
            printf "%-20s: $%.2f\n" "${product_names[$id]}" "$value"
            total_value=$(echo "$total_value + $value" | bc -l)
        done
        
        echo "================================"
        printf "Total Inventory Value: $%.2f\n" "$total_value"
    }
    
    # Demo the inventory system
    show_inventory
    echo ""
    
    # Simulate some transactions
    echo "Processing transactions..."
    update_stock "001" -2   # Sell 2 laptops
    update_stock "002" 10   # Restock mice
    update_stock "003" -5   # Sell 5 keyboards
    
    echo ""
    show_inventory
    
    if command -v bc >/dev/null 2>&1; then
        calculate_total_value
    else
        echo "Note: 'bc' calculator not available for value calculation"
    fi
}

# Run all demos
config_manager
error_handler
inventory_system
```

---

# Part 10: Advanced Topics

## Process Management

Understanding and managing processes in shell scripts.

### Basic Process Information
```bash
#!/bin/bash

echo "=== Process Information ==="
echo "Current script PID: $"
echo "Parent process PID: $PPID"
echo "Current user: $(whoami)"
echo "Current working directory: $(pwd)"
echo ""

# Show process hierarchy
echo "Process hierarchy:"
ps -f --forest | head -10

echo ""
echo "Top memory-consuming processes:"
ps aux --sort=-%mem | head -6
```

### Background Processes and Job Control
```bash
#!/bin/bash

# Function to simulate long-running task
long_task() {
    local task_name=$1
    local duration=${2:-10}
    
    echo "Starting $task_name (will run for $duration seconds)..."
    
    for ((i=1; i<=duration; i++)); do
        echo "$task_name: Step $i/$duration"
        sleep 1
    done
    
    echo "$task_name completed!"
}

echo "=== Background Process Demo ==="

# Run task in background
long_task "Background Task" 5 &
bg_pid=$!

echo "Background task started with PID: $bg_pid"
echo "Continuing with other work..."

# Do other work while background task runs
for i in {1..3}; do
    echo "Doing foreground work: step $i"
    sleep 1
done

# Wait for background task to complete
echo "Waiting for background task to complete..."
wait $bg_pid
echo "Background task finished!"

# Check if process is still running
check_process() {
    local pid=$1
    if ps -p $pid > /dev/null 2>&1; then
        echo "Process $pid is running"
        return 0
    else
        echo "Process $pid is not running"
        return 1
    fi
}

echo ""
echo "Process check:"
check_process $bg_pid
```

### Advanced Process Management
```bash
#!/bin/bash

# Process monitoring and management
process_manager() {
    echo "=== Advanced Process Management ==="
    
    # Function to start monitored process
    start_monitored_process() {
        local process_name=$1
        local command=$2
        
        echo "Starting monitored process: $process_name"
        
        # Start process in background
        $command &
        local pid=$!
        
        # Store PID in file
        echo $pid > "/tmp/${process_name}.pid"
        echo "Process $process_name started with PID: $pid"
        
        return $pid
    }
    
    # Function to stop monitored process
    stop_monitored_process() {
        local process_name=$1
        local pid_file="/tmp/${process_name}.pid"
        
        if [ -f "$pid_file" ]; then
            local pid=$(cat "$pid_file")
            
            if ps -p $pid > /dev/null 2>&1; then
                echo "Stopping process $process_name (PID: $pid)"
                kill $pid
                
                # Wait for graceful shutdown
                local timeout=5
                while [ $timeout -gt 0 ] && ps -p $pid > /dev/null 2>&1; do
                    sleep 1
                    ((timeout--))
                done
                
                # Force kill if still running
                if ps -p $pid > /dev/null 2>&1; then
                    echo "Force killing process $process_name"
                    kill -9 $pid
                fi
                
                rm -f "$pid_file"
                echo "Process $process_name stopped"
            else
                echo "Process $process_name is not running"
                rm -f "$pid_file"
            fi
        else
            echo "PID file not found for process $process_name"
        fi
    }
    
    # Function to check process status
    check_process_status() {
        local process_name=$1
        local pid_file="/tmp/${process_name}.pid"
        
        if [ -f "$pid_file" ]; then
            local pid=$(cat "$pid_file")
            
            if ps -p $pid > /dev/null 2>&1; then
                local mem_usage=$(ps -p $pid -o %mem --no-headers | xargs)
                local cpu_usage=$(ps -p $pid -o %cpu --no-headers | xargs)
                echo "Process $process_name (PID: $pid) is running - CPU: ${cpu_usage}%, MEM: ${mem_usage}%"
                return 0
            else
                echo "Process $process_name is not running (stale PID file)"
                rm -f "$pid_file"
                return 1
            fi
        else
            echo "Process $process_name is not running"
            return 1
        fi
    }
    
    # Demo the process management
    echo "Starting test process..."
    start_monitored_process "test_sleep" "sleep 30"
    
    echo ""
    echo "Checking status..."
    check_process_status "test_sleep"
    
    echo ""
    echo "Waiting 3 seconds..."
    sleep 3
    
    echo "Stopping process..."
    stop_monitored_process "test_sleep"
}

process_manager
```

---

## Signal Handling

Signals are messages sent to processes to notify them of events.

### Understanding Signals
```bash
#!/bin/bash

# Function to handle different signals
signal_demo() {
    echo "=== Signal Handling Demo ==="
    echo "Process ID: $"
    echo "Try pressing Ctrl+C or sending signals to this process"
    echo ""
    
    # Cleanup function
    cleanup() {
        echo ""
        echo "Cleanup function called"
        echo "Performing cleanup tasks..."
        # Remove temporary files
        rm -f /tmp/signal_demo_*
        echo "Cleanup completed"
        exit 0
    }
    
    # Signal handlers
    handle_sigint() {
        echo ""
        echo "Received SIGINT (Ctrl+C)"
        echo "Initiating graceful shutdown..."
        cleanup
    }
    
    handle_sigterm() {
        echo ""
        echo "Received SIGTERM"
        echo "Termination requested..."
        cleanup
    }
    
    handle_sigusr1() {
        echo ""
        echo "Received SIGUSR1 - Custom signal 1"
        echo "Current time: $(date)"
        echo "Continuing operation..."
    }
    
    handle_sigusr2() {
        echo ""
        echo "Received SIGUSR2 - Custom signal 2"
        echo "Memory usage:"
        free -h | head -2
        echo "Continuing operation..."
    }
    
    # Set up signal traps
    trap handle_sigint SIGINT INT
    trap handle_sigterm SIGTERM TERM
    trap handle_sigusr1 SIGUSR1 USR1
    trap handle_sigusr2 SIGUSR2 USR2
    trap cleanup EXIT
    
    echo "Signal handlers set up:"
    echo "  SIGINT (Ctrl+C): Graceful shutdown"
    echo "  SIGTERM: Termination"
    echo "  SIGUSR1: Show timestamp"
    echo "  SIGUSR2: Show memory usage"
    echo ""
    echo "Commands to test from another terminal:"
    echo "  kill -USR1 $"
    echo "  kill -USR2 $"
    echo "  kill -TERM $"
    echo ""
    
    # Main loop
    counter=0
    while true; do
        echo "Working... iteration $counter (PID: $)"
        
        # Create temporary file to show cleanup works
        echo "Temporary data $counter" > "/tmp/signal_demo_$counter"
        
        sleep 2
        ((counter++))
        
        # Auto-exit after 30 iterations for demo
        if [ $counter -ge 30 ]; then
            echo "Demo time limit reached"
            break
        fi
    done
}

# Advanced signal handling example
advanced_signal_handling() {
    echo ""
    echo "=== Advanced Signal Handling ==="
    
    # Global variables for signal communication
    RELOAD_CONFIG=false
    SHUTDOWN_REQUESTED=false
    
    # Configuration reload handler
    reload_config() {
        echo "Configuration reload requested"
        RELOAD_CONFIG=true
    }
    
    # Graceful shutdown handler
    graceful_shutdown() {
        echo "Graceful shutdown requested"
        SHUTDOWN_REQUESTED=true
    }
    
    # Set up signal handlers
    trap reload_config SIGHUP HUP
    trap graceful_shutdown SIGTERM TERM SIGINT INT
    
    echo "Advanced signal handling active:"
    echo "  SIGHUP: Reload configuration"
    echo "  SIGTERM/SIGINT: Graceful shutdown"
    echo ""
    echo "Test commands:"
    echo "  kill -HUP $"
    echo "  kill -TERM $"
    echo ""
    
    # Simulate application with configuration
    config_version=1
    
    while ! $SHUTDOWN_REQUESTED; do
        # Check for configuration reload
        if $RELOAD_CONFIG; then
            echo "Reloading configuration..."
            ((config_version++))
            echo "Configuration reloaded (version: $config_version)"
            RELOAD_CONFIG=false
        fi
        
        # Do main work
        echo "Application running (config v$config_version)..."
        sleep 3
    done
    
    echo "Shutting down gracefully..."
    echo "Finalizing operations..."
    sleep 1
    echo "Shutdown complete"
}

# Choose which demo to run
if [ "$1" = "advanced" ]; then
    advanced_signal_handling
else
    signal_demo
fi
```

---

## Error Handling

Robust error handling makes scripts more reliable and easier to debug.

### Basic Error Handling
```bash
#!/bin/bash

echo "=== Basic Error Handling ==="

# Enable strict error handling
set -e  # Exit on any error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# Function to handle errors
error_handler() {
    local exit_code=$?
    local line_number=$1
    
    echo "Error occurred in script at line $line_number"
    echo "Exit code: $exit_code"
    echo "Last command: $BASH_COMMAND"
    
    # Log error details
    echo "$(date): Error at line $line_number, exit code $exit_code" >> error.log
    
    # Cleanup on error
    cleanup_on_error
    
    exit $exit_code
}

# Cleanup function
cleanup_on_error() {
    echo "Performing error cleanup..."
    # Remove temporary files
    rm -f /tmp/demo_*
    # Kill background processes
    jobs -p | xargs -r kill
}

# Set error trap
trap 'error_handler $LINENO' ERR

# Demonstration of error handling
echo "Testing error handling..."

# This will work
echo "Step 1: Creating test file..."
echo "test content" > /tmp/demo_file.txt

# This will also work
echo "Step 2: Reading test file..."
cat /tmp/demo_file.txt

# Uncomment the next line to test error handling
# cat /nonexistent/file.txt  # This would trigger error handler

echo "All steps completed successfully"

# Cleanup
rm -f /tmp/demo_file.txt
```

### Advanced Error Handling
```bash
#!/bin/bash

# Advanced error handling with recovery mechanisms
advanced_error_handling() {
    echo "=== Advanced Error Handling ==="
    
    # Error codes
    readonly ERR_FILE_NOT_FOUND=2
    readonly ERR_PERMISSION_DENIED=3
    readonly ERR_NETWORK_ERROR=4
    readonly ERR_INVALID_INPUT=5
    
    # Logging function
    log_message() {
        local level=$1
        local message=$2
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        
        echo "[$timestamp] [$level] $message" | tee -a script.log
    }
    
    # Safe file operations
    safe_file_read() {
        local filename=$1
        local max_retries=${2:-3}
        local retry_delay=${3:-1}
        
        for ((attempt=1; attempt<=max_retries; attempt++)); do
            if [ -f "$filename" ]; then
                if [ -r "$filename" ]; then
                    cat "$filename"
                    return 0
                else
                    log_message "ERROR" "Permission denied reading $filename"
                    return $ERR_PERMISSION_DENIED
                fi
            else
                log_message "WARNING" "File $filename not found (attempt $attempt/$max_retries)"
                if [ $attempt -lt $max_retries ]; then
                    sleep $retry_delay
                fi
            fi
        done
        
        log_message "ERROR" "File $filename not found after $max_retries attempts"
        return $ERR_FILE_NOT_FOUND
    }
    
    # Network operation with retry
    safe_network_operation() {
        local url=$1
        local max_retries=${2:-3}
        local retry_delay=${3:-2}
        
        for ((attempt=1; attempt<=max_retries; attempt++)); do
            log_message "INFO" "Attempting network operation (attempt $attempt/$max_retries)"
            
            if ping -c 1 google.com > /dev/null 2>&1; then
                log_message "INFO" "Network operation successful"
                return 0
            else
                log_message "WARNING" "Network operation failed (attempt $attempt/$max_retries)"
                if [ $attempt -lt $max_retries ]; then
                    sleep $retry_delay
                fi
            fi
        done
        
        log_message "ERROR" "Network operation failed after $max_retries attempts"
        return $ERR_NETWORK_ERROR
    }
    
    # Input validation
    validate_input() {
        local input=$1
        local type=$2
        
        case $type in
            "number")
                if [[ $input =~ ^[0-9]+$ ]]; then
                    return 0
                else
                    log_message "ERROR" "Invalid number: $input"
                    return $ERR_INVALID_INPUT
                fi
                ;;
            "email")
                if [[ $input =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                    return 0
                else
                    log_message "ERROR" "Invalid email: $input"
                    return $ERR_INVALID_INPUT
                fi
                ;;
            *)
                log_message "ERROR" "Unknown validation type: $type"
                return $ERR_INVALID_INPUT
                ;;
        esac
    }
    
    # Error recovery demonstration
    error_recovery_demo() {
        echo "Testing error recovery mechanisms..."
        
        # Create test scenarios
        echo "Test content" > /tmp/test_file.txt
        
        # Test 1: Successful file read
        echo ""
        echo "Test 1: Reading existing file"
        if safe_file_read "/tmp/test_file.txt"; then
            echo "✓ File read successful"
        else
            echo "✗ File read failed with code: $?"
        fi
        
        # Test 2: File not found with retry
        echo ""
        echo "Test 2: Reading non-existent file (with retries)"
        if safe_file_read "/tmp/nonexistent.txt" 2 1; then
            echo "✓ File read successful"
        else
            local exit_code=$?
            echo "✗ File read failed with code: $exit_code"
            case $exit_code in
                $ERR_FILE_NOT_FOUND)
                    echo "  -> Attempting to create the file..."
                    echo "Recovery content" > /tmp/nonexistent.txt
                    echo "  -> File created, retrying..."
                    if safe_file_read "/tmp/nonexistent.txt"; then
                        echo "  -> Recovery successful!"
                    fi
                    ;;
            esac
        fi
        
        # Test 3: Input validation
        echo ""
        echo "Test 3: Input validation"
        test_inputs=("123" "abc" "user@example.com" "invalid.email")
        
        for input in "${test_inputs[@]}"; do
            echo "Validating '$input' as number:"
            if validate_input "$input" "number"; then
                echo "  ✓ Valid number"
            else
                echo "  ✗ Invalid number (exit code: $?)"
            fi
            
            echo "Validating '$input' as email:"
            if validate_input "$input" "email"; then
                echo "  ✓ Valid email"
            else
                echo "  ✗ Invalid email (exit code: $?)"
            fi
            echo ""
        done
        
        # Cleanup
        rm -f /tmp/test_file.txt /tmp/nonexistent.txt
    }
    
    error_recovery_demo
}

# Try-catch equivalent in bash
try_catch_demo() {
    echo ""
    echo "=== Try-Catch Pattern Demo ==="
    
    # Try-catch function
    try() {
        # Save current error handling state
        local old_errexit=$(set +o | grep errexit)
        local old_errtrace=$(set +o | grep errtrace)
        
        # Disable automatic exit on error
        set +e
        
        # Execute the command
        "$@"
        local exit_code=$?
        
        # Restore error handling state
        eval "$old_errexit"
        eval "$old_errtrace"
        
        return $exit_code
    }
    
    catch() {
        local exit_code=$?
        echo "Caught error with exit code: $exit_code"
        return $exit_code
    }
    
    # Demo try-catch usage
    echo "Attempting risky operation..."
    
    if try ls /nonexistent/directory; then
        echo "Operation succeeded"
    else
        catch
        echo "Recovered from error, continuing with alternative action..."
        echo "Using current directory instead:"
        ls . | head -3
    fi
    
    echo ""
    echo "Attempting another risky operation..."
    
    if try grep "nonexistent pattern" /dev/null; then
        echo "Pattern found"
    else
        catch
        echo "Pattern not found, using default behavior"
    fi
}

# Choose which demo to run based on argument
case "${1:-basic}" in
    "advanced")
        advanced_error_handling
        ;;
    "try-catch")
        try_catch_demo
        ;;
    *)
        echo "Basic error handling demo completed"
        try_catch_demo
        ;;
esac
```

---

## Debugging Scripts

Tools and techniques for debugging shell scripts.

### Debug Mode and Tracing
```bash
#!/bin/bash

echo "=== Script Debugging Techniques ==="

# Function to demonstrate debug modes
debug_demo() {
    echo "Various debug modes available:"
    echo "  -x : Show commands as they execute"
    echo "  -v : Show script lines as they are read"
    echo "  -e : Exit immediately on error"
    echo "  -u : Exit on undefined variable"
    echo ""
    
    # Enable debug mode for a section
    echo "Enabling debug mode (-x):"
    set -x
    
    name="Alice"
    age=30
    echo "Hello, $name! You are $age years old."
    
    # Disable debug mode
    set +x
    
    echo "Debug mode disabled"
    echo ""
    
    # Verbose mode demo
    echo "Enabling verbose mode (-v) for next section:"
    set -v
    
    # These lines will be shown as they're read
    city="New York"
    country="USA"
    echo "$name lives in $city, $country"
    
    set +v
    echo "Verbose mode disabled"
}

# Custom debug function
debug_print() {
    if [ "${DEBUG:-false}" = "true" ]; then
        echo "[DEBUG $(date '+%H:%M:%S')] $*" >&2
    fi
}

# Function with debug output
process_data() {
    local data=$1
    
    debug_print "Starting process_data with input: $data"
    
    # Simulate processing
    debug_print "Validating input..."
    if [ -z "$data" ]; then
        debug_print "ERROR: Empty input received"
        return 1
    fi
    
    debug_print "Processing step 1..."
    local processed="${data^^}"  # Convert to uppercase
    
    debug_print "Processing step 2..."
    processed="${processed// /_}"  # Replace spaces with underscores
    
    debug_print "Processing complete. Result: $processed"
    echo "$processed"
}

# Variable tracking function
track_variables() {
    echo ""
    echo "=== Variable Tracking Demo ==="
    
    # Function to show current variable state
    show_vars() {
        echo "Current variables:"
        echo "  counter = ${counter:-undefined}"
        echo "  result = ${result:-undefined}"
        echo "  status = ${status:-undefined}"
    }
    
    echo "Initial state:"
    show_vars
    
    echo ""
    echo "Setting variables..."
    counter=0
    result=""
    status="starting"
    show_vars
    
    echo ""
    echo "Processing loop:"
    for i in {1..3}; do
        ((counter++))
        result="${result}item${i} "
        status="processing"
        echo "  Iteration $i:"
        show_vars
    done
    
    echo ""
    echo "Final state:"
    status="completed"
    show_vars
}

# Execution flow tracking
execution_flow_demo() {
    echo ""
    echo "=== Execution Flow Tracking ==="
    
    # Function entry/exit tracking
    trace_function() {
        local func_name=$1
        echo "[TRACE] Entering function: $func_name" >&2
    }
    
    exit_function() {
        local func_name=$1
        local exit_code=${2:-0}
        echo "[TRACE] Exiting function: $func_name (exit code: $exit_code)" >&2
    }
    
    # Example function with tracing
    calculate_sum() {
        trace_function "calculate_sum"
        
        local num1=$1
        local num2=$2
        
        if [ -z "$num1" ] || [ -z "$num2" ]; then
            echo "[ERROR] Missing parameters" >&2
            exit_function "calculate_sum" 1
            return 1
        fi
        
        local sum=$((num1 + num2))
        echo "$sum"
        
        exit_function "calculate_sum" 0
        return 0
    }
    
    # Test the traced function
    echo "Calling calculate_sum 10 20:"
    result=$(calculate_sum 10 20)
    echo "Result: $result"
    
    echo ""
    echo "Calling calculate_sum with missing parameter:"
    result=$(calculate_sum 10)
    echo "Result: $result"
}

# Performance debugging
performance_debug() {
    echo ""
    echo "=== Performance Debugging ==="
    
    # Time measurement function
    time_operation() {
        local operation_name=$1
        shift
        
        local start_time=$(date +%s.%N)
        
        # Execute the operation
        "$@"
        local exit_code=$?
        
        local end_time=$(date +%s.%N)
        local duration=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "calculation unavailable")
        
        if [ "$duration" != "calculation unavailable" ]; then
            printf "[PERF] %s took %.3f seconds\n" "$operation_name" "$duration" >&2
        else
            echo "[PERF] $operation_name completed (timing unavailable)" >&2
        fi
        
        return $exit_code
    }
    
    # Slow operation for testing
    slow_operation() {
        local duration=${1:-1}
        sleep "$duration"
        echo "Operation completed"
    }
    
    # Fast operation for testing
    fast_operation() {
        echo "Quick operation"
    }
    
    # Test performance measurement
    time_operation "Fast Operation" fast_operation
    time_operation "Slow Operation (1s)" slow_operation 1
    time_operation "Slow Operation (2s)" slow_operation 2
}

# Interactive debugging
interactive_debug() {
    echo ""
    echo "=== Interactive Debugging ==="
    
    # Breakpoint function
    breakpoint() {
        local line=$1
        local context=${2:-"Debug breakpoint"}
        
        echo ""
        echo "=== BREAKPOINT at line $line ==="
        echo "Context: $context"
        echo "Current variables:"
        set | grep '^[a-zA-Z_][a-zA-Z0-9_]*=' | head -10
        echo ""
        echo "Commands: (c)ontinue, (q)uit, (v)ariables, (h)elp"
        
        while true; do
            read -p "debug> " cmd
            case $cmd in
                c|continue)
                    echo "Continuing execution..."
                    break
                    ;;
                q|quit)
                    echo "Quitting..."
                    exit 0
                    ;;
                v|variables)
                    echo "All variables:"
                    set | grep '^[a-zA-Z_][a-zA-Z0-9_]*='
                    ;;
                h|help)
                    echo "Available commands:"
                    echo "  c, continue - Continue execution"
                    echo "  q, quit     - Exit script"
                    echo "  v, variables - Show all variables"
                    echo "  h, help     - Show this help"
                    ;;
                *)
                    echo "Unknown command: $cmd (use 'h' for help)"
                    ;;
            esac
        done
    }
    
    # Demo interactive debugging
    echo "Interactive debugging demo"
    debug_var="test_value"
    counter=0
    
    for i in {1..3}; do
        counter=$((counter + 1))
        echo "Loop iteration $i, counter = $counter"
        
        if [ $i -eq 2 ]; then
            breakpoint $LINENO "Loop iteration $i"
        fi
    done
    
    echo "Interactive debugging demo completed"
}

# Run demonstrations based on DEBUG environment variable
if [ "${DEBUG:-false}" = "true" ]; then
    echo "DEBUG mode enabled"
fi

debug_demo
echo ""

# Test debug output
echo "Testing debug output (set DEBUG=true to see debug messages):"
process_data "Hello World"
process_data ""

track_variables
execution_flow_demo

if command -v bc >/dev/null 2>&1; then
    performance_debug
else
    echo ""
    echo "Note: 'bc' not available, skipping performance debugging"
fi

# Uncomment the next line to test interactive debugging
# interactive_debug

echo ""
echo "Debugging demonstrations completed!"
echo "Tip: Run with 'DEBUG=true' to see debug messages"
echo "     Run with 'bash -x' to see command execution"
```

---

## Performance Optimization

Techniques to make your scripts faster and more efficient.

### Performance Best Practices
```bash
#!/bin/bash

echo "=== Shell Script Performance Optimization ==="

# Inefficient vs Efficient examples
performance_comparison() {
    echo "=== Performance Comparison Examples ==="
    
    # Create test data
    echo "Creating test data..."
    for i in {1..1000}; do
        echo "line $i: some test data with numbers $((i*2))" >> test_data.txt
    done
    
    # Timing function (simplified version)
    time_it() {
        local operation_name=$1
        shift
        echo "Timing: $operation_name"
        time "$@"
        echo ""
    }
    
    # INEFFICIENT: Using cat in a loop
    inefficient_cat() {
        local count=0
        while [ $count -lt 100 ]; do
            cat test_data.txt > /dev/null
            ((count++))
        done
    }
    
    # EFFICIENT: Process file once
    efficient_processing() {
        local count=0
        while [ $count -lt 100 ]; do
            < test_data.txt
            ((count++))
        done
    }
    
    echo "Inefficient approach (cat in loop):"
    time inefficient_cat
    
    echo ""
    echo "More efficient approach:"
    time efficient_processing
    
    # String processing comparison
    echo ""
    echo "=== String Processing Comparison ==="
    
    # INEFFICIENT: Multiple string operations
    inefficient_string() {
        local text="Hello World This Is A Test String"
        local result=""
        
        for word in $text; do
            result="$result$(echo $word | tr '[:lower:]' '[:upper:]') "
        done
        
        echo "$result"
    }
    
    # EFFICIENT: Single operation
    efficient_string() {
        local text="Hello World This Is A Test String"
        echo "${text^^}"  # Bash 4.0+ feature
    }
    
    echo "Inefficient string processing:"
    time inefficient_string
    
    echo ""
    echo "Efficient string processing:"
    time efficient_string
    
    # Cleanup
    rm -f test_data.txt
}

# Memory optimization techniques
memory_optimization() {
    echo ""
    echo "=== Memory Optimization Techniques ==="
    
    # BAD: Loading entire file into variable
    memory_heavy_approach() {
        echo "Memory-heavy approach (loading entire file):"
        
        # Create large test file
        for i in {1..1000}; do
            echo "This is line $i with some content to make it longer" >> large_file.txt
        done
        
        # Load entire file (memory intensive)
        local file_content=$(cat large_file.txt)
        local line_count=$(echo "$file_content" | wc -l)
        
        echo "Processed $line_count lines (file loaded into memory)"
        
        # Cleanup
        rm -f large_file.txt
    }
    
    # GOOD: Process file line by line
    memory_efficient_approach() {
        echo "Memory-efficient approach (streaming):"
        
        # Create large test file
        for i in {1..1000}; do
            echo "This is line $i with some content to make it longer" >> large_file.txt
        done
        
        # Process line by line (memory efficient)
        local line_count=0
        while IFS= read -r line; do
            # Process line here (we're just counting)
            ((line_count++))
        done < large_file.txt
        
        echo "Processed $line_count lines (streaming)"
        
        # Cleanup
        rm -f large_file.txt
    }
    
    memory_heavy_approach
    echo ""
    memory_efficient_approach
}

# Loop optimization
loop_optimization() {
    echo ""
    echo "=== Loop Optimization ==="
    
    # INEFFICIENT: Command substitution in loop
    inefficient_loop() {
        echo "Inefficient loop (command substitution inside):"
        local start_time=$(date +%s)
        
        for i in {1..100}; do
            local current_time=$(date +%s)  # BAD: Command substitution in loop
            local diff=$((current_time - start_time))
            if [ $diff -gt 1 ]; then
                break
            fi
        done
        
        echo "Loop completed"
    }
    
    # EFFICIENT: Minimize command substitution
    efficient_loop() {
        echo "Efficient loop (minimal command substitution):"
        local start_time=$(date +%s)
        local current_time=$start_time
        
        for i in {1..100}; do
            # Only update time occasionally
            if [ $((i % 10)) -eq 0 ]; then
                current_time=$(date +%s)
            fi
            
            local diff=$((current_time - start_time))
            if [ $diff -gt 1 ]; then
                break
            fi
        done
        
        echo "Loop completed"
    }
    
    time inefficient_loop
    echo ""
    time efficient_loop
}

# Built-in vs external command optimization
builtin_vs_external() {
    echo ""
    echo "=== Built-in vs External Commands ==="
    
    # Using external commands (slower)
    external_commands() {
        local text="Hello World Test"
        
        # Using external commands
        local length=$(echo "$text" | wc -c)
        local upper=$(echo "$text" | tr '[:lower:]' '[:upper:]')
        local word_count=$(echo "$text" | wc -w)
        
        echo "External commands - Length: $length, Words: $word_count, Upper: $upper"
    }
    
    # Using bash built-ins (faster)
    builtin_commands() {
        local text="Hello World Test"
        
        # Using bash built-ins
        local length=${#text}
        local upper=${text^^}
        local words=($text)
        local word_count=${#words[@]}
        
        echo "Built-in commands - Length: $length, Words: $word_count, Upper: $upper"
    }
    
    echo "Using external commands:"
    time external_commands
    
    echo ""
    echo "Using bash built-ins:"
    time builtin_commands
}

# Parallel processing example
parallel_processing() {
    echo ""
    echo "=== Parallel Processing ==="
    
    # Sequential processing
    sequential_processing() {
        echo "Sequential processing:"
        local start_time=$(date +%s)
        
        for i in {1..5}; do
            echo "Processing task $i..."
            sleep 1  # Simulate work
            echo "Task $i completed"
        done
        
        local end_time=$(date +%s)
        echo "Sequential processing took $((end_time - start_time)) seconds"
    }
    
    # Parallel processing
    parallel_processing_demo() {
        echo "Parallel processing:"
        local start_time=$(date +%s)
        
        # Start all tasks in parallel
        for i in {1..5}; do
            (
                echo "Processing task $i..."
                sleep 1  # Simulate work
                echo "Task $i completed"
            ) &
        done
        
        # Wait for all background jobs to complete
        wait
        
        local end_time=$(date +%s)
        echo "Parallel processing took $((end_time - start_time)) seconds"
    }
    
    sequential_processing
    echo ""
    parallel_processing_demo
}

# Caching techniques
caching_demo() {
    echo ""
    echo "=== Caching Techniques ==="
    
    # Expensive operation simulation
---

## Final Summary and Quick Reference

### Essential Commands Quick Reference

```bash
# File Operations
ls -la                    # List files with details
cp source dest           # Copy files
mv old new              # Move/rename files
rm file                 # Remove files
mkdir dir               # Create directory
rmdir dir               # Remove empty directory
find /path -name "*.txt" # Find files
chmod 755 file          # Change permissions

# Text Processing
grep "pattern" file     # Search in files
sed 's/old/new/g' file  # Replace text
awk '{print $1}' file   # Print first column
sort file               # Sort lines
uniq file               # Remove duplicates
wc -l file              # Count lines

# Variables and Special Characters
variable="value"        # Set variable
echo "$variable"        # Use variable
${#variable}           # Variable length
${variable:-default}   # Default value
$0, $1, $2...          # Script arguments
$#                     # Number of arguments
$@                     # All arguments
$                     # Process ID
$?                     # Exit status

# Control Structures
if [ condition ]; then
    commands
elif [ condition ]; then
    commands
else
    commands
fi

for item in list; do
    commands
done

while [ condition ]; do
    commands
done

case $variable in
    pattern1) commands ;;
    pattern2) commands ;;
    *) default commands ;;
esac

# Functions
function_name() {
    local var=$1
    commands
    return 0
}
```

### Common Patterns and Idioms

```bash
# Check if file exists
if [ -f "$filename" ]; then
    echo "File exists"
fi

# Process all files in directory
for file in /path/to/dir/*; do
    if [ -f "$file" ]; then
        echo "Processing $file"
    fi
done

# Read file line by line
while IFS= read -r line; do
    echo "Line: $line"
done < "$filename"

# Error handling
command || {
    echo "Command failed"
    exit 1
}

# Logging with timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*"
}

# Safe temporary files
temp_file=$(mktemp)
trap "rm -f '$temp_file'" EXIT

# Check command exists
if command -v git >/dev/null 2>&1; then
    echo "Git is available"
fi
```

### Testing and Debugging Checklist

- [ ] Use `bash -n script.sh` to check syntax
- [ ] Use `bash -x script.sh` to trace execution
- [ ] Use ShellCheck for static analysis
- [ ] Test with different inputs and edge cases
- [ ] Test error conditions and cleanup
- [ ] Verify file permissions and access
- [ ] Check for proper quoting of variables
- [ ] Validate exit codes and error handling
- [ ] Test on different systems if needed
- [ ] Document usage and examples

### Security Checklist

- [ ] Quote all variables: `"$variable"`
- [ ] Validate all user inputs
- [ ] Use absolute paths where possible
- [ ] Check file permissions before operations
- [ ] Use `mktemp` for temporary files
- [ ] Never use `eval` with untrusted input
- [ ] Set restrictive umask if needed
- [ ] Clean up temporary resources
- [ ] Log security-relevant operations
- [ ] Consider running with minimal privileges

---

## Conclusion

You've now completed a comprehensive journey from shell scripting beginner to advanced practitioner. This guide has covered:

### ✅ What You've Learned

**Foundation Skills:**
- Shell basics and script creation
- Variables, data types, and special parameters
- Input/output handling and user interaction
- Command-line argument processing

**Control Flow:**
- Conditional statements (if/else, case)
- All types of loops (for, while, until)
- Loop control (break, continue)
- Decision-making logic

**Advanced Concepts:**
- Functions and parameter passing
- Arrays and associative arrays
- File and directory operations
- Text processing with grep, sed, awk
- Regular expressions and pattern matching

**Professional Practices:**
- Error handling and debugging techniques
- Process management and signal handling
- Performance optimization
- Security considerations
- Best practices and code organization

**Real-World Applications:**
- System administration scripts
- Automation and deployment tools
- Monitoring and maintenance utilities
- Development environment setup

### 🎯 Your Next Steps

1. **Practice Regularly**: The key to mastering shell scripting is consistent practice
2. **Build Real Projects**: Apply your knowledge to solve actual problems
3. **Join Communities**: Learn from others and share your experiences
4. **Stay Updated**: Keep learning about new tools and techniques
5. **Teach Others**: Sharing knowledge reinforces your own understanding

### 🚀 Remember

- **Start Simple**: Begin with small scripts and gradually increase complexity
- **Test Thoroughly**: Always test your scripts with various inputs and scenarios
- **Document Well**: Good documentation makes scripts maintainable
- **Security First**: Always consider security implications
- **Keep Learning**: Technology evolves, and so should your skills

### 📚 Final Words

Shell scripting is a powerful skill that will serve you throughout your career in technology. Whether you're a system administrator, developer, DevOps engineer, or simply someone who wants to automate repetitive tasks, the knowledge you've gained here will prove invaluable.

The shell is more than just a command-line interface—it's a programming environment that connects you directly to the power of Unix-like systems. With great power comes great responsibility, so always use these skills ethically and responsibly.

**Keep scripting, keep learning, and most importantly, keep solving problems!**

---

*Happy Scripting! 🐚💻✨*

---

> **"The best way to learn shell scripting is by doing. Start with simple tasks, build upon your successes, learn from your mistakes, and before you know it, you'll be automating complex workflows with confidence."**

---

## Appendix: Useful Resources

### Online Tools
- [ShellCheck](https://www.shellcheck.net/) - Script analysis
- [Explain Shell](https://explainshell.com/) - Command explanation
- [Regex101](https://regex101.com/) - Regular expression testing
- [Bash Manual](https://www.gnu.org/software/bash/manual/)

### Commands for Learning
- `man bash` - Bash manual
- `help [command]` - Built-in help
- `type [command]` - Command information
- `which [command]` - Command location

### Practice Environments
- Local Linux/macOS terminal
- Windows Subsystem for Linux (WSL)
- Online terminals (repl.it, etc.)
- Virtual machines

---

**End of Complete Shell Scripting Guide**    local backup_file="$backup_dir/${filename}.backup.${timestamp}"
    
    # Perform backup
    if cp "$source_file" "$backup_file"; then
        log "INFO" "Backup created: $backup_file"
        return 0
    else
        log "ERROR" "Failed to create backup"
        return 1
    fi
}

#======================================================================
# Help and Usage Functions
#======================================================================

# Display usage information
usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS] [ARGUMENTS]

DESCRIPTION:
    Demonstrates shell scripting best practices with proper error handling,
    logging, configuration management, and code organization.

OPTIONS:
    -h, --help          Show this help message and exit
    -v, --verbose       Enable verbose output
    -d, --debug         Enable debug output
    -n, --dry-run       Show what would be done without executing
    -c, --config FILE   Use specified configuration file
    -l, --log FILE      Use specified log file
    --version           Show version information

ARGUMENTS:
    INPUT_FILE          Input file to process
    OUTPUT_FILE         Output file for results

EXAMPLES:
    $SCRIPT_NAME --help
    $SCRIPT_NAME --verbose input.txt output.txt
    $SCRIPT_NAME --config myconfig.ini --debug input.txt output.txt

EXIT CODES:
    0   Success
    1   General error
    2   Misuse of shell command
    126 Command invoked cannot execute
    127 Command not found

For more information, see the documentation or contact support.
EOF
}

# Display version information
version() {
    cat << EOF
$SCRIPT_NAME version $SCRIPT_VERSION

This script demonstrates best practices for shell scripting including:
- Proper error handling and logging
- Configuration management
- Input validation
- Code organization and documentation
- Signal handling and cleanup

Written for the Complete Shell Scripting Guide.
EOF
}

#======================================================================
# Command Line Argument Processing
#======================================================================

# Parse command line arguments
parse_arguments() {
    local input_file=""
    local output_file=""
    
    # Process options
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                exit $EXIT_SUCCESS
                ;;
            --version)
                version
                exit $EXIT_SUCCESS
                ;;
            -v|--verbose)
                VERBOSE=true
                log "DEBUG" "Verbose mode enabled"
                shift
                ;;
            -d|--debug)
                DEBUG=true
                log "DEBUG" "Debug mode enabled"
                shift
                ;;
            -n|--dry-run)
                DRY_RUN=true
                log "DEBUG" "Dry run mode enabled"
                shift
                ;;
            -c|--config)
                CONFIG_FILE="$2"
                if [[ -z "$CONFIG_FILE" ]]; then
                    error_exit "Configuration file not specified"
                fi
                shift 2
                ;;
            -l|--log)
                LOG_FILE="$2"
                if [[ -z "$LOG_FILE" ]]; then
                    error_exit "Log file not specified"
                fi
                shift 2
                ;;
            --)
                shift
                break
                ;;
            -*)
                error_exit "Unknown option: $1" $EXIT_MISUSE
                ;;
            *)
                # Positional arguments
                if [[ -z "$input_file" ]]; then
                    input_file="$1"
                elif [[ -z "$output_file" ]]; then
                    output_file="$1"
                else
                    error_exit "Too many arguments" $EXIT_MISUSE
                fi
                shift
                ;;
        esac
    done
    
    # Store parsed arguments in global variables
    INPUT_FILE="$input_file"
    OUTPUT_FILE="$output_file"
    
    log "DEBUG" "Arguments parsed: input=$INPUT_FILE, output=$OUTPUT_FILE"
}

#======================================================================
# Main Execution Functions
#======================================================================

# Initialize script environment
initialize() {
    log "DEBUG" "Initializing script environment"
    
    # Set up signal handlers
    trap handle_interrupt INT
    trap handle_termination TERM
    trap cleanup EXIT
    
    # Validate dependencies
    validate_dependencies
    
    # Load configuration if it exists
    if [[ -f "$CONFIG_FILE" ]]; then
        load_config "$CONFIG_FILE"
    else
        log "DEBUG" "Configuration file not found, using defaults"
    fi
    
    # Create log directory if needed
    if [[ -n "$LOG_FILE" ]]; then
        mkdir -p "$(dirname "$LOG_FILE")"
    fi
    
    log "INFO" "Script initialization completed"
}

# Main application logic
main() {
    log "INFO" "$SCRIPT_NAME v$SCRIPT_VERSION starting"
    
    # Validate required arguments
    if [[ -z "$INPUT_FILE" ]] || [[ -z "$OUTPUT_FILE" ]]; then
        log "ERROR" "Both input and output files must be specified"
        usage >&2
        exit $EXIT_MISUSE
    fi
    
    # Show what we're doing
    log "INFO" "Input file: $INPUT_FILE"
    log "INFO" "Output file: $OUTPUT_FILE"
    log "INFO" "Dry run mode: $DRY_RUN"
    
    # Create test input file for demonstration
    if [[ ! -f "$INPUT_FILE" ]]; then
        log "INFO" "Creating test input file: $INPUT_FILE"
        cat > "$INPUT_FILE" << EOF
This is a test file
with multiple lines
for demonstration purposes
EOF
    fi
    
    if [[ "$DRY_RUN" == true ]]; then
        log "INFO" "DRY RUN: Would process $INPUT_FILE -> $OUTPUT_FILE"
        log "INFO" "DRY RUN: Would create backup of input file"
        log "INFO" "DRY RUN: Would validate processed output"
    else
        # Create backup of input file
        backup_file "$INPUT_FILE"
        
        # Process the data
        process_data "$INPUT_FILE" "$OUTPUT_FILE"
        
        # Validate output
        if [[ -f "$OUTPUT_FILE" ]]; then
            local line_count=$(wc -l < "$OUTPUT_FILE")
            log "INFO" "Processing completed: $line_count lines in output file"
        else
            error_exit "Output file was not created"
        fi
    fi
    
    log "INFO" "$SCRIPT_NAME completed successfully"
}

#======================================================================
# Script Entry Point
#======================================================================

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Parse command line arguments
    parse_arguments "$@"
    
    # Initialize script environment
    initialize
    
    # Run main application
    main
fi

#======================================================================
# Best Practices Summary
#======================================================================

: << 'BEST_PRACTICES_DOCUMENTATION'

=== SHELL SCRIPTING BEST PRACTICES SUMMARY ===

1. SCRIPT STRUCTURE:
   - Use clear, documented header with script metadata
   - Organize code into logical sections with comments
   - Define constants and global variables at the top
   - Use consistent function naming and organization

2. ERROR HANDLING:
   - Use 'set -e' for strict error handling (or handle errors explicitly)
   - Define meaningful exit codes
   - Implement proper cleanup functions
   - Use trap for signal handling

3. LOGGING AND DEBUGGING:
   - Implement comprehensive logging with levels
   - Support verbose and debug modes
   - Log to files and/or stderr appropriately
   - Include timestamps in log entries

4. INPUT VALIDATION:
   - Validate all user inputs and arguments
   - Check file existence and permissions
   - Validate data formats (email, IP, numbers, etc.)
   - Provide meaningful error messages

5. CONFIGURATION MANAGEMENT:
   - Support external configuration files
   - Provide sensible defaults
   - Allow command-line overrides
   - Document all configuration options

6. SECURITY CONSIDERATIONS:
   - Quote variables to prevent word splitting
   - Use absolute paths where possible
   - Validate inputs to prevent injection
   - Set appropriate file permissions

7. CODE QUALITY:
   - Use meaningful variable and function names
   - Add comments for complex logic
   - Follow consistent formatting
   - Use readonly for constants

8. PORTABILITY:
   - Use POSIX-compatible commands when possible
   - Check for required dependencies
   - Handle different operating system variations
   - Avoid bashisms if targeting multiple shells

9. TESTING AND MAINTENANCE:
   - Include usage examples and documentation
   - Support dry-run modes for testing
   - Implement comprehensive help messages
   - Version your scripts

10. PERFORMANCE:
    - Use built-in commands instead of external ones
    - Minimize subshell creation
    - Use arrays for batch operations
    - Consider parallel processing for independent tasks

BEST_PRACTICES_DOCUMENTATION

echo ""
echo "=== BEST PRACTICES DEMONSTRATION ==="
echo ""
echo "This script demonstrates comprehensive best practices including:"
echo "  ✓ Proper script structure and organization"
echo "  ✓ Comprehensive error handling and logging"
echo "  ✓ Configuration management"
echo "  ✓ Input validation and sanitization"
echo "  ✓ Command-line argument processing"
echo "  ✓ Signal handling and cleanup"
echo "  ✓ Documentation and help systems"
echo "  ✓ Security considerations"
echo "  ✓ Maintainable and readable code"
echo ""
echo "Try running this script with different options:"
echo "  $0 --help"
echo "  $0 --verbose input.txt output.txt"
echo "  $0 --debug --dry-run test.txt result.txt"
```

---

## Common Pitfalls

Avoiding common mistakes in shell scripting.

### Quoting and Variable Issues
```bash
#!/bin/bash

echo "=== COMMON PITFALLS AND HOW TO AVOID THEM ==="
echo ""

# Pitfall 1: Unquoted Variables
echo "1. UNQUOTED VARIABLES"
echo "====================="

dangerous_example() {
    echo "❌ WRONG WAY:"
    local filename="my file with spaces.txt"
    
    # This will fail because of spaces
    echo "Creating file..."
    # touch $filename  # DON'T DO THIS!
    echo "Command that would run: touch $filename"
    echo "This would create 4 separate files: 'my', 'file', 'with', 'spaces.txt'"
}

safe_example() {
    echo ""
    echo "✅ CORRECT WAY:"
    local filename="my file with spaces.txt"
    
    # Always quote variables
    touch "$filename"
    echo "Created file: $filename"
    ls -la "$filename"
    rm "$filename"  # Cleanup
}

dangerous_example
safe_example

echo ""
echo "LESSON: Always quote variables: \"\$variable\" not \$variable"
echo ""

# Pitfall 2: Word Splitting in Arrays
echo "2. ARRAY HANDLING"
echo "================="

array_pitfall_demo() {
    echo "❌ WRONG WAY:"
    local files=("file one.txt" "file two.txt" "file three.txt")
    
    echo "Files array contains:"
    for file in ${files[@]}; do  # WRONG - no quotes
        echo "  '$file'"
    done
    
    echo ""
    echo "✅ CORRECT WAY:"
    echo "Files array contains:"
    for file in "${files[@]}"; do  # CORRECT - quoted
        echo "  '$file'"
    done
}

array_pitfall_demo

echo ""
echo "LESSON: Always quote array expansions: \"\${array[@]}\" not \${array[@]}"
echo ""

# Pitfall 3: Command Substitution Issues
echo "3. COMMAND SUBSTITUTION"
echo "======================="

command_substitution_demo() {
    echo "❌ POTENTIALLY PROBLEMATIC:"
    # Using backticks (old style)
    local old_style=`date +%Y-%m-%d`
    echo "Date (backticks): $old_style"
    
    echo ""
    echo "✅ PREFERRED:"
    # Using $() (new style)
    local new_style=$(date +%Y-%m-%d)
    echo "Date (\$() syntax): $new_style"
    
    echo ""
    echo "❌ DANGEROUS (command injection risk):"
    local user_input="date; rm -rf /"  # Simulated malicious input
    echo "User input: $user_input"
    echo "If you ran: result=\$($user_input)"
    echo "This could execute: date; rm -rf /"
    
    echo ""
    echo "✅ SAFER:"
    echo "Always validate and sanitize input before using in command substitution"
}

command_substitution_demo

echo ""

# Pitfall 4: Test Condition Mistakes
echo "4. TEST CONDITIONS"
echo "=================="

test_condition_demo() {
    local empty_var=""
    local undefined_var
    local number_var="42"
    local string_var="hello"
    
    echo "Testing different variables:"
    echo "empty_var='$empty_var'"
    echo "undefined_var='${undefined_var:-undefined}'"
    echo "number_var='$number_var'"
    echo "string_var='$string_var'"
    echo ""
    
    echo "❌ COMMON MISTAKES:"
    
    # Mistake 1: Not quoting in tests
    echo "Unquoted variable test (can cause syntax errors):"
    if [ $empty_var = "" ]; then  # Can cause syntax error
        echo "  This might work but is dangerous"
    fi
    
    echo ""
    echo "✅ CORRECT APPROACHES:"
    
    # Correct way 1: Quote everything
    if [ "$empty_var" = "" ]; then
        echo "  ✓ Empty variable detected (quoted test)"
    fi
    
    # Correct way 2: Use -z for empty test
    if [ -z "$empty_var" ]; then
        echo "  ✓ Empty variable detected (-z test)"
    fi
    
    # Correct way 3: Use -n for non-empty test
    if [ -n "$string_var" ]; then
        echo "  ✓ Non-empty variable detected (-n test)"
    fi
    
    echo ""
    echo "Numeric comparisons:"
    echo "❌ WRONG: [ \$number_var > 30 ]  # String comparison!"
    if [ "$number_var" -gt 30 ]; then  # Numeric comparison
        echo "✅ CORRECT: [ \$number_var -gt 30 ]  # $number_var > 30"
    fi
}

test_condition_demo

echo ""

# Pitfall 5: Exit Code Confusion
echo "5. EXIT CODES AND PIPELINES"
echo "============================"

exit_code_demo() {
    echo "❌ COMMON MISTAKE:"
    echo "Not checking exit codes or understanding pipeline exit codes"
    
    # This might mask failures
    echo "Example pipeline that might hide errors:"
    echo "cat nonexistent.txt | grep 'pattern' | wc -l"
    
    local result=$(cat /nonexistent/file.txt 2>/dev/null | grep 'pattern' | wc -l)
    echo "Result: $result (but we don't know if cat failed)"
    
    echo ""
    echo "✅ BETTER APPROACHES:"
    
    # Method 1: Check each command
    echo "Method 1: Check intermediate results"
    local temp_file="/tmp/test_data"
    echo "test data with pattern" > "$temp_file"
    
    if cat "$temp_file" > /tmp/cat_output; then
        if grep 'pattern' /tmp/cat_output > /tmp/grep_output; then
            local count=$(wc -l < /tmp/grep_output)
            echo "Found $count matches"
        else
            echo "No pattern found"
        fi
    else
        echo "Failed to read file"
    fi
    
    # Method 2: Use set -o pipefail
    echo ""
    echo "Method 2: Use 'set -o pipefail'"
    set -o pipefail
    local pipeline_result=$(cat "$temp_file" | grep 'pattern' | wc -l)
    if [ $? -eq 0 ]; then
        echo "Pipeline succeeded: $pipeline_result matches"
    else
        echo "Pipeline failed"
    fi
    set +o pipefail
    
    # Cleanup
    rm -f "$temp_file" /tmp/cat_output /tmp/grep_output
}

exit_code_demo

echo ""

# Pitfall 6: Loop and Subshell Issues
echo "6. LOOPS AND SUBSHELLS"
echo "======================="

loop_pitfall_demo() {
    echo "❌ COMMON MISTAKE: Variable changes in subshell don't persist"
    
    local counter=0
    echo "Initial counter: $counter"
    
    # This creates a subshell - counter changes won't persist
    echo "one two three" | while read -r word; do
        echo "Processing: $word"
        ((counter++))
        echo "Counter in loop: $counter"
    done
    
    echo "Counter after loop: $counter (unchanged!)"
    
    echo ""
    echo "✅ CORRECT APPROACHES:"
    
    # Method 1: Use process substitution
    counter=0
    while read -r word; do
        echo "Processing: $word"
        ((counter++))
    done < <(echo "one two three" | tr ' ' '\n')
    echo "Counter after process substitution: $counter"
    
    # Method 2: Use array
    counter=0
    local words=(one two three)
    for word in "${words[@]}"; do
        echo "Processing: $word"
        ((counter++))
    done
    echo "Counter after array loop: $counter"
}

loop_pitfall_demo

echo ""

# Pitfall 7: File and Directory Operations
echo "7. FILE AND DIRECTORY OPERATIONS"
echo "================================="

file_operations_demo() {
    echo "❌ COMMON MISTAKES:"
    
    # Mistake 1: Not checking if file exists
    echo "Not checking if file exists before operations"
    
    # Mistake 2: Race conditions
    echo "Race conditions between checking and using files"
    
    # Mistake 3: Not handling special characters
    echo "Not handling files with special characters"
    
    echo ""
    echo "✅ BETTER PRACTICES:"
    
    local test_file="test file with spaces & special chars!.txt"
    
    # Create test file
    echo "test content" > "$test_file"
    
    # Safe file operations
    if [ -f "$test_file" ]; then
        echo "✓ File exists: '$test_file'"
        
        # Safe reading
        if [ -r "$test_file" ]; then
            local content=$(cat "$test_file")
            echo "✓ Content: '$content'"
        else
            echo "✗ Cannot read file"
        fi
        
        # Safe removal
        if rm "$test_file"; then
            echo "✓ File removed successfully"
        else
            echo "✗ Failed to remove file"
        fi
    else
        echo "✗ File does not exist"
    fi
    
    echo ""
    echo "Directory operations:"
    local test_dir="test directory with spaces"
    
    if mkdir -p "$test_dir"; then
        echo "✓ Directory created: '$test_dir'"
        
        if rmdir "$test_dir"; then
            echo "✓ Directory removed successfully"
        fi
    fi
}

file_operations_demo

echo ""

# Pitfall 8: Security Issues
echo "8. SECURITY PITFALLS"
echo "====================="

security_demo() {
    echo "❌ SECURITY MISTAKES:"
    echo ""
    
    echo "1. Using eval with untrusted input"
    echo "   eval \"\$user_input\"  # DANGEROUS!"
    echo ""
    
    echo "2. Not validating file paths"
    echo "   cat \"\$user_provided_path\"  # Could access any file!"
    echo ""
    
    echo "3. Temporary file race conditions"
    echo "   tmp_file=/tmp/script.\$\$  # Predictable name"
    echo ""
    
    echo "✅ SECURITY BEST PRACTICES:"
    echo ""
    
    echo "1. Validate all inputs"
    validate_path() {
        local path=$1
        local base_dir="/safe/directory"
        
        # Resolve path and check if it's within safe directory
        local resolved_path=$(realpath "$path" 2>/dev/null || echo "")
        
        if [[ "$resolved_path" == "$base_dir"* ]]; then
            echo "✓ Path is safe: $resolved_path"
            return 0
        else
            echo "✗ Path is unsafe: $path"
            return 1
        fi
    }
    
    echo "Example: validate_path '../../../etc/passwd'"
    validate_path "../../../etc/passwd"
    
    echo ""
    echo "2. Use secure temporary files"
    local secure_temp=$(mktemp)
    echo "✓ Secure temporary file: $secure_temp"
    rm "$secure_temp"
    
    echo ""
    echo "3. Set restrictive permissions"
    local sensitive_file="sensitive.txt"
    echo "sensitive data" > "$sensitive_file"
    chmod 600 "$sensitive_file"  # Only owner can read/write
    echo "✓ Set restrictive permissions (600) on $sensitive_file"
    ls -la "$sensitive_file"
    rm "$sensitive_file"
}

security_demo

echo ""
echo "=== PITFALL AVOIDANCE CHECKLIST ==="
echo ""
echo "Before running your scripts, check:"
echo "  □ All variables are quoted: \"\$variable\""
echo "  □ Arrays use quoted expansion: \"\${array[@]}\""
echo "  □ Test conditions are properly quoted"
echo "  □ Exit codes are checked"
echo "  □ File operations are safe"
echo "  □ Input is validated"
echo "  □ No eval with untrusted input"
echo "  □ Temporary files are secure"
echo "  □ Error handling is comprehensive"
echo "  □ Script has been tested with various inputs"
echo ""
echo "Remember: It's better to be overly cautious than to have a script fail in production!"
```

---

## Next Steps

Congratulations on completing the comprehensive shell scripting guide! Here's your roadmap for continued learning.

### Immediate Next Steps (Week 1-2)
```bash
#!/bin/bash

echo "=== YOUR SHELL SCRIPTING JOURNEY CONTINUES ==="
echo ""

# Create a learning progress tracker
create_learning_tracker() {
    local tracker_file="$HOME/shell_scripting_progress.md"
    
    cat > "$tracker_file" << 'EOF'
# Shell Scripting Learning Progress

## Completed ✅
- [ ] Basic shell scripting concepts
- [ ] Variables and data types
- [ ] Conditional statements and loops
- [ ] Functions and parameters
- [ ] File operations
- [ ] Text processing (grep, sed, awk)
- [ ] Arrays and advanced data structures
- [ ] Error handling and debugging
- [ ] Best practices and security

## Next Steps 🎯

### Week 1-2: Practice and Consolidation
- [ ] Write 5 utility scripts for daily tasks
- [ ] Practice debugging techniques
- [ ] Create a personal script library

### Month 1: Intermediate Skills
- [ ] Learn advanced bash features
- [ ] Study system administration scripts
- [ ] Practice automation scenarios

### Month 2-3: Advanced Topics
- [ ] Explore shell alternatives (zsh, fish)
- [ ] Learn about containerization with scripts
- [ ] Study CI/CD integration

### Ongoing: Real-world Projects
- [ ] Contribute to open-source projects
- [ ] Build automation tools for work/projects
- [ ] Share knowledge with others

## Resources 📚
- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck](https://www.shellcheck.net/) - Script analysis tool
- [Bash Pitfalls](http://mywiki.wooledge.org/BashPitfalls)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)

## Personal Notes
_Add your own notes and insights here_

EOF

    echo "Created learning tracker: $tracker_file"
    echo "Use this file to track your progress and plan next steps"
}

# Suggest practical projects
suggest_practice_projects() {
    echo ""
    echo "=== PRACTICE PROJECTS FOR BEGINNERS ==="
    echo ""
    echo "Start with these practical projects:"
    echo ""
    
    echo "📁 FILE MANAGEMENT:"
    echo "   • Photo organizer (sort by date/type)"
    echo "   • Duplicate file finder"
    echo "   • Automated backup script"
    echo "   • Directory cleanup tool"
    echo ""
    
    echo "🖥️  SYSTEM MONITORING:"
    echo "   • Disk space alert script"
    echo "   • Process monitor with email alerts"
    echo "   • Log file analyzer"
    echo "   • System health dashboard"
    echo ""
    
    echo "🌐 NETWORK UTILITIES:"
    echo "   • Website uptime monitor"
    echo "   • Port scanner"
    echo "   • Network configuration backup"
    echo "   • SSL certificate expiry checker"
    echo ""
    
    echo "⚙️  DEVELOPMENT TOOLS:"
    echo "   • Project initialization script"
    echo "   • Code formatter/linter runner"
    echo "   • Git workflow automation"
    echo "   • Environment setup script"
    echo ""
}

# Advanced learning path
advanced_learning_path() {
    echo "=== ADVANCED LEARNING PATH ==="
    echo ""
    
    echo "🚀 ADVANCED BASH FEATURES:"
    echo "   • Parameter expansion techniques"
    echo "   • Advanced pattern matching"
    echo "   • Process substitution mastery"
    echo "   • Co-processes and named pipes"
    echo ""
    
    echo "🏗️  INFRASTRUCTURE AUTOMATION:"
    echo "   • Server provisioning scripts"
    echo "   • Configuration management"
    echo "   • Container management"
    echo "   • CI/CD pipeline integration"
    echo ""
    
    echo "🔧 SYSTEM ADMINISTRATION:"
    echo "   • User and permission management"
    echo "   • Service monitoring and control"
    echo "   • Log aggregation and analysis"
    echo "   • Performance monitoring"
    echo ""
    
    echo "☁️  CLOUD AND DEVOPS:"
    echo "   • AWS/GCP/Azure CLI automation"
    echo "   • Kubernetes scripting"
    echo "   • Infrastructure as Code helpers"
    echo "   • Monitoring and alerting"
    echo ""
}

# Tool recommendations
recommend_tools() {
    echo "=== ESSENTIAL TOOLS FOR SHELL SCRIPTERS ==="
    echo ""
    
    echo "📋 DEVELOPMENT TOOLS:"
    echo "   • ShellCheck - Static analysis for shell scripts"
    echo "   • shfmt - Shell script formatter"
    echo "   • bats - Bash Automated Testing System"
    echo "   • VS Code with Bash extensions"
    echo ""
    
    echo "🔍 DEBUGGING TOOLS:"
    echo "   • bashdb - Bash debugger"
    echo "   • set -x - Built-in execution tracing"
    echo "   • shellcheck online - Browser-based checking"
    echo ""
    
    echo "📚 LEARNING RESOURCES:"
    echo "   • explainshell.com - Command explanation"
    echo "   • regex101.com - Regular expression tester"
    echo "   • man pages - Built-in documentation"
    echo "   • tldr - Simplified man pages"
    echo ""
}

# Create a sample weekly practice plan
create_practice_plan() {
    echo ""
    echo "=== SUGGESTED WEEKLY PRACTICE PLAN ==="
    echo ""
    
    local plan_file="$HOME/weekly_practice_plan.md"
    
    cat > "$plan_file" << 'EOF'
# Weekly Shell Scripting Practice Plan

## Week 1: Foundation Reinforcement
**Monday**: Review variables and basic I/O
- Write a script that takes user input and processes it
- Practice with different variable types

**Tuesday**: Conditionals and logic
- Create a file/directory analyzer script
- Practice with different test conditions

**Wednesday**: Loops and iteration
- Write a log file processor
- Practice with for, while, and until loops

**Thursday**: Functions and modularity
- Refactor previous scripts to use functions
- Create a utility function library

**Friday**: File operations
- Build a backup and restore system
- Practice with file permissions and ownership

**Weekend Project**: Personal utility script
- Combine the week's learning into one useful tool

## Week 2: Practical Applications
**Monday**: Text processing
- Create a data extraction script
- Practice with grep, sed, and awk

**Tuesday**: Arrays and data structures
- Build an inventory management system
- Work with associative arrays

**Wednesday**: Error handling
- Add robust error handling to previous scripts
- Practice with different error scenarios

**Thursday**: Process management
- Create a service monitor
- Practice with background processes

**Friday**: Integration and testing
- Combine multiple scripts
- Test edge cases and error conditions

**Weekend Project**: Complete automation solution
- Build a multi-component system (e.g., monitoring + alerting + reporting)

## Week 3+: Advanced Topics
- Choose specialization area (DevOps, SysAdmin, Development)
- Work on larger, real-world projects
- Contribute to open source or share with community
EOF

    echo "Created practice plan: $plan_file"
}

# Community and resources
community_resources() {
    echo ""
    echo "=== COMMUNITY AND CONTINUED LEARNING ==="
    echo ""
    
    echo "👥 COMMUNITIES:"
    echo "   • r/bash (Reddit)"
    echo "   • Unix & Linux Stack Exchange"
    echo "   • Bash tag on Stack Overflow"
    echo "   • Local Linux/Unix user groups"
    echo ""
    
    echo "📖 RECOMMENDED READING:"
    echo "   • 'Classic Shell Scripting' by Robbins & Beebe"
    echo "   • 'Learning the bash Shell' by Newham & Rosenblatt"
    echo "   • 'Bash Cookbook' by Albing, Vossen & Newham"
    echo "   • 'Unix Power Tools' by Peek, O'Reilly & Loukides"
    echo ""
    
    echo "🎥 VIDEO RESOURCES:"
    echo "   • YouTube: NetworkChuck, Learn Linux TV"
    echo "   • Linux Academy / A Cloud Guru"
    echo "   • Pluralsight shell scripting courses"
    echo ""
    
    echo "🏆 CERTIFICATION PATHS:"
    echo "   • Linux Professional Institute (LPIC-1)"
    echo "   • Red Hat Certified System Administrator (RHCSA)"
    echo "   • CompTIA Linux+"
    echo ""
}

# Final motivational message
final_message() {
    echo ""
    echo "🎉 CONGRATULATIONS! 🎉"
    echo ""
    echo "You've completed a comprehensive journey through shell scripting!"
    echo "From basic commands to advanced automation, you now have the tools"
    echo "to solve real-world problems with shell scripts."
    echo ""
    echo "Remember:"
    echo "  • Start small and build complexity gradually"
    echo "  • Practice regularly with real projects"
    echo "  • Always test your scripts thoroughly"
    echo "  • Share your knowledge and learn from others"
    echo "  • Keep security and best practices in mind"
    echo ""
    echo "The shell is a powerful tool - use it wisely and creatively!"
    echo ""
    echo "Your journey as a shell scripting expert has just begun. 🚀"
    echo ""
    echo "Good luck, and happy scripting!"
}

# Run all sections
create_learning_tracker
suggest_practice_projects
advanced_learning_path
recommend_tools
create_practice_plan
community_resources
final_message
```

---        setup_log_message "INFO" "Package $package installed successfully"
    }
    
    # Setup Git configuration
    setup_git() {
        setup_log_message "INFO" "Setting up Git configuration"
        
        if command_exists git; then
            # Check if Git is already configured
            local git_user=$(git config --global user.name 2>/dev/null || echo "")
            local git_email=$(git config --global user.email 2>/dev/null || echo "")
            
            if [ -z "$git_user" ] || [ -z "$git_email" ]; then
                setup_log_message "INFO" "Git not configured, setting up with demo values"
                
                # Set demo configuration
                git config --global user.name "Developer" 2>/dev/null
                git config --global user.email "developer@example.com" 2>/dev/null
                git config --global init.defaultBranch "main" 2>/dev/null
                
                setup_log_message "INFO" "Git configuration completed"
            else
                setup_log_message "INFO" "Git already configured for $git_user ($git_email)"
            fi
        else
            setup_log_message "WARNING" "Git not found, would install if this were a real setup"
            install_package "git"
        fi
    }
    
    # Setup development directories
    setup_directories() {
        setup_log_message "INFO" "Setting up development directories"
        
        local dev_dirs=(
            "$HOME/Development"
            "$HOME/Development/projects"
            "$HOME/Development/scripts"
            "$HOME/Development/tools"
            "$HOME/.local/bin"
        )
        
        for dir in "${dev_dirs[@]}"; do
            if [ ! -d "$dir" ]; then
                mkdir -p "$dir"
                setup_log_message "INFO" "Created directory: $dir"
            else
                setup_log_message "INFO" "Directory already exists: $dir"
            fi
        done
    }
    
    # Setup shell configuration
    setup_shell_config() {
        setup_log_message "INFO" "Setting up shell configuration"
        
        local shell_config=""
        case "$SHELL" in
            */bash)
                shell_config="$HOME/.bashrc"
                ;;
            */zsh)
                shell_config="$HOME/.zshrc"
                ;;
            *)
                shell_config="$HOME/.profile"
                ;;
        esac
        
        # Add development environment to PATH
        local path_addition='export PATH="$HOME/.local/bin:$PATH"'
        
        if [ -f "$shell_config" ]; then
            if ! grep -q ".local/bin" "$shell_config"; then
                echo "" >> "$shell_config"
                echo "# Development environment" >> "$shell_config"
                echo "$path_addition" >> "$shell_config"
                setup_log_message "INFO" "Added development PATH to $shell_config"
            else
                setup_log_message "INFO" "Development PATH already configured in $shell_config"
            fi
        else
            echo "$path_addition" > "$shell_config"
            setup_log_message "INFO" "Created $shell_config with development PATH"
        fi
        
        # Add useful aliases
        local aliases=(
            'alias ll="ls -la"'
            'alias la="ls -A"'
            'alias l="ls -CF"'
            'alias grep="grep --color=auto"'
            'alias dev="cd $HOME/Development"'
        )
        
        echo "" >> "$shell_config"
        echo "# Development aliases" >> "$shell_config"
        for alias_cmd in "${aliases[@]}"; do
            if ! grep -q "$alias_cmd" "$shell_config"; then
                echo "$alias_cmd" >> "$shell_config"
            fi
        done
        
        setup_log_message "INFO" "Shell configuration completed"
    }
    
    # Create useful development scripts
    create_dev_scripts() {
        setup_log_message "INFO" "Creating development utility scripts"
        
        local scripts_dir="$HOME/Development/scripts"
        
        # Project initialization script
        cat > "$scripts_dir/new-project.sh" << 'EOF'
#!/bin/bash
# Quick project initialization script

if [ -z "$1" ]; then
    echo "Usage: $0 <project-name> [language]"
    echo "Languages: python, node, bash, go"
    exit 1
fi

project_name="$1"
language="${2:-bash}"

mkdir -p "$HOME/Development/projects/$project_name"
cd "$HOME/Development/projects/$project_name"

case $language in
    python)
        echo "# $project_name" > README.md
        echo "print('Hello from $project_name')" > main.py
        echo "requests" > requirements.txt
        ;;
    node)
        echo "# $project_name" > README.md
        echo "console.log('Hello from $project_name');" > index.js
        echo '{"name":"'$project_name'","version":"1.0.0","main":"index.js"}' > package.json
        ;;
    go)
        echo "# $project_name" > README.md
        echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello from '$project_name'")
}' > main.go
        ;;
    bash)
        echo "# $project_name" > README.md
        echo '#!/bin/bash
echo "Hello from '$project_name'"' > main.sh
        chmod +x main.sh
        ;;
esac

if command -v git >/dev/null; then
    git init
    git add .
    git commit -m "Initial commit"
fi

echo "Project $project_name created in $(pwd)"
EOF
        chmod +x "$scripts_dir/new-project.sh"
        
        # System information script
        cat > "$scripts_dir/sysinfo.sh" << 'EOF'
#!/bin/bash
# Quick system information display

echo "=== System Information ==="
echo "Hostname: $(hostname)"
echo "OS: $(uname -s) $(uname -r)"
echo "Architecture: $(uname -m)"
echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
echo "Load: $(uptime | awk -F'load average:' '{print $2}')"
echo "Memory: $(free -h | awk 'NR==2{print $3"/"$2}')"
echo "Disk: $(df -h / | awk 'NR==2{print $3"/"$2" ("$5")"}')"
echo "Shell: $SHELL"
echo "User: $(whoami)"
echo "Date: $(date)"
EOF
        chmod +x "$scripts_dir/sysinfo.sh"
        
        # Add scripts to PATH
        ln -sf "$scripts_dir/new-project.sh" "$HOME/.local/bin/new-project" 2>/dev/null
        ln -sf "$scripts_dir/sysinfo.sh" "$HOME/.local/bin/sysinfo" 2>/dev/null
        
        setup_log_message "INFO" "Development scripts created and linked"
    }
    
    # Verify installation
    verify_setup() {
        setup_log_message "INFO" "Verifying development environment setup"
        
        local verification_passed=true
        
        # Check directories
        local required_dirs=(
            "$HOME/Development"
            "$HOME/Development/projects"
            "$HOME/Development/scripts"
            "$HOME/.local/bin"
        )
        
        for dir in "${required_dirs[@]}"; do
            if [ -d "$dir" ]; then
                setup_log_message "INFO" "✓ Directory exists: $dir"
            else
                setup_log_message "ERROR" "✗ Directory missing: $dir"
                verification_passed=false
            fi
        done
        
        # Check scripts
        local required_scripts=(
            "$HOME/.local/bin/new-project"
            "$HOME/.local/bin/sysinfo"
        )
        
        for script in "${required_scripts[@]}"; do
            if [ -x "$script" ]; then
                setup_log_message "INFO" "✓ Script available: $(basename "$script")"
            else
                setup_log_message "ERROR" "✗ Script missing: $script"
                verification_passed=false
            fi
        done
        
        if $verification_passed; then
            setup_log_message "INFO" "✓ Development environment setup verification PASSED"
            return 0
        else
            setup_log_message "ERROR" "✗ Development environment setup verification FAILED"
            return 1
        fi
    }
    
    # Generate setup summary
    generate_setup_summary() {
        echo ""
        echo "=== DEVELOPMENT ENVIRONMENT SETUP SUMMARY ==="
        echo "Setup completed: $(date)"
        echo ""
        echo "Created directories:"
        echo "  ~/Development/projects  - For your projects"
        echo "  ~/Development/scripts   - For utility scripts"
        echo "  ~/.local/bin           - For personal executables"
        echo ""
        echo "Available commands:"
        echo "  new-project <name> [language] - Create new project"
        echo "  sysinfo                       - Show system information"
        echo ""
        echo "Shell configuration updated:"
        case "$SHELL" in
            */bash) echo "  ~/.bashrc - Added PATH and aliases" ;;
            */zsh)  echo "  ~/.zshrc - Added PATH and aliases" ;;
            *)      echo "  ~/.profile - Added PATH and aliases" ;;
        esac
        echo ""
        echo "To apply changes to current session, run:"
        echo "  source ~/.bashrc   (or reload your terminal)"
        echo ""
        echo "Setup log: $setup_log"
    }
    
    # Run the setup
    setup_log_message "INFO" "Starting development environment setup"
    
    setup_git
    setup_directories
    setup_shell_config
    create_dev_scripts
    
    if verify_setup; then
        generate_setup_summary
    else
        echo "Setup completed with errors. Check $setup_log for details."
    fi
}

# Server deployment automation
server_deployment() {
    echo ""
    echo "=== SERVER DEPLOYMENT AUTOMATION ==="
    
    # Configuration
    local deploy_log="deploy.log"
    local app_name="sample-app"
    local app_version="1.0.0"
    local deploy_dir="/opt/$app_name"
    local service_name="$app_name"
    
    # Deployment logging
    deploy_log_message() {
        local level=$1
        local message=$2
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        
        echo "[$timestamp] [$level] $message" | tee -a "$deploy_log"
    }
    
    # Pre-deployment checks
    pre_deployment_checks() {
        deploy_log_message "INFO" "Running pre-deployment checks"
        
        local checks_passed=true
        
        # Check disk space
        local available_space=$(df / | awk 'NR==2 {print $4}')
        local required_space=1000000  # 1GB in KB
        
        if [ "$available_space" -lt "$required_space" ]; then
            deploy_log_message "ERROR" "Insufficient disk space"
            checks_passed=false
        else
            deploy_log_message "INFO" "✓ Sufficient disk space available"
        fi
        
        # Check if running as appropriate user
        if [ "$(id -u)" -eq 0 ]; then
            deploy_log_message "WARNING" "Running as root - consider using dedicated user"
        fi
        
        # Check network connectivity
        if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
            deploy_log_message "INFO" "✓ Network connectivity OK"
        else
            deploy_log_message "ERROR" "No network connectivity"
            checks_passed=false
        fi
        
        if $checks_passed; then
            deploy_log_message "INFO" "✓ Pre-deployment checks passed"
            return 0
        else
            deploy_log_message "ERROR" "✗ Pre-deployment checks failed"
            return 1
        fi
    }
    
    # Create application structure
    create_app_structure() {
        deploy_log_message "INFO" "Creating application structure"
        
        # Create directories
        local app_dirs=(
            "$deploy_dir"
            "$deploy_dir/bin"
            "$deploy_dir/config"
            "$deploy_dir/logs"
            "$deploy_dir/data"
            "/etc/$app_name"
        )
        
        for dir in "${app_dirs[@]}"; do
            if mkdir -p "$dir" 2>/dev/null; then
                deploy_log_message "INFO" "Created directory: $dir"
            else
                deploy_log_message "ERROR" "Failed to create directory: $dir"
                return 1
            fi
        done
        
        return 0
    }
    
    # Deploy application files
    deploy_application() {
        deploy_log_message "INFO" "Deploying application files"
        
        # Create sample application
        cat > "$deploy_dir/bin/$app_name" << EOF
#!/bin/bash
# Sample application - $app_name v$app_version

echo "Starting $app_name v$app_version"
echo "PID: \$\$"
echo "Started at: \$(date)"

# Log startup
echo "[\$(date)] $app_name started" >> "$deploy_dir/logs/app.log"

# Main application loop (simulation)
counter=0
while true; do
    echo "[\$(date)] Application running - iteration \$counter" >> "$deploy_dir/logs/app.log"
    sleep 10
    ((counter++))
    
    # Exit after 10 iterations for demo
    if [ \$counter -ge 10 ]; then
        echo "[\$(date)] $app_name stopping (demo limit reached)" >> "$deploy_dir/logs/app.log"
        break
    fi
done

echo "[\$(date)] $app_name stopped" >> "$deploy_dir/logs/app.log"
EOF
        
        chmod +x "$deploy_dir/bin/$app_name"
        
        # Create configuration file
        cat > "$deploy_dir/config/app.conf" << EOF
# $app_name Configuration
app_name=$app_name
app_version=$app_version
log_level=INFO
max_connections=100
bind_port=8080
EOF
        
        # Create systemd service file (simulation)
        cat > "/tmp/$service_name.service" << EOF
[Unit]
Description=$app_name Application
After=network.target

[Service]
Type=simple
User=nobody
ExecStart=$deploy_dir/bin/$app_name
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF
        
        deploy_log_message "INFO" "Application files deployed successfully"
        return 0
    }
    
    # Configure monitoring
    setup_monitoring() {
        deploy_log_message "INFO" "Setting up monitoring"
        
        # Create health check script
        cat > "$deploy_dir/bin/health-check.sh" << EOF
#!/bin/bash
# Health check script for $app_name

check_process() {
    if pgrep -f "$app_name" > /dev/null; then
        return 0
    else
        return 1
    fi
}

check_log() {
    local log_file="$deploy_dir/logs/app.log"
    if [ -f "\$log_file" ]; then
        # Check if log was updated in last 60 seconds
        local last_modified=\$(stat -c %Y "\$log_file" 2>/dev/null || echo 0)
        local current_time=\$(date +%s)
        local diff=\$((current_time - last_modified))
        
        if [ \$diff -lt 60 ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

# Run checks
if check_process && check_log; then
    echo "HEALTHY"
    exit 0
else
    echo "UNHEALTHY"
    exit 1
fi
EOF
        
        chmod +x "$deploy_dir/bin/health-check.sh"
        
        # Create monitoring cron job
        echo "*/5 * * * * $deploy_dir/bin/health-check.sh >> $deploy_dir/logs/health.log 2>&1" > "/tmp/$app_name-cron"
        
        deploy_log_message "INFO" "Monitoring setup completed"
    }
    
    # Post-deployment verification
    post_deployment_verification() {
        deploy_log_message "INFO" "Running post-deployment verification"
        
        local verification_passed=true
        
        # Check if application files exist
        local required_files=(
            "$deploy_dir/bin/$app_name"
            "$deploy_dir/config/app.conf"
            "$deploy_dir/bin/health-check.sh"
        )
        
        for file in "${required_files[@]}"; do
            if [ -f "$file" ]; then
                deploy_log_message "INFO" "✓ File exists: $file"
            else
                deploy_log_message "ERROR" "✗ File missing: $file"
                verification_passed=false
            fi
        done
        
        # Check if application is executable
        if [ -x "$deploy_dir/bin/$app_name" ]; then
            deploy_log_message "INFO" "✓ Application is executable"
        else
            deploy_log_message "ERROR" "✗ Application is not executable"
            verification_passed=false
        fi
        
        # Test health check
        if "$deploy_dir/bin/health-check.sh" >/dev/null 2>&1; then
            local health_status="HEALTHY"
        else
            local health_status="UNHEALTHY"
        fi
        deploy_log_message "INFO" "Health check status: $health_status"
        
        if $verification_passed; then
            deploy_log_message "INFO" "✓ Post-deployment verification passed"
            return 0
        else
            deploy_log_message "ERROR" "✗ Post-deployment verification failed"
            return 1
        fi
    }
    
    # Rollback function
    rollback_deployment() {
        deploy_log_message "WARNING" "Initiating deployment rollback"
        
        # Stop application if running
        if pgrep -f "$app_name" >/dev/null; then
            pkill -f "$app_name"
            deploy_log_message "INFO" "Stopped running application"
        fi
        
        # Remove deployed files
        if [ -d "$deploy_dir" ]; then
            rm -rf "$deploy_dir"
            deploy_log_message "INFO" "Removed deployment directory"
        fi
        
        # Remove service file
        rm -f "/tmp/$service_name.service"
        rm -f "/tmp/$app_name-cron"
        
        deploy_log_message "INFO" "Rollback completed"
    }
    
    # Generate deployment report
    generate_deployment_report() {
        echo ""
        echo "=== DEPLOYMENT REPORT ==="
        echo "Application: $app_name v$app_version"
        echo "Deployed to: $deploy_dir"
        echo "Deployment time: $(date)"
        echo ""
        
        echo "Deployed files:"
        if [ -d "$deploy_dir" ]; then
            find "$deploy_dir" -type f | sed 's/^/  /'
        else
            echo "  No files found"
        fi
        
        echo ""
        echo "Application status:"
        if [ -x "$deploy_dir/bin/health-check.sh" ]; then
            local health_status=$("$deploy_dir/bin/health-check.sh" 2>/dev/null || echo "UNHEALTHY")
            echo "  Health: $health_status"
        else
            echo "  Health: Unknown (health check not available)"
        fi
        
        echo ""
        echo "Quick start commands:"
        echo "  Start application: $deploy_dir/bin/$app_name &"
        echo "  Check health:      $deploy_dir/bin/health-check.sh"
        echo "  View logs:         tail -f $deploy_dir/logs/app.log"
        
        echo ""
        echo "Deployment log: $deploy_log"
    }
    
    # Main deployment process
    deploy_log_message "INFO" "Starting deployment of $app_name v$app_version"
    
    if ! pre_deployment_checks; then
        deploy_log_message "ERROR" "Deployment aborted due to failed pre-checks"
        return 1
    fi
    
    if ! create_app_structure; then
        deploy_log_message "ERROR" "Deployment failed during structure creation"
        rollback_deployment
        return 1
    fi
    
    if ! deploy_application; then
        deploy_log_message "ERROR" "Deployment failed during application deployment"
        rollback_deployment
        return 1
    fi
    
    setup_monitoring
    
    if post_deployment_verification; then
        deploy_log_message "INFO" "✓ Deployment completed successfully"
        generate_deployment_report
        return 0
    else
        deploy_log_message "ERROR" "Deployment verification failed"
        echo "Deployment completed but verification failed. Check logs for details."
        echo "Use rollback if needed."
        return 1
    fi
}

# Run automation examples
echo "Running Automation Examples..."
echo ""

automated_backup_system

dev_environment_setup

server_deployment

echo ""
echo "=========================================="
echo "All automation examples completed!"
echo "Check the generated log files for detailed information."
```

---

## Best Practices

Essential best practices for writing maintainable and reliable shell scripts.

### Script Structure and Organization
```bash
#!/bin/bash

# This script demonstrates best practices for shell script structure

#======================================================================
# Script Information
#======================================================================
# Script Name: best-practices-demo.sh
# Description: Demonstrates shell scripting best practices
# Author: Shell Script Guide
# Version: 1.0.0
# Created: 2024-01-01
# Last Modified: 2024-01-01
#
# Usage: ./best-practices-demo.sh [options]
# Examples:
#   ./best-practices-demo.sh --help
#   ./best-practices-demo.sh --verbose --config config.ini
#======================================================================

#======================================================================
# Global Variables and Constants
#======================================================================

# Script metadata
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_VERSION="1.0.0"

# Configuration
readonly DEFAULT_CONFIG_FILE="$SCRIPT_DIR/config.ini"
readonly DEFAULT_LOG_FILE="$SCRIPT_DIR/script.log"
readonly DEFAULT_TEMP_DIR="/tmp/$SCRIPT_NAME.$"

# Exit codes
readonly EXIT_SUCCESS=0
readonly EXIT_GENERAL_ERROR=1
readonly EXIT_MISUSE=2
readonly EXIT_CANNOT_EXECUTE=126
readonly EXIT_COMMAND_NOT_FOUND=127

# Global flags
VERBOSE=false
DEBUG=false
DRY_RUN=false
CONFIG_FILE="$DEFAULT_CONFIG_FILE"
LOG_FILE="$DEFAULT_LOG_FILE"

#======================================================================
# Utility Functions
#======================================================================

# Logging function
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Log to file if specified
    if [[ -n "$LOG_FILE" ]]; then
        echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    fi
    
    # Output to stderr for ERROR and WARNING
    case $level in
        ERROR)
            echo "[$level] $message" >&2
            ;;
        WARNING)
            echo "[$level] $message" >&2
            ;;
        INFO)
            [[ "$VERBOSE" == true ]] && echo "[$level] $message"
            ;;
        DEBUG)
            [[ "$DEBUG" == true ]] && echo "[$level] $message" >&2
            ;;
    esac
}

# Error handling
error_exit() {
    local message=${1:-"Unknown error"}
    local exit_code=${2:-$EXIT_GENERAL_ERROR}
    
    log "ERROR" "$message"
    cleanup_and_exit $exit_code
}

# Cleanup function
cleanup() {
    log "DEBUG" "Running cleanup function"
    
    # Remove temporary files
    if [[ -d "$DEFAULT_TEMP_DIR" ]]; then
        rm -rf "$DEFAULT_TEMP_DIR"
        log "DEBUG" "Removed temporary directory: $DEFAULT_TEMP_DIR"
    fi
    
    # Kill background jobs
    local jobs=$(jobs -p)
    if [[ -n "$jobs" ]]; then
        echo "$jobs" | xargs kill 2>/dev/null
        log "DEBUG" "Killed background jobs"
    fi
}

# Cleanup and exit
cleanup_and_exit() {
    local exit_code=${1:-$EXIT_SUCCESS}
    cleanup
    exit $exit_code
}

# Signal handlers
handle_interrupt() {
    log "WARNING" "Received interrupt signal"
    cleanup_and_exit $EXIT_GENERAL_ERROR
}

handle_termination() {
    log "WARNING" "Received termination signal"
    cleanup_and_exit $EXIT_GENERAL_ERROR
}

#======================================================================
# Validation Functions
#======================================================================

# Validate required commands
validate_dependencies() {
    log "DEBUG" "Validating dependencies"
    
    local required_commands=("awk" "sed" "grep" "sort")
    local missing_commands=()
    
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_commands+=("$cmd")
        fi
    done
    
    if [[ ${#missing_commands[@]} -gt 0 ]]; then
        error_exit "Missing required commands: ${missing_commands[*]}"
    fi
    
    log "DEBUG" "All dependencies satisfied"
}

# Validate file permissions
validate_file_access() {
    local file=$1
    local access_type=${2:-"r"}  # r=read, w=write, x=execute
    
    case $access_type in
        r)
            if [[ ! -r "$file" ]]; then
                return 1
            fi
            ;;
        w)
            if [[ ! -w "$file" ]]; then
                return 1
            fi
            ;;
        x)
            if [[ ! -x "$file" ]]; then
                return 1
            fi
            ;;
        *)
            log "ERROR" "Invalid access type: $access_type"
            return 1
            ;;
    esac
    
    return 0
}

# Input validation
validate_input() {
    local input=$1
    local type=$2
    
    case $type in
        email)
            if [[ $input =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
                return 0
            fi
            ;;
        number)
            if [[ $input =~ ^[0-9]+$ ]]; then
                return 0
            fi
            ;;
        ipv4)
            if [[ $input =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
                # Additional validation for range
                IFS='.' read -r a b c d <<< "$input"
                if (( a <= 255 && b <= 255 && c <= 255 && d <= 255 )); then
                    return 0
                fi
            fi
            ;;
        *)
            log "ERROR" "Unknown validation type: $type"
            return 1
            ;;
    esac
    
    return 1
}

#======================================================================
# Configuration Management
#======================================================================

# Load configuration file
load_config() {
    local config_file=${1:-$CONFIG_FILE}
    
    log "DEBUG" "Loading configuration from: $config_file"
    
    if [[ ! -f "$config_file" ]]; then
        log "WARNING" "Configuration file not found: $config_file"
        return 1
    fi
    
    # Read configuration file
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        [[ $key =~ ^[[:space:]]*# ]] && continue
        [[ -z $key ]] && continue
        
        # Remove leading/trailing whitespace
        key=$(echo "$key" | xargs)
        value=$(echo "$value" | xargs)
        
        # Set configuration variable
        case $key in
            verbose)
                VERBOSE=$value
                ;;
            debug)
                DEBUG=$value
                ;;
            log_file)
                LOG_FILE=$value
                ;;
            *)
                log "DEBUG" "Unknown configuration key: $key"
                ;;
        esac
        
    done < "$config_file"
    
    log "DEBUG" "Configuration loaded successfully"
}

# Create default configuration
create_default_config() {
    local config_file=${1:-$CONFIG_FILE}
    
    cat > "$config_file" << EOF
# Configuration file for $SCRIPT_NAME
# Generated on: $(date)

# Logging options
verbose=false
debug=false
log_file=$DEFAULT_LOG_FILE

# Application settings
max_retries=3
timeout=30
EOF
    
    log "INFO" "Created default configuration: $config_file"
}

#======================================================================
# Main Application Functions
#======================================================================

# Example processing function with best practices
process_data() {
    local input_file=$1
    local output_file=$2
    
    log "INFO" "Processing data: $input_file -> $output_file"
    
    # Input validation
    if [[ -z "$input_file" ]] || [[ -z "$output_file" ]]; then
        error_exit "Missing required parameters for process_data"
    fi
    
    # File validation
    if ! validate_file_access "$input_file" "r"; then
        error_exit "Cannot read input file: $input_file"
    fi
    
    if ! validate_file_access "$(dirname "$output_file")" "w"; then
        error_exit "Cannot write to output directory: $(dirname "$output_file")"
    fi
    
    # Create temporary file for processing
    local temp_file="$DEFAULT_TEMP_DIR/processing.tmp"
    mkdir -p "$(dirname "$temp_file")"
    
    # Process data with error handling
    if ! awk '{print toupper($0)}' "$input_file" > "$temp_file"; then
        error_exit "Failed to process input file"
    fi
    
    # Validate processed data
    if [[ ! -s "$temp_file" ]]; then
        error_exit "Processing resulted in empty file"
    fi
    
    # Move processed data to final location
    if ! mv "$temp_file" "$output_file"; then
        error_exit "Failed to move processed data to output file"
    fi
    
    log "INFO" "Data processing completed successfully"
}

# Backup function example
backup_file() {
    local source_file=$1
    local backup_dir=${2:-"./backups"}
    
    log "DEBUG" "Creating backup of: $source_file"
    
    # Validation
    if [[ ! -f "$source_file" ]]; then
        log "ERROR" "Source file does not exist: $source_file"
        return 1
    fi
    
    # Create backup directory
    if ! mkdir -p "$backup_dir"; then
        log "ERROR" "Cannot create backup directory: $backup_dir"
        return 1
    fi
    
    # Generate backup filename with timestamp
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local filename=$(basename "$source_file")
        # Expensive operation simulation
    expensive_operation() {
        local input=$1
        echo "Performing expensive calculation for: $input"
        sleep 1  # Simulate expensive operation
        echo $((input * input))
    }
    
    # Without caching
    without_caching() {
        echo "Without caching:"
        local start_time=$(date +%s)
        
        for i in 5 3 7 3 5 7 5; do
            result=$(expensive_operation $i)
            echo "Result for $i: $result"
        done
        
        local end_time=$(date +%s)
        echo "Without caching took $((end_time - start_time)) seconds"
    }
    
    # With caching
    with_caching() {
        echo "With caching:"
        local start_time=$(date +%s)
        
        # Cache storage
        declare -A cache
        
        for i in 5 3 7 3 5 7 5; do
            if [ -n "${cache[$i]}" ]; then
                echo "Cache hit for $i: ${cache[$i]}"
            else
                result=$(expensive_operation $i)
                cache[$i]=$result
                echo "Cached result for $i: $result"
            fi
        done
        
        local end_time=$(date +%s)
        echo "With caching took $((end_time - start_time)) seconds"
    }
    
    without_caching
    echo ""
    with_caching
}

# Resource usage monitoring
resource_monitoring() {
    echo ""
    echo "=== Resource Usage Monitoring ==="
    
    # Function to monitor script resource usage
    monitor_resources() {
        local script_name=$1
        local pid=$
        
        echo "Monitoring resources for PID: $pid"
        echo "Script: $script_name"
        
        # Memory usage
        if [ -f /proc/$pid/status ]; then
            local mem_usage=$(grep VmRSS /proc/$pid/status | awk '{print $2 " " $3}')
            echo "Memory usage: $mem_usage"
        fi
        
        # CPU time
        local cpu_time=$(ps -o time= -p $pid)
        echo "CPU time: $cpu_time"
        
        # File descriptors
        if [ -d /proc/$pid/fd ]; then
            local fd_count=$(ls /proc/$pid/fd | wc -l)
            echo "Open file descriptors: $fd_count"
        fi
    }
    
    # Resource-intensive operation
    resource_intensive_task() {
        echo "Running resource-intensive task..."
        
        # Create some data structures
        declare -a large_array
        for i in {1..1000}; do
            large_array[i]="data_item_$i"
        done
        
        # Open some files
        exec 3> /tmp/test_output.txt
        exec 4< /dev/null
        
        monitor_resources "resource_intensive_task"
        
        # Cleanup
        exec 3>&-
        exec 4<&-
        rm -f /tmp/test_output.txt
    }
    
    resource_intensive_task
}

# Performance tips summary
performance_tips() {
    echo ""
    echo "=== Performance Optimization Tips ==="
    echo ""
    echo "1. Use built-in commands instead of external ones:"
    echo "   Good: \${#string}       Bad: echo \$string | wc -c"
    echo "   Good: \${string^^}      Bad: echo \$string | tr '[:lower:]' '[:upper:]'"
    echo ""
    echo "2. Minimize command substitution in loops:"
    echo "   Bad:  for i in {1..1000}; do current_time=\$(date); done"
    echo "   Good: start_time=\$(date); for i in {1..1000}; do ...; done"
    echo ""
    echo "3. Use arrays for batch operations:"
    echo "   files=(\*.txt); for file in \"\${files[@]}\"; do ...; done"
    echo ""
    echo "4. Stream large files instead of loading into memory:"
    echo "   Good: while read -r line; do ...; done < file"
    echo "   Bad:  content=\$(cat file); for line in \$content; do ...; done"
    echo ""
    echo "5. Use parallel processing for independent tasks:"
    echo "   task1 & task2 & task3 & wait"
    echo ""
    echo "6. Cache expensive operations:"
    echo "   Use associative arrays to store computed results"
    echo ""
    echo "7. Profile your scripts:"
    echo "   Use 'time' command and bash's TIMEFORMAT"
    echo "   Monitor with 'ps', 'top', or '/proc' filesystem"
    echo ""
    echo "8. Minimize subshells:"
    echo "   Good: var=\${var#prefix}  Bad: var=\$(echo \$var | sed 's/^prefix//')"
}

# Run all demonstrations
performance_comparison
memory_optimization
loop_optimization
builtin_vs_external
parallel_processing

# Only run caching demo if associative arrays are supported
if declare -A test_array 2>/dev/null; then
    caching_demo
else
    echo "Associative arrays not supported in this bash version (caching demo skipped)"
fi

resource_monitoring
performance_tips

echo ""
echo "Performance optimization demonstrations completed!"
echo "Remember: Always measure before and after optimization!"
```

---

# Part 11: Real-World Applications

## System Administration Scripts

Practical scripts for system administration tasks.

### System Health Monitor
```bash
#!/bin/bash

# Comprehensive system health monitoring script
system_health_monitor() {
    echo "=========================================="
    echo "         SYSTEM HEALTH REPORT"
    echo "=========================================="
    echo "Generated: $(date)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
    echo ""
    
    # Disk usage check
    check_disk_usage() {
        echo "=== DISK USAGE ==="
        
        # Set threshold (percentage)
        local threshold=80
        
        df -h | grep -E '^/dev/' | while read -r filesystem size used available percentage mount_point; do
            # Extract numeric percentage
            local usage=${percentage%?}
            
            printf "%-20s %8s %8s %8s %8s %s" "$filesystem" "$size" "$used" "$available" "$percentage" "$mount_point"
            
            if [ "$usage" -gt "$threshold" ]; then
                printf " ⚠ WARNING"
            else
                printf " ✓ OK"
            fi
            echo ""
        done
        echo ""
    }
    
    # Memory usage check
    check_memory_usage() {
        echo "=== MEMORY USAGE ==="
        
        if command -v free >/dev/null; then
            free -h
            echo ""
            
            # Get memory usage percentage
            local mem_usage=$(free | awk 'NR==2{printf "%.0f", $3*100/($3+$7)}')
            echo "Memory usage: ${mem_usage}%"
            
            if [ "$mem_usage" -gt 80 ]; then
                echo "⚠ WARNING: High memory usage"
            else
                echo "✓ Memory usage normal"
            fi
        else
            echo "Memory information not available"
        fi
        echo ""
    }
    
    # CPU usage and load average
    check_cpu_load() {
        echo "=== CPU USAGE ==="
        
        # Load average
        local load_avg=$(uptime | awk -F'load average:' '{print $2}' | xargs)
        echo "Load average: $load_avg"
        
        # Number of CPU cores
        local cpu_cores=$(nproc 2>/dev/null || echo "unknown")
        echo "CPU cores: $cpu_cores"
        
        # Calculate load percentage (1-minute average)
        if [ "$cpu_cores" != "unknown" ]; then
            local load_1min=$(echo "$load_avg" | cut -d',' -f1 | xargs)
            local load_percentage=$(echo "scale=0; $load_1min * 100 / $cpu_cores" | bc -l 2>/dev/null || echo "calculation unavailable")
            
            if [ "$load_percentage" != "calculation unavailable" ]; then
                echo "Load percentage: ${load_percentage}%"
                
                if [ "$load_percentage" -gt 100 ]; then
                    echo "⚠ WARNING: High CPU load"
                else
                    echo "✓ CPU load normal"
                fi
            fi
        fi
        
        # Top CPU-consuming processes
        echo ""
        echo "Top CPU-consuming processes:"
        ps aux --sort=-%cpu | head -6 | awk '{printf "%-10s %5s %5s %s\n", $1, $3"%", $4"%", $11}'
        echo ""
    }
    
    # Service status check
    check_services() {
        echo "=== SERVICE STATUS ==="
        
        # Define critical services to check
        local services=("ssh" "sshd" "networking" "systemd-resolved" "cron")
        
        for service in "${services[@]}"; do
            if systemctl is-active --quiet "$service" 2>/dev/null; then
                printf "%-20s ✓ Running\n" "$service"
            elif systemctl list-unit-files --quiet "$service.service" 2>/dev/null | grep -q "$service"; then
                printf "%-20s ✗ Stopped\n" "$service"
            else
                printf "%-20s ? Not found\n" "$service"
            fi
        done
        echo ""
    }
    
    # Network connectivity check
    check_network() {
        echo "=== NETWORK CONNECTIVITY ==="
        
        # Test internet connectivity
        if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
            echo "✓ Internet connectivity: OK"
        else
            echo "✗ Internet connectivity: FAILED"
        fi
        
        # Check DNS resolution
        if nslookup google.com >/dev/null 2>&1; then
            echo "✓ DNS resolution: OK"
        else
            echo "✗ DNS resolution: FAILED"
        fi
        
        # Show network interfaces
        echo ""
        echo "Network interfaces:"
        if command -v ip >/dev/null; then
            ip addr show | grep -E '^[0-9]+:|inet ' | sed 's/^[[:space:]]*/  /'
        else
            ifconfig 2>/dev/null | grep -E '^[a-zA-Z]|inet ' | sed 's/^[[:space:]]*/  /'
        fi
        echo ""
    }
    
    # Security checks
    check_security() {
        echo "=== SECURITY STATUS ==="
        
        # Check for failed login attempts
        if [ -f /var/log/auth.log ]; then
            local failed_logins=$(grep "Failed password" /var/log/auth.log | wc -l 2>/dev/null || echo "0")
            echo "Failed login attempts (auth.log): $failed_logins"
        fi
        
        # Check for users with UID 0 (root privileges)
        local root_users=$(awk -F: '$3==0{print $1}' /etc/passwd | tr '\n' ' ')
        echo "Users with root privileges: $root_users"
        
        # Check for world-writable files in critical directories
        echo "Checking for world-writable files..."
        local critical_dirs=("/etc" "/bin" "/sbin" "/usr/bin" "/usr/sbin")
        local writable_count=0
        
        for dir in "${critical_dirs[@]}"; do
            if [ -d "$dir" ]; then
                local count=$(find "$dir" -type f -perm -002 2>/dev/null | wc -l)
                writable_count=$((writable_count + count))
            fi
        done
        
        if [ $writable_count -eq 0 ]; then
            echo "✓ No world-writable files found in critical directories"
        else
            echo "⚠ WARNING: $writable_count world-writable files found"
        fi
        echo ""
    }
    
    # Generate summary
    generate_summary() {
        echo "=== HEALTH SUMMARY ==="
        
        local status="HEALTHY"
        local warnings=0
        
        # Check disk usage
        local high_disk_usage=$(df -h | grep -E '^/dev/' | awk '{print $5}' | sed 's/%//' | awk '$1>80{print $1}' | wc -l)
        if [ $high_disk_usage -gt 0 ]; then
            status="WARNING"
            ((warnings++))
        fi
        
        # Check memory usage
        local mem_usage=$(free | awk 'NR==2{printf "%.0f", $3*100/($3+$7)}' 2>/dev/null || echo "0")
        if [ "$mem_usage" -gt 80 ] 2>/dev/null; then
            status="WARNING"
            ((warnings++))
        fi
        
        # Check load average
        local cpu_cores=$(nproc 2>/dev/null || echo "1")
        local load_1min=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)
        local load_percentage=$(echo "scale=0; $load_1min * 100 / $cpu_cores" | bc -l 2>/dev/null || echo "0")
        
        if [ "$load_percentage" -gt 100 ] 2>/dev/null; then
            status="WARNING"
            ((warnings++))
        fi
        
        echo "Overall Status: $status"
        echo "Warnings: $warnings"
        echo ""
        
        if [ "$status" = "WARNING" ]; then
            echo "⚠ ATTENTION REQUIRED: System has $warnings warning(s)"
        else
            echo "✓ SYSTEM HEALTHY: All checks passed"
        fi
    }
    
    # Run all checks
    check_disk_usage
    check_memory_usage  
    check_cpu_load
    check_services
    check_network
    check_security
    generate_summary
    
    echo ""
    echo "=========================================="
    echo "End of system health report"
    echo "=========================================="
}

# Log cleanup script
log_cleanup() {
    echo "=== LOG CLEANUP UTILITY ==="
    
    local log_dirs=("/var/log" "/tmp" "/var/tmp")
    local days_old=7
    local dry_run=${1:-false}
    
    echo "Log cleanup configuration:"
    echo "  Directories: ${log_dirs[*]}"
    echo "  Remove files older than: $days_old days"
    echo "  Dry run mode: $dry_run"
    echo ""
    
    for log_dir in "${log_dirs[@]}"; do
        if [ ! -d "$log_dir" ]; then
            echo "Directory not found: $log_dir"
            continue
        fi
        
        echo "Processing directory: $log_dir"
        
        # Find old log files
        local old_files=$(find "$log_dir" -name "*.log*" -type f -mtime +$days_old 2>/dev/null)
        local file_count=$(echo "$old_files" | grep -c . || echo "0")
        
        if [ "$file_count" -eq 0 ]; then
            echo "  No old log files found"
            continue
        fi
        
        echo "  Found $file_count old log files"
        
        if [ "$dry_run" = "true" ]; then
            echo "  Files that would be removed:"
            echo "$old_files" | sed 's/^/    /'
        else
            echo "  Removing old log files..."
            echo "$old_files" | while read -r file; do
                if [ -f "$file" ]; then
                    rm "$file"
                    echo "    Removed: $file"
                fi
            done
        fi
        echo ""
    done
    
    echo "Log cleanup completed"
}

# User account audit
user_account_audit() {
    echo "=== USER ACCOUNT AUDIT ==="
    
    echo "System user account summary:"
    echo "============================"
    
    # Count different types of accounts
    local total_accounts=$(wc -l < /etc/passwd)
    local system_accounts=$(awk -F: '$3<1000{print $1}' /etc/passwd | wc -l)
    local user_accounts=$((total_accounts - system_accounts))
    
    echo "Total accounts: $total_accounts"
    echo "System accounts: $system_accounts"
    echo "User accounts: $user_accounts"
    echo ""
    
    # Show user accounts with details
    echo "User accounts (UID >= 1000):"
    echo "============================="
    printf "%-15s %-8s %-20s %-20s %s\n" "Username" "UID" "Home Directory" "Shell" "Last Login"
    echo "--------------------------------------------------------------------------------"
    
    awk -F: '$3>=1000 && $1!="nobody"{print $1, $3, $6, $7}' /etc/passwd | while read -r username uid homedir shell; do
        # Get last login info
        local last_login="Never"
        if command -v lastlog >/dev/null 2>&1; then
            last_login=$(lastlog -u "$username" 2>/dev/null | tail -n 1 | awk '{for(i=4;i<=NF;i++) printf "%s ", $i; print ""}' | xargs)
            if [ -z "$last_login" ] || [[ "$last_login" == *"Never logged in"* ]]; then
                last_login="Never"
            fi
        fi
        
        printf "%-15s %-8s %-20s %-20s %s\n" "$username" "$uid" "$homedir" "$shell" "$last_login"
    done
    
    echo ""
    
    # Check for accounts with no password
    echo "Accounts without password:"
    echo "=========================="
    local no_password_accounts=$(awk -F: '$2=="" || $2=="*" || $2=="!"' /etc/shadow 2>/dev/null | cut -d: -f1 || echo "Cannot check (permission denied)")
    
    if [ "$no_password_accounts" = "Cannot check (permission denied)" ]; then
        echo "$no_password_accounts"
    else
        echo "$no_password_accounts" | head -10
    fi
    
    echo ""
    
    # Check for duplicate UIDs
    echo "Checking for duplicate UIDs:"
    echo "============================"
    local duplicate_uids=$(awk -F: '{print $3}' /etc/passwd | sort | uniq -d)
    
    if [ -z "$duplicate_uids" ]; then
        echo "✓ No duplicate UIDs found"
    else
        echo "⚠ WARNING: Duplicate UIDs found:"
        echo "$duplicate_uids"
    fi
    
    echo ""
    echo "User account audit completed"
}

# Run system administration demos
echo "Running System Administration Scripts..."
echo ""

system_health_monitor

echo ""
echo "=========================================="
echo ""

# Run log cleanup in dry-run mode
log_cleanup true

echo ""
echo "=========================================="
echo ""

user_account_audit
```

---

## Automation Examples

Practical automation scripts for common tasks.

### Automated Backup System
```bash
#!/bin/bash

# Comprehensive backup automation system
automated_backup_system() {
    echo "=== AUTOMATED BACKUP SYSTEM ==="
    
    # Configuration
    local config_file="backup.conf"
    local default_backup_dir="./backups"
    local default_retention_days=7
    local log_file="backup.log"
    
    # Create default configuration if it doesn't exist
    create_default_config() {
        if [ ! -f "$config_file" ]; then
            cat > "$config_file" << EOF
# Backup Configuration File
# Format: source_path:destination_name:backup_type
# backup_type: full, incremental, differential

/home/user/documents:documents:full
/home/user/pictures:pictures:incremental  
/etc:system_config:full
/var/www:website:differential
EOF
            echo "Created default configuration: $config_file"
        fi
    }
    
    # Logging function
    log_message() {
        local level=$1
        local message=$2
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        
        echo "[$timestamp] [$level] $message" | tee -a "$log_file"
    }
    
    # Create backup directory structure
    setup_backup_environment() {
        local backup_base_dir=${1:-$default_backup_dir}
        
        mkdir -p "$backup_base_dir"/{full,incremental,differential}
        mkdir -p "$backup_base_dir/logs"
        
        log_message "INFO" "Backup environment setup completed"
    }
    
    # Full backup function
    perform_full_backup() {
        local source_path=$1
        local dest_name=$2
        local backup_base_dir=${3:-$default_backup_dir}
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup_file="$backup_base_dir/full/${dest_name}_full_${timestamp}.tar.gz"
        
        log_message "INFO" "Starting full backup: $source_path -> $backup_file"
        
        if [ ! -d "$source_path" ] && [ ! -f "$source_path" ]; then
            log_message "ERROR" "Source path does not exist: $source_path"
            return 1
        fi
        
        # Create backup with compression and progress
        if tar -czf "$backup_file" -C "$(dirname "$source_path")" "$(basename "$source_path")" 2>/dev/null; then
            local size=$(ls -lh "$backup_file" | awk '{print $5}')
            log_message "INFO" "Full backup completed: $backup_file ($size)"
            
            # Create metadata file
            cat > "${backup_file}.info" << EOF
Backup Type: Full
Source: $source_path
Created: $(date)
Size: $size
Files: $(tar -tzf "$backup_file" | wc -l)
EOF
            return 0
        else
            log_message "ERROR" "Full backup failed: $source_path"
            return 1
        fi
    }
    
    # Incremental backup function
    perform_incremental_backup() {
        local source_path=$1
        local dest_name=$2
        local backup_base_dir=${3:-$default_backup_dir}
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup_file="$backup_base_dir/incremental/${dest_name}_incremental_${timestamp}.tar.gz"
        local snapshot_file="$backup_base_dir/incremental/${dest_name}_snapshot"
        
        log_message "INFO" "Starting incremental backup: $source_path"
        
        if [ ! -d "$source_path" ] && [ ! -f "$source_path" ]; then
            log_message "ERROR" "Source path does not exist: $source_path"
            return 1
        fi
        
        # Create incremental backup (files newer than snapshot)
        local tar_options="-czf $backup_file"
        if [ -f "$snapshot_file" ]; then
            tar_options="$tar_options --newer-mtime=$(cat "$snapshot_file")"
        fi
        
        if tar $tar_options -C "$(dirname "$source_path")" "$(basename "$source_path")" 2>/dev/null; then
            local size=$(ls -lh "$backup_file" | awk '{print $5}')
            log_message "INFO" "Incremental backup completed: $backup_file ($size)"
            
            # Update snapshot timestamp
            date > "$snapshot_file"
            
            # Create metadata
            cat > "${backup_file}.info" << EOF
Backup Type: Incremental
Source: $source_path
Created: $(date)
Size: $size
Files: $(tar -tzf "$backup_file" | wc -l)
Since: $(cat "$snapshot_file")
EOF
            return 0
        else
            log_message "ERROR" "Incremental backup failed: $source_path"
            return 1
        fi
    }
    
    # Cleanup old backups
    cleanup_old_backups() {
        local backup_base_dir=${1:-$default_backup_dir}
        local retention_days=${2:-$default_retention_days}
        
        log_message "INFO" "Starting cleanup of backups older than $retention_days days"
        
        local cleanup_count=0
        for backup_type in full incremental differential; do
            local backup_dir="$backup_base_dir/$backup_type"
            
            if [ -d "$backup_dir" ]; then
                # Find and remove old backups
                find "$backup_dir" -name "*.tar.gz" -type f -mtime +$retention_days | while read -r old_backup; do
                    rm -f "$old_backup"
                    rm -f "${old_backup}.info"
                    log_message "INFO" "Removed old backup: $(basename "$old_backup")"
                    ((cleanup_count++))
                done
            fi
        done
        
        log_message "INFO" "Cleanup completed: $cleanup_count files removed"
    }
    
    # Backup verification
    verify_backup() {
        local backup_file=$1
        
        log_message "INFO" "Verifying backup: $backup_file"
        
        if [ ! -f "$backup_file" ]; then
            log_message "ERROR" "Backup file not found: $backup_file"
            return 1
        fi
        
        # Test archive integrity
        if tar -tzf "$backup_file" >/dev/null 2>&1; then
            log_message "INFO" "Backup verification successful: $backup_file"
            return 0
        else
            log_message "ERROR" "Backup verification failed: $backup_file"
            return 1
        fi
    }
    
    # Main backup execution
    run_backup_job() {
        local backup_base_dir=${1:-$default_backup_dir}
        
        log_message "INFO" "Starting backup job"
        
        local successful_backups=0
        local failed_backups=0
        
        # Read configuration and perform backups
        while IFS=':' read -r source_path dest_name backup_type; do
            # Skip comments and empty lines
            [[ $source_path =~ ^[[:space:]]*# ]] && continue
            [[ -z $source_path ]] && continue
            
            case $backup_type in
                "full")
                    if perform_full_backup "$source_path" "$dest_name" "$backup_base_dir"; then
                        ((successful_backups++))
                    else
                        ((failed_backups++))
                    fi
                    ;;
                "incremental")
                    if perform_incremental_backup "$source_path" "$dest_name" "$backup_base_dir"; then
                        ((successful_backups++))
                    else
                        ((failed_backups++))
                    fi
                    ;;
                "differential")
                    log_message "INFO" "Differential backup not implemented yet for: $source_path"
                    ;;
                *)
                    log_message "ERROR" "Unknown backup type: $backup_type"
                    ((failed_backups++))
                    ;;
            esac
        done < "$config_file"
        
        log_message "INFO" "Backup job completed: $successful_backups successful, $failed_backups failed"
        
        # Cleanup old backups
        cleanup_old_backups "$backup_base_dir"
        
        return $failed_backups
    }
    
    # Backup status report
    generate_backup_report() {
        local backup_base_dir=${1:-$default_backup_dir}
        
        echo ""
        echo "=== BACKUP STATUS REPORT ==="
        echo "Generated: $(date)"
        echo ""
        
        for backup_type in full incremental differential; do
            local backup_dir="$backup_base_dir/$backup_type"
            
            echo "$backup_type Backups:"
            echo "$(echo "$backup_type" | tr '[:lower:]' '[:upper:]' | sed 's/./=/g')=========="
            
            if [ -d "$backup_dir" ]; then
                local backup_count=$(find "$backup_dir" -name "*.tar.gz" -type f | wc -l)
                
                if [ $backup_count -eq 0 ]; then
                    echo "No $backup_type backups found"
                else
                    echo "Found $backup_count $backup_type backup(s):"
                    find "$backup_dir" -name "*.tar.gz" -type f -printf "%TY-%Tm-%Td %TH:%TM %10s %f\n" | sort -r | head -5 | while read -r date time size filename; do
                        printf "  %-19s %10s  %s\n" "$date $time" "$size" "$filename"
                    done
                    
                    if [ $backup_count -gt 5 ]; then
                        echo "  ... and $((backup_count - 5)) more"
                    fi
                fi
            else
                echo "Backup directory not found: $backup_dir"
            fi
            echo ""
        done
        
        # Show recent log entries
        echo "Recent Log Entries:"
        echo "==================="
        if [ -f "$log_file" ]; then
            tail -10 "$log_file"
        else
            echo "No log file found"
        fi
    }
    
    # Demo the backup system
    echo "Setting up backup system demo..."
    
    # Create test data
    mkdir -p test_data/{documents,pictures,config}
    echo "Important document" > test_data/documents/readme.txt
    echo "Business plan" > test_data/documents/business.doc
    echo "Photo metadata" > test_data/pictures/photos.txt
    echo "app_config=production" > test_data/config/app.conf
    
    # Create configuration
    cat > "$config_file" << EOF
# Demo backup configuration
test_data/documents:documents:full
test_data/pictures:pictures:incremental
test_data/config:config:full
EOF
    
    # Setup and run backup
    setup_backup_environment
    run_backup_job
    
    # Generate report
    generate_backup_report
    
    echo ""
    echo "Backup system demo completed!"
    echo "Check the backups directory and backup.log file for results"
}

# Development environment setup automation
dev_environment_setup() {
    echo ""
    echo "=== DEVELOPMENT ENVIRONMENT SETUP ==="
    
    # Configuration
    local setup_log="setup.log"
    
    # Logging function
    setup_log_message() {
        local level=$1
        local message=$2
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        
        echo "[$timestamp] [$level] $message" | tee -a "$setup_log"
    }
    
    # Check if command exists
    command_exists() {
        command -v "$1" >/dev/null 2>&1
    }
    
    # Install package (simulation)
    install_package() {
        local package=$1
        
        setup_log_message "INFO" "Installing package: $package"
        
        # Simulate package installation
        sleep 1
        setup_log_message "INFO" "Package# Complete Shell Scripting Guide
