# Solutions & Command Reference for Lab 5 (Grand Capstone)

Use this reference guide to check your solutions or troubleshoot any task in **Lab 5**.

> Switch to root before running the commands:
> ```bash
> sudo -i
> ```

---

### Solution for Task 1 (Section 1): File Maintenance, `grep`/`tee` & `vi`/`vim`
```bash
# 1. Create directory structure
mkdir -p /opt/ex188-capstone/{src,html,logs,reports}

# 2. Filter STATUS=500 or STATUS=503 with grep -E and pipe to tee
grep -E "STATUS=500|STATUS=503" /tmp/capstone-staging/raw-access.log | tee /opt/ex188-capstone/logs/critical-http.log

# 3. Create web payload
echo "EX188_CAPSTONE_WEB_OK" > /opt/ex188-capstone/html/index.html

# 4. Create Containerfile using vi / vim (or cat for verification)
vi /opt/ex188-capstone/src/Containerfile
```
Exact 6 lines to put inside `/opt/ex188-capstone/src/Containerfile`:
```dockerfile
FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
LABEL exam="EX188-CAPSTONE"
WORKDIR /var/www/html
USER 1001
EXPOSE 8080
CMD ["python3", "-m", "http.server", "8080"]
```

---

### Solution for Task 2 (Section 2): User, Group & SGID Shared Directory
```bash
# 1. Create group capteam and user capuser (UID 1088)
groupadd capteam
useradd -u 1088 -G capteam capuser

# 2. Save id output
id capuser > /opt/ex188-capstone/reports/capuser-id.txt

# 3. Set group ownership and SGID 2775 on /opt/ex188-capstone/html
chown :capteam /opt/ex188-capstone/html
chmod 2775 /opt/ex188-capstone/html
```

---

### Solution for Task 3 (Section 3): `kill -9`, Environment File, `systemctl`, `journalctl` & `df`
```bash
# 1. Find stuck job PID, save it, and terminate with SIGKILL (-9)
PID=$(pgrep -f capstone-stuck-job.sh)
echo "$PID" > /opt/ex188-capstone/reports/killed-pid.txt
kill -9 "$PID"

# 2. Create capstone.env
cat << 'EOF' > /opt/ex188-capstone/capstone.env
CAPSTONE_MODE=active
LISTEN_PORT=8095
EOF

# 3. Reload systemd and enable + start ex188-capstone.service
systemctl daemon-reload
systemctl enable --now ex188-capstone.service

# 4. Extract journalctl readiness log
journalctl -u ex188-capstone.service --no-pager | grep "CAPSTONE_SERVICE_READY" > /opt/ex188-capstone/reports/journal-capstone.txt

# 5. Save root disk usage
df -h / > /opt/ex188-capstone/reports/disk.txt
```

---

### Solution for Task 4 (Section 4): `ss`, `curl`, SSH Keys, `scp` & `firewalld`
```bash
# 1. Inspect port 8095 with ss -tulpn and test endpoint with curl
ss -tulpn | grep 8095 > /opt/ex188-capstone/reports/port-8095.txt
curl -s http://127.0.0.1:8095/index.html > /opt/ex188-capstone/reports/curl-8095.txt

# 2. Generate Ed25519 SSH key, authorize it, and copy Containerfile via scp
ssh-keygen -t ed25519 -N "" -f /opt/ex188-capstone/id_capstone
cat /opt/ex188-capstone/id_capstone.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
scp -i /opt/ex188-capstone/id_capstone -o StrictHostKeyChecking=no \
  /opt/ex188-capstone/src/Containerfile \
  root@127.0.0.1:/opt/ex188-capstone/reports/Containerfile.scp

# 3. Open 8095/tcp permanently in firewalld and save status
systemctl unmask firewalld 2>/dev/null
systemctl enable --now firewalld
firewall-cmd --add-port=8095/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-all > /opt/ex188-capstone/reports/firewall.txt
```

---

### Solution for Task 5 (Section 5): SELinux Context (`container_file_t`) & Podman
```bash
# 1. Save current SELinux enforcement mode
getenforce > /opt/ex188-capstone/reports/selinux-mode.txt

# 2. Apply container_file_t SELinux type recursively to /opt/ex188-capstone/html
chcon -Rt container_file_t /opt/ex188-capstone/html

# 3. Verify and save SELinux context
ls -Zd /opt/ex188-capstone/html > /opt/ex188-capstone/reports/selinux-context.txt

# 4. Ensure podman is installed and save its version
dnf install -y podman 2>/dev/null
podman --version > /opt/ex188-capstone/reports/podman-version.txt
```

---

### Run Auto-Grader:
```bash
sudo bash grade-lab.sh
```
Expected result: **`FINAL CAPSTONE SCORE: 5 / 5`** 🎉
