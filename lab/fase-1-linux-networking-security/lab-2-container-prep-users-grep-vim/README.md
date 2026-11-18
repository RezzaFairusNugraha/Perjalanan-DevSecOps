# Hands-On Lab 2 (v2): EX188 Advanced Prep — Containerfile, Multi-Target grep, vi/vim, User SubUIDs & Shared SGID

Welcome to **Lab 2 (Reset / Re-practice Edition)**!  
This lab scenario has been updated to be more challenging and aligned with the official **Red Hat Certified Specialist in Containers (EX188)** exam style.

This lab evaluates:
- File and directory operations (`mkdir -p`, `cp`, `mv`, `rm`).
- Multi-pattern log filtering using `grep -E` (regex), `tail`, and standard output redirection.
- Writing a microservice **`Containerfile`** directly from the terminal using **`vi` / `vim`**.
- Non-root user management (`useradd`, `groupadd`, `usermod`, `id`) and verifying **SubUID / SubGID** allocations (the bedrock of *Rootless Containers* on RHEL/Podman).
- Advanced directory security permissions: **SGID** (`2770`) and **Sticky Bit** (`1777`) with group inheritance validation.

> 💡 **IMPORTANT:** All setup, grading, and configuration tasks in this lab require root privileges. Execute commands with `sudo` or switch to the root environment beforehand:
> ```bash
> sudo -i
> ```

---

## 🚀 How to Start / Reset the Lab

1. Run the setup script to initialize or reset the clean lab environment:
   ```bash
   sudo bash setup-lab.sh
   ```
2. Complete **Task 1** through **Task 5** independently inside your VM terminal.
3. Run the automated grading script anytime to verify your score:
   ```bash
   sudo bash grade-lab.sh
   ```

---

## 📋 Lab Tasks

### Task 1: Staging Storage & File Operations (`mkdir -p`, `mv`, `cp`, `rm`)
Prepare the host directory structure that will later be mounted into container volumes:
1. Create the following directories:
   - `/opt/container-lab/app/data`
   - `/opt/container-lab/app/conf`
2. Move the configuration file `/tmp/staging-ex188/app.conf` to `/opt/container-lab/app/conf/app.conf`.
3. Copy the template file `/tmp/staging-ex188/default.env` to `/opt/container-lab/app/conf/.env` (as a hidden file).
4. Remove the temporary staging directory `/tmp/staging-ex188` along with all its contents (`rm -rf`).

---

### Task 2: Log Extraction & Analysis (`cat`, `tail`, `grep`, `egrep`)
The setup routine generated a realistic container log at **`/opt/container-lab/logs/podman-service.log`**.
1. Search for all log entries containing either **`CRITICAL`** or **`FATAL`** (case-sensitive) using `grep -E` (or `egrep`), and redirect the output to **`/opt/container-lab/logs/alerts.txt`**.
2. Search for all lines recording internal container IP addresses marked with **`REMOTE_ADDR=`**, and redirect the output to **`/opt/container-lab/logs/connections.txt`**.
3. Extract exactly the **last 5 lines** of `/opt/container-lab/logs/podman-service.log` using `tail -n 5`, and redirect them to **`/opt/container-lab/logs/recent.txt`**.

---

### Task 3: Author a Custom `Containerfile` Using `vi` / `vim`
Train your ability to compose container definitions directly inside a terminal without a mouse or GUI:
1. Create and open **`/opt/container-lab/Containerfile`** using:
   ```bash
   vi /opt/container-lab/Containerfile
   ```
2. Press `i` to enter Insert mode, then type the exact 6 lines below:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
   LABEL maintainer="student@ex188.lab"
   WORKDIR /app
   USER 1001
   EXPOSE 8080
   CMD ["python3", "-m", "http.server", "8080"]
   ```
3. Press `Esc`, type `:wq`, and press `Enter` to save and exit.
4. Verify the file contents using:
   ```bash
   cat /opt/container-lab/Containerfile
   ```

---

### Task 4: User Management & Rootless SubUID Verification (`groupadd`, `useradd`, `id`)
In the EX188 exam, container workloads must be executed by non-root users:
1. Create a new supplementary group named **`engineers`**.
2. Create a new user named **`apprunner`** with:
   - Specific UID: **`1024`**
   - Supplementary group: **`engineers`**
   *(Example command: `useradd -u 1024 -G engineers apprunner`)*.
3. Save the full identity output of `id apprunner` into **`/opt/container-lab/logs/apprunner-info.txt`**.
4. Verify that user `apprunner` has been allocated subordinate UIDs in the system by inspecting:
   ```bash
   grep apprunner /etc/subuid
   ```

---

### Task 5: Special Security Permissions — SGID & Sticky Bit (`chmod`, `chown`)
Configure secure shared directories for collaborative container workflows:
1. Create two directories:
   - `/opt/container-lab/shared-workspace`
   - `/opt/container-lab/public-drop`
2. Change the group ownership of `/opt/container-lab/shared-workspace` to group **`engineers`** (`chown :engineers ...`).
3. Set the **SGID** permission with numeric mode **`2770`** on `/opt/container-lab/shared-workspace` (ensuring all new files created inside inherit group `engineers`).
4. Set the **Sticky Bit** permission with numeric mode **`1777`** on `/opt/container-lab/public-drop` (allowing users to create files while preventing deletion of files owned by others).
5. Verify both permissions:
   ```bash
   ls -ld /opt/container-lab/shared-workspace /opt/container-lab/public-drop
   ```
   *(Ensure the `s` flag appears on `shared-workspace` and the `t` flag appears on `public-drop`!)*
