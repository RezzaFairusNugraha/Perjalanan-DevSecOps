# Hands-On Lab 2: Container Prep — File Maintenance, grep, vi/vim, Users & Special Permissions

Welcome to **Lab 2** (Red Hat EX188 & DevSecOps style)!  
This lab tests everything you studied: `mkdir -p`, `cp`, `mv`, `rm`, `cat`, `tail`, `grep`/`egrep`, `vi`/`vim`, `useradd`, `usermod`, `groupadd`, `id`, `su`/`sudo`, and Special Permissions (**SGID** & **Sticky Bit**).

> **Note:** Because this lab creates system users, groups, and directories under `/opt`, run the setup and grading scripts with **`sudo`** (or switch to root using `sudo -i` / `su -` so redirects like `>` work cleanly inside `/opt`).

---

## How to Use This Lab
1. Initialize/reset the lab environment:
   ```bash
   sudo bash setup-lab.sh
   ```
2. Complete **Task 1** through **Task 5** below (use `sudo` when modifying `/opt` or creating users/groups).
3. Grade your work anytime:
   ```bash
   sudo bash grade-lab.sh
   ```

---

## Tasks

### Task 1: File Maintenance & Bind Mount Prep (`mkdir -p`, `mv`, `rm`)
Prepare host directories that will later be used for container bind mounts:
1. Create both `/opt/container-lab/web/html` and `/opt/container-lab/logs` using `mkdir -p`.
2. Move `/tmp/staging-data/index.html` into `/opt/container-lab/web/html/index.html`.
3. Remove the unnecessary temporary file `/tmp/staging-data/old-trash.tmp`.

---

### Task 2: Log Inspection & Filtering (`cat`, `tail`, `grep`, `egrep`)
The setup script generated a realistic container log file at **`/opt/container-lab/logs/podman-app.log`**.
1. Inspect the file using `cat` or `less`.
2. Use **`grep`** to find all lines containing the exact word `ERROR` in `/opt/container-lab/logs/podman-app.log`, and save them to `/opt/container-lab/logs/errors.txt`.
3. Use **`egrep`** (or `grep -E`) to find all lines containing **either** `IP=` **or** `PORT=` in `/opt/container-lab/logs/podman-app.log`, and save them to `/opt/container-lab/logs/network.txt`.
4. Use **`tail`** to save only the **last 3 lines** of `/opt/container-lab/logs/podman-app.log` into `/opt/container-lab/logs/latest.txt`.

---

### Task 3: Create a `Containerfile` with `vi` / `vim`
Practice editing files directly in the terminal (no mouse/GUI, just like the EX188 exam!):
1. Open **`/opt/container-lab/Containerfile`** using `vi` or `vim`.
2. Press `i` to enter Insert mode, and write the exact 4 lines below:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi-minimal
   USER 1001
   EXPOSE 8080
   CMD ["echo", "Hello EX188"]
   ```
3. Press `Esc`, type `:wq`, and press `Enter` to save and quit.
4. Verify your work using `cat /opt/container-lab/Containerfile`.

---

### Task 4: Non-Root User & Group Management (`groupadd`, `useradd`, `usermod`, `id`)
Prepare a dedicated non-root user for running rootless containers:
1. Create a new group named **`devteam`**.
2. Create a new user named **`poduser`** with a specific UID of **`1050`** (`useradd -u 1050 poduser`).
3. Add `poduser` to the supplementary group **`devteam`** (`usermod -aG devteam poduser`).
4. Verify the user's UID and groups using `id poduser`, and save the output into **`/opt/container-lab/logs/poduser-id.txt`**.
5. *(Practice)* Switch to `poduser` using `sudo su - poduser`, run `whoami` and `id`, then type `exit` to return.

---

### Task 5: Special Permissions — SGID & Sticky Bit (`chown`, `chmod`)
Configure secure shared directories for team collaboration:
1. Create two directories:
   - `/opt/container-lab/shared-team`
   - `/opt/container-lab/shared-drop`
2. Change the group owner of `/opt/container-lab/shared-team` to **`devteam`** (`chown :devteam ...`).
3. Apply **SGID** with `770` permissions on `/opt/container-lab/shared-team` (**numeric mode: `2770`**) so every new file created inside inherits the `devteam` group.
4. Apply the **Sticky Bit** with `777` permissions on `/opt/container-lab/shared-drop` (**numeric mode: `1777`**) so users can only delete their own files.
5. Verify both directories with `ls -ld /opt/container-lab/shared-*` (look for the `s` and `t` flags!).
