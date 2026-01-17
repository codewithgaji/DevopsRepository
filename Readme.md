# DevOps Bash Scripting Learning

Welcome to **Gaji’s Bash Scripting Repository** 👋  
This repository contains Bash scripts I wrote while learning **Linux, Bash scripting, and DevOps fundamentals**.

The goal of this repo is to demonstrate:
- Practical Bash scripting
- Linux process and memory monitoring
- Service health checks
- Use of variables, command substitution, and conditionals
- Automation using `cron`

---

## 📌 What I Learned

Through these scripts, I practiced and understood:

- Bash shebang (`#!/bin/bash`)
- Variables and environment variables
- Command substitution
- `awk`, `grep`, and basic Linux utilities
- Process and service monitoring
- Memory (RAM) monitoring
- Conditional logic (`if`, `elif`, `else`)
- Automation using `crontab`

---

## 📂 Scripts Overview

### 1️⃣ HTTPD Service Monitor (`12_yktest.sh`)

**What it does:**
- Navigates through directories for demonstration purposes
- Lists available scripts
- Checks the status of the Apache (`httpd`) service
- Automatically starts `httpd` if it is **inactive**
- Displays clear and user-friendly output

**Key concepts used:**
- `systemctl`
- Conditional statements
- Process status monitoring
- Sleep timers for readability

📌 This script can be automated using `crontab` to ensure Apache is always running.

---

### 2️⃣ System Welcome & RAM Monitor (`welcome.sh`)

**What it does:**
- Greets the current user
- Displays:
  - Free RAM available (in MB)
  - System hostname
  - System uptime
  - Files in the current directory

**Key concepts used:**
- Command substitution
- System monitoring
- Linux utilities (`free`, `uptime`, `whoami`)
- Readable output formatting

---

## ⏱ Automation with Cron

The HTTPD monitoring script can be scheduled to run every minute:

```bash
crontab -e
# Example cron entry:
* * * * * /opt/scripts/12_yktest.sh
```
This ensures the Apache service is automatically restarted if it stops.

## 🚀 Purpose of This Repository

This repository documents my hands-on DevOps learning journey, focusing on:

Linux administration

Bash scripting

Automation

Real-world system monitoring

More scripts and DevOps projects will be added as I continue learning.

## 👤 Author

Gaji Yaqub Ayomikun
Computer Science Student | DevOps Engineer
X (Twitter): [@codewithgaji](https://x.com/codewithgaji)

