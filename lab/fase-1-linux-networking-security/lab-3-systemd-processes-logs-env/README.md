# Hands-On Lab 3: Systemd Services, Process Signals, Resource Monitoring, `journalctl` & Environment Variables

Welcome to **Lab 3** of Phase 1 (aligned with **Red Hat EX188** & Linux System Administration)!

This lab tests the core skills from Udemy Module 5 (Lectures 101–123):
- **`ps`, `top`, `kill` & Process Signals (Lectures 103–106):** Finding a stuck background process that ignores `SIGTERM` (`kill -15`) and terminating it forcefully with `SIGKILL` (`kill -9`).
- **Environment Variables (Lecture 123):** Configuring an environment variable file for a service and exporting a system-wide persistent variable in `/etc/profile.d/`.
- **`systemctl` Service Management (Lecture 102):** Reloading unit files, starting, enabling on boot (`enable --now`), and verifying service status.
- **System Logs & `journalctl` (Lectures 112–113):** Inspecting systemd unit logs via `journalctl -u` and filtering specific deployment tokens.
- **System Resource Monitoring (Lecture 111):** Auditing disk space (`df -h`) and memory (`free -m`) before deploying container workloads.

> 💡 **IMPORTANT:** Run all setup, administrative commands, and grading as `root` (or with `sudo`). We recommend switching to root first:
> ```bash
> sudo -i
> ```

---

## 🚀 How to Start / Reset the Lab

1. Initialize or reset the lab environment:
   ```bash
   sudo bash setup-lab.sh
   ```
2. Complete **Task 1** through **Task 5** below.
3. Run the automated grading script anytime to verify your score:
   ```bash
   sudo bash grade-lab.sh
   ```

---

## 📋 Lab Tasks

### Task 1: Process Inspection & Signals (`ps`, `grep`, `kill -9`)
The setup script launched a rogue background script named **`ex188-rogue-worker.sh`** that is consuming system resources and has been programmed to ignore standard termination signals (`SIGTERM` / signal `15`).
1. Use `ps aux | grep ex188-rogue-worker` (or `pgrep -f ex188-rogue-worker`) to find the **PID (Process ID)** of the running `/tmp/ex188-rogue-worker.sh` process.
2. Save **only the numeric PID** of that process into **`/opt/ex188-lab3/rogue-pid.txt`** (e.g., `echo 12345 > /opt/ex188-lab3/rogue-pid.txt`).
3. Terminate the process forcefully using **`SIGKILL`** (`kill -9 <PID>` or `kill -SIGKILL <PID>`).
4. Verify with `ps aux | grep ex188-rogue-worker` that the process is completely gone.

---

### Task 2: Environment Variables (`export`, Environment Files)
A custom service (`ex188-agent.service`) requires an environment configuration file before it can start, and your shell environment needs a global readiness variable.
1. Create the file **`/opt/ex188-lab3/agent.env`** (using `vi`, `cat`, or `echo`) containing these exact two lines:
   ```ini
   CONTAINER_ENV=production
   APP_PORT=9090
   ```
2. Create a global shell profile script at **`/etc/profile.d/ex188.sh`** containing this exact line:
   ```bash
   export EX188_READY=true
   ```
3. Load the new profile script into your current shell session (`source /etc/profile.d/ex188.sh`) and verify with `echo $EX188_READY`.

---

### Task 3: Manage Services with `systemctl` (`daemon-reload`, `enable --now`, `status`)
A systemd service unit file has been placed at `/etc/systemd/system/ex188-agent.service`. It reads `/opt/ex188-lab3/agent.env` (which you created in Task 2).
1. Reload the systemd manager configuration so it recognizes unit changes:
   ```bash
   systemctl daemon-reload
   ```
2. Enable and start the **`ex188-agent.service`** in a single command (or two steps) so that it is currently running **and** configured to start automatically at boot:
   ```bash
   systemctl enable --now ex188-agent.service
   ```
3. Verify that the service is **`active (running)`** using `systemctl status ex188-agent.service`.

---

### Task 4: Inspect Systemd Logs with `journalctl` (`journalctl -u`, `grep`)
When `ex188-agent.service` starts with the environment variables from Task 2, it writes a verification message containing `TOKEN=EX188-SYSTEMD-OK` to the systemd journal.
1. View the service logs using:
   ```bash
   journalctl -u ex188-agent.service
   ```
2. Filter the output of `journalctl -u ex188-agent.service --no-pager` using **`grep`** to find all lines containing **`EX188-SYSTEMD-OK`**, and save those lines into **`/opt/ex188-lab3/reports/journal-agent.log`**.

---

### Task 5: System Resource Monitoring (`df -h`, `free -m`)
Before launching container workloads on a host, you must capture a baseline report of disk and memory usage:
1. Run `df -h /` (human-readable disk usage for the root `/` filesystem) and save the output into **`/opt/ex188-lab3/reports/disk-usage.txt`**.
2. Run `free -m` (memory usage in megabytes) and save the output into **`/opt/ex188-lab3/reports/memory-usage.txt`**.
