# Solutions & Command Reference for Lab 3

Use this reference guide if you want to check your commands or get stuck while working on **Lab 3**.

> Switch to root before running the commands:
> ```bash
> sudo -i
> ```

---

### Solution for Task 1: Process Inspection & Signals (`ps`, `kill -9`)
```bash
# 1. Inspect the running rogue worker process to find its PID
ps aux | grep ex188-rogue-worker

# (Or grab the numeric PID directly using pgrep)
PID=$(pgrep -f ex188-rogue-worker.sh)
echo "Found PID: $PID"

# 2. Save the numeric PID to /opt/ex188-lab3/rogue-pid.txt
echo "$PID" > /opt/ex188-lab3/rogue-pid.txt

# 3. Terminate the process forcefully with SIGKILL (-9)
kill -9 "$PID"

# 4. Verify it is no longer running
ps aux | grep ex188-rogue-worker
```

---

### Solution for Task 2: Environment Variables (`agent.env` & `/etc/profile.d/ex188.sh`)
```bash
# 1. Create /opt/ex188-lab3/agent.env
cat << 'EOF' > /opt/ex188-lab3/agent.env
CONTAINER_ENV=production
APP_PORT=9090
EOF

# 2. Create /etc/profile.d/ex188.sh
echo "export EX188_READY=true" > /etc/profile.d/ex188.sh

# 3. Load and verify
source /etc/profile.d/ex188.sh
echo $EX188_READY
```

---

### Solution for Task 3: Manage Services with `systemctl`
```bash
# 1. Reload systemd unit configuration
systemctl daemon-reload

# 2. Enable and start ex188-agent.service immediately
systemctl enable --now ex188-agent.service

# 3. Check service status
systemctl status ex188-agent.service
```

---

### Solution for Task 4: Inspect Systemd Logs with `journalctl`
```bash
# 1. Inspect logs for the unit
journalctl -u ex188-agent.service --no-pager

# 2. Filter lines containing EX188-SYSTEMD-OK and save to reports/journal-agent.log
journalctl -u ex188-agent.service --no-pager | grep "EX188-SYSTEMD-OK" > /opt/ex188-lab3/reports/journal-agent.log
```

---

### Solution for Task 5: System Resource Monitoring (`df -h`, `free -m`)
```bash
# 1. Save root disk usage report
df -h / > /opt/ex188-lab3/reports/disk-usage.txt

# 2. Save memory usage report in megabytes
free -m > /opt/ex188-lab3/reports/memory-usage.txt
```

---

### Run Auto-Grader:
```bash
sudo bash grade-lab.sh
```
Expected output: **`FINAL SCORE: 5 / 5`** 🎉
