#!/bin/bash
# Setup script for Lab 2 (v2): EX188 Advanced Prep
# Must be executed with root/sudo

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo: sudo bash setup-lab.sh"
    exit 1
fi

echo "Cleaning previous lab state..."
rm -rf /opt/container-lab /tmp/staging-ex188
userdel -r apprunner 2>/dev/null
userdel -r poduser 2>/dev/null
groupdel engineers 2>/dev/null
groupdel devteam 2>/dev/null

echo "Initializing new Lab 2 environment..."

# 1. Staging directory for Task 1
mkdir -p /tmp/staging-ex188
cat << 'EOF' > /tmp/staging-ex188/app.conf
# Microservice Application Configuration
PORT=8080
LOG_LEVEL=DEBUG
STORAGE_PATH=/opt/container-lab/app/data
EOF

cat << 'EOF' > /tmp/staging-ex188/default.env
ENV=production
DEBUG=false
MAX_CONNECTIONS=100
EOF

# 2. Simulated Podman service logs for Task 2
mkdir -p /opt/container-lab/logs
cat << 'EOF' > /opt/container-lab/logs/podman-service.log
2026-11-18 09:00:01 INFO  [runtime] Podman daemonless runtime initialized.
2026-11-18 09:00:05 INFO  [network] Bridge interface cni-podman0 up on IP=10.88.0.1
2026-11-18 09:00:10 INFO  [service] Inbound connection accepted REMOTE_ADDR=10.88.0.104
2026-11-18 09:01:22 WARN  [storage] High I/O latency on persistent mount /var/lib/containers
2026-11-18 09:02:15 CRITICAL [auth] Invalid credential exchange detected from REMOTE_ADDR=10.88.0.210
2026-11-18 09:02:30 INFO  [service] Healthcheck status: HTTP 200 OK
2026-11-18 09:03:00 FATAL [database] Connection pool exhausted (max=50 reached)
2026-11-18 09:03:10 INFO  [service] Inbound connection accepted REMOTE_ADDR=10.88.0.118
2026-11-18 09:04:00 CRITICAL [kernel] Memory cgroup limit exceeded on container a7b8c9d0
2026-11-18 09:05:00 INFO  [service] Inbound connection accepted REMOTE_ADDR=10.88.0.144
2026-11-18 09:06:12 INFO  [system] Graceful recovery routine started
2026-11-18 09:06:45 INFO  [system] All worker processes normalized
EOF

echo "=========================================================="
echo " Lab 2 environment is READY!"
echo " Staging directory: /tmp/staging-ex188"
echo " Service log file:  /opt/container-lab/logs/podman-service.log"
echo " Start solving Task 1 to 5, then run: sudo bash grade-lab.sh"
echo "=========================================================="
