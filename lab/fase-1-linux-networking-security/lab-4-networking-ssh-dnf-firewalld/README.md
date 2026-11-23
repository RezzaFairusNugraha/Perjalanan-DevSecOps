# Hands-On Lab 4: Networking (`ss`, `curl`), SSH Keys, `scp`, Package Management (`dnf`/`rpm`) & `firewalld`

Welcome to **Lab 4** of Phase 1 (aligned with **Red Hat EX188** & Enterprise Linux Networking/Security)!

This lab tests the core networking and security skills from Udemy Module 7 (Lectures 147–187) plus your hands-on firewall experiments:
- **Package Management (`dnf` & `rpm` — Lecture 164):** Installing network utilities (`bind-utils`) and querying installed RPM package versions.
- **Socket Inspection & Endpoint Testing (`ss -tulpn` & `curl` — Lectures 156–157):** Inspecting listening TCP ports and verifying a local web microservice.
- **SSH Keys & `scp` File Transfer (Lectures 153–155 & 160):** Generating a passwordless SSH key pair, authorizing it locally, and transferring configuration files over SSH using `scp`.
- **Firewall Management (`firewalld` / `firewall-cmd` — Lecture 187):** Unmasking/enabling `firewalld`, opening container ports (`8091/tcp`) and services (`http`) permanently, and reloading the firewall.
- **Outbound Filtering (`firewall-cmd --direct`):** Blocking outbound traffic to a specific target IP (`198.51.100.99`) and inspecting active direct rules.

> 💡 **IMPORTANT:** Run all setup, administrative tasks, and grading as `root` (or with `sudo`). Switch to root first:
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
3. Run the automated grading script anytime to check your score:
   ```bash
   sudo bash grade-lab.sh
   ```

---

## 📋 Lab Tasks

### Task 1: Package Management with `dnf` and `rpm` (Lecture 164)
Ensure your server has DNS lookup tools installed and audit the installed `firewalld` package version:
1. Install the **`bind-utils`** package using `dnf` (`dnf install -y bind-utils`) so tools like `host`, `dig`, and `nslookup` are available.
2. Query the exact installed RPM package string for **`firewalld`** using `rpm -q firewalld`, and save the output into **`/opt/ex188-lab4/reports/rpm-firewalld.txt`**.

---

### Task 2: Inspect Listening Ports (`ss`) & Test Web Endpoint (`curl`) (Lectures 156–157)
The setup script launched a background web microservice listening on TCP port **`8091`**.
1. Use **`ss -tulpn`** combined with `grep 8091` to find the listening socket on port `8091`, and save the matching line(s) into **`/opt/ex188-lab4/reports/port-8091.txt`**.
2. Use **`curl`** to fetch **`http://127.0.0.1:8091/index.html`** and save the response content into **`/opt/ex188-lab4/reports/curl-response.txt`**.

---

### Task 3: Passwordless SSH Keys & Secure Copy (`scp`) (Lectures 153–155 & 160)
Configure key-based SSH authentication and transfer a staged configuration file using `scp`:
1. Generate a new **Ed25519** SSH key pair with **no passphrase** (`-N ""`) at **`/opt/ex188-lab4/ssh/id_ex188`**:
   ```bash
   ssh-keygen -t ed25519 -N "" -f /opt/ex188-lab4/ssh/id_ex188
   ```
2. Authorize this key for `root` by appending the public key (`/opt/ex188-lab4/ssh/id_ex188.pub`) to **`/root/.ssh/authorized_keys`** and ensuring strict permissions (`chmod 700 /root/.ssh` and `chmod 600 /root/.ssh/authorized_keys`).
3. Use **`scp`** with your new private key (`-i /opt/ex188-lab4/ssh/id_ex188`) to copy **`/opt/ex188-lab4/staging/secret-payload.conf`** to **`root@127.0.0.1:/opt/ex188-lab4/deployed-payload.conf`**:
   ```bash
   scp -i /opt/ex188-lab4/ssh/id_ex188 -o StrictHostKeyChecking=no /opt/ex188-lab4/staging/secret-payload.conf root@127.0.0.1:/opt/ex188-lab4/deployed-payload.conf
   ```

---

### Task 4: Open Container Ports with `firewalld` (`firewall-cmd`) (Lecture 187)
Expose port `8091/tcp` and the `http` service through the host firewall:
1. Ensure `firewalld` is unmasked, enabled, and currently running:
   ```bash
   systemctl unmask firewalld
   systemctl enable --now firewalld
   ```
2. Permanently allow TCP port **`8091/tcp`** and the **`http`** service:
   ```bash
   firewall-cmd --add-port=8091/tcp --permanent
   firewall-cmd --add-service=http --permanent
   ```
3. Reload the firewall configuration so the permanent rules take effect immediately:
   ```bash
   firewall-cmd --reload
   ```
4. Save the output of `firewall-cmd --list-all` into **`/opt/ex188-lab4/reports/firewall-status.txt`**.

---

### Task 5: Outbound IP Blocking with `firewalld` Direct Rules
Practice blocking outbound connections to a specific external test IP (`198.51.100.99`) and auditing direct rules:
1. Add a runtime direct rule to **DROP** outbound IPv4 traffic to destination **`198.51.100.99`**:
   ```bash
   firewall-cmd --direct --add-rule ipv4 filter OUTPUT 0 -d 198.51.100.99 -j DROP
   ```
2. Verify all active direct rules using `firewall-cmd --direct --get-all-rules` and save the output into **`/opt/ex188-lab4/reports/direct-rules.txt`**.
