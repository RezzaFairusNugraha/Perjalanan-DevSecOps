# Hands-On Lab 5 (Grand Capstone): Complete Red Hat EX188 Prerequisite Mock Exam (Sections 1–5 All-in-One)

Welcome to **Lab 5 — The Grand Capstone Lab**!  
This comprehensive exam simulation integrates **all 5 core pillars (Sections 1 through 5)** into one end-to-end scenario:

- **Section 1 (Text, I/O Redirects, `grep`, Pipes, `tee` & `vi`/`vim`):** Building directory trees, filtering multi-pattern logs with `grep -E` + `tee`, and writing a `Containerfile` with `vi`/`vim`.
- **Section 2 (Users, Groups, UID & Special Permissions):** Creating a dedicated non-root user/group and securing shared web storage with **SGID (`2775`)**.
- **Section 3 (Processes, Signals, Systemd, `journalctl` & Environment Variables):** Hunting and killing a stuck background process with `SIGKILL` (`kill -9`), creating an `EnvironmentFile`, enabling a systemd service (`systemctl enable --now`), and auditing `journalctl` & disk usage (`df -h`).
- **Section 4 (Networking `ss`, `curl`, SSH Keys, `scp` & `firewalld`):** Inspecting listening sockets (`ss -tulpn`), testing endpoints (`curl`), transferring files passwordlessly via `scp`, and opening ports permanently in `firewalld`.
- **Section 5 (Containers `podman` & SELinux Context):** Auditing SELinux enforcement mode (`getenforce`), applying the `container_file_t` SELinux label (used by Podman `:Z` mounts), and verifying Podman readiness.

> 💡 **IMPORTANT:** Run all setup, tasks, and grading as `root` (or with `sudo`). Switch to root first:
> ```bash
> sudo -i
> ```

---

## 🚀 How to Start / Reset the Capstone Lab

1. Initialize or reset the clean capstone environment:
   ```bash
   sudo bash setup-lab.sh
   ```
2. Complete **Task 1** through **Task 5** below without looking at the solution if possible!
3. Run the automated grading script anytime to check your score (`5 / 5`):
   ```bash
   sudo bash grade-lab.sh
   ```

---

## 📋 Capstone Exam Tasks

### Task 1 (Section 1): File Maintenance, Log Filtering (`grep`, `tee`) & `vi`/`vim`
1. Create the following directory structure using `mkdir -p`:
   - `/opt/ex188-capstone/src`
   - `/opt/ex188-capstone/html`
   - `/opt/ex188-capstone/logs`
   - `/opt/ex188-capstone/reports`
2. Filter `/tmp/capstone-staging/raw-access.log` for all lines containing **either** **`STATUS=500`** **or** **`STATUS=503`** using `grep -E`, pipe (`|`) the output into **`tee`**, and save it to **`/opt/ex188-capstone/logs/critical-http.log`**.
3. Create the web payload file **`/opt/ex188-capstone/html/index.html`** containing the exact text:
   ```text
   EX188_CAPSTONE_WEB_OK
   ```
4. Using **`vi` / `vim`**, create **`/opt/ex188-capstone/src/Containerfile`** with these exact 6 lines:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
   LABEL exam="EX188-CAPSTONE"
   WORKDIR /var/www/html
   USER 1001
   EXPOSE 8080
   CMD ["python3", "-m", "http.server", "8080"]
   ```

---

### Task 2 (Section 2): Non-Root User, Group & SGID Shared Directory
1. Create a new group named **`capteam`**.
2. Create a new user named **`capuser`** with:
   - Specific UID: **`1088`**
   - Supplementary group: **`capteam`**
   *(Command: `useradd -u 1088 -G capteam capuser`)*.
3. Save the output of `id capuser` into **`/opt/ex188-capstone/reports/capuser-id.txt`**.
4. Change the group ownership of **`/opt/ex188-capstone/html`** to **`capteam`** (`chown :capteam ...`) and set **SGID** permissions **`2775`** (`chmod 2775 /opt/ex188-capstone/html`).

---

### Task 3 (Section 3): Process Signals (`kill -9`), Environment Variables, `systemctl` & `journalctl`
1. A stuck background process named **`capstone-stuck-job.sh`** is running and ignores `SIGTERM`.
   - Find its numeric **PID** using `ps aux | grep capstone-stuck-job` (or `pgrep -f capstone-stuck-job.sh`).
   - Save **only the numeric PID** into **`/opt/ex188-capstone/reports/killed-pid.txt`**.
   - Terminate the process forcefully using **`kill -9 <PID>`**.
2. Create the environment file **`/opt/ex188-capstone/capstone.env`** with these exact 2 lines:
   ```ini
   CAPSTONE_MODE=active
   LISTEN_PORT=8095
   ```
3. Reload systemd (`systemctl daemon-reload`) and enable + start **`ex188-capstone.service`** immediately:
   ```bash
   systemctl enable --now ex188-capstone.service
   ```
4. Extract all log lines from `journalctl -u ex188-capstone.service --no-pager` containing **`CAPSTONE_SERVICE_READY`** and save them to **`/opt/ex188-capstone/reports/journal-capstone.txt`**.
5. Save the root disk usage report (`df -h /`) to **`/opt/ex188-capstone/reports/disk.txt`**.

---

### Task 4 (Section 4): Networking (`ss`, `curl`), SSH Keys, `scp` & `firewalld`
When `ex188-capstone.service` started in Task 3, it launched a web listener on TCP port **`8095`** serving `/opt/ex188-capstone/html`.
1. Use **`ss -tulpn`** with `grep 8095` to inspect the listening port and save the output into **`/opt/ex188-capstone/reports/port-8095.txt`**.
2. Use **`curl`** to fetch **`http://127.0.0.1:8095/index.html`** and save the output into **`/opt/ex188-capstone/reports/curl-8095.txt`**.
3. Generate an **Ed25519** SSH key pair without a passphrase (`-N ""`) at **`/opt/ex188-capstone/id_capstone`**, append `/opt/ex188-capstone/id_capstone.pub` to `/root/.ssh/authorized_keys`, and use **`scp`** with that key to copy `/opt/ex188-capstone/src/Containerfile` to **`root@127.0.0.1:/opt/ex188-capstone/reports/Containerfile.scp`**.
4. Ensure `firewalld` is running, permanently allow TCP port **`8095/tcp`** (`firewall-cmd --add-port=8095/tcp --permanent`), reload `firewalld` (`firewall-cmd --reload`), and save `firewall-cmd --list-all` into **`/opt/ex188-capstone/reports/firewall.txt`**.

---

### Task 5 (Section 5): Containers (`podman`) & SELinux Container Context (`container_file_t`)
Prepare the shared HTML folder for SELinux-enforced container volume mounting and verify Podman readiness:
1. Check the current SELinux mode using `getenforce` and save the output into **`/opt/ex188-capstone/reports/selinux-mode.txt`**.
2. Change the SELinux security context type of **`/opt/ex188-capstone/html`** (recursively) to **`container_file_t`** (the exact SELinux label used by Podman `:Z` / `:z` volume mounts):
   ```bash
   chcon -Rt container_file_t /opt/ex188-capstone/html
   ```
3. Verify the SELinux context of the directory using `ls -Zd /opt/ex188-capstone/html` and save the output into **`/opt/ex188-capstone/reports/selinux-context.txt`**.
4. Ensure `podman` is installed (`dnf install -y podman` if needed) and save the output of **`podman --version`** into **`/opt/ex188-capstone/reports/podman-version.txt`**.
   - *(Optional Bonus)* If you have container images cached locally, test launching a rootless or root container mounting `/opt/ex188-capstone/html` with `:Z`!
