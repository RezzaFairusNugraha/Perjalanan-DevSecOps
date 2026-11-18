# Solutions & Command Reference for Lab 2 (v2)

Use this guide to verify your solutions or reference commands if you encounter difficulties.

> Ensure you switch to the root environment beforehand:
> ```bash
> sudo -i
> ```

---

### Solution for Task 1: Staging Storage & File Operations
```bash
# 1. Create data and conf directories
mkdir -p /opt/container-lab/app/data
mkdir -p /opt/container-lab/app/conf

# 2. Move app.conf into conf directory
mv /tmp/staging-ex188/app.conf /opt/container-lab/app/conf/app.conf

# 3. Copy default.env to hidden .env file
cp /tmp/staging-ex188/default.env /opt/container-lab/app/conf/.env

# 4. Remove old staging directory
rm -rf /tmp/staging-ex188
```

---

### Solution for Task 2: Log Extraction & Analysis
```bash
# 1. Find CRITICAL or FATAL lines
grep -E "CRITICAL|FATAL" /opt/container-lab/logs/podman-service.log > /opt/container-lab/logs/alerts.txt

# 2. Find lines matching REMOTE_ADDR=
grep "REMOTE_ADDR=" /opt/container-lab/logs/podman-service.log > /opt/container-lab/logs/connections.txt

# 3. Extract last 5 lines
tail -n 5 /opt/container-lab/logs/podman-service.log > /opt/container-lab/logs/recent.txt
```

---

### Solution for Task 3: Author a Custom `Containerfile` via `vi` / `vim`
1. Open the file:
   ```bash
   vi /opt/container-lab/Containerfile
   ```
2. Press `i` to enter Insert mode, then add the following content:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
   LABEL maintainer="student@ex188.lab"
   WORKDIR /app
   USER 1001
   EXPOSE 8080
   CMD ["python3", "-m", "http.server", "8080"]
   ```
3. Press `Esc`, then type `:wq` and press `Enter`.

---

### Solution for Task 4: User Management & SubUID
```bash
# 1. Create group engineers
groupadd engineers

# 2. Create user apprunner with UID 1024 and supplementary group engineers
useradd -u 1024 -G engineers apprunner

# 3. Save identity information
id apprunner > /opt/container-lab/logs/apprunner-info.txt
```

---

### Solution for Task 5: Special Security Permissions (SGID & Sticky Bit)
```bash
# 1. Create target directories
mkdir -p /opt/container-lab/shared-workspace
mkdir -p /opt/container-lab/public-drop

# 2. Change group ownership to engineers
chown :engineers /opt/container-lab/shared-workspace

# 3. Set SGID (2770)
chmod 2770 /opt/container-lab/shared-workspace

# 4. Set Sticky Bit (1777)
chmod 1777 /opt/container-lab/public-drop
```

---

### Verification:
```bash
bash grade-lab.sh
```
Expected result: **`FINAL SCORE: 5 / 5`** 🎉
