#!/bin/bash
# Setup script for Lab 2: Container Prep (File Maintenance, grep, vi/vim, Users, Special Permissions)

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo: sudo bash setup-lab.sh"
    exit 1
fi

echo "Initializing Lab 2 environment..."

# Clean previous lab state
rm -rf /opt/container-lab /tmp/staging-data
userdel -r poduser 2>/dev/null
groupdel devteam 2>/dev/null

# Prepare staging files for Task 1
mkdir -p /tmp/staging-data
echo "<h1>Welcome to EX188 Web Container</h1>" > /tmp/staging-data/index.html
echo "temporary garbage file" > /tmp/staging-data/old-trash.tmp

# Prepare simulated Podman/Container log file for Task 2
mkdir -p /opt/container-lab/logs
cat << 'EOF' > /opt/container-lab/logs/podman-app.log
2026-11-18 08:01:10 INFO Container ID=a1b2c3d4e5f6 starting up...
2026-11-18 08:01:12 INFO Assigned network IP=10.88.0.15
2026-11-18 08:01:13 INFO Listening on PORT=8080
2026-11-18 08:02:01 WARN High memory usage detected (82%)
2026-11-18 08:02:45 ERROR Failed to connect to database at 10.88.0.20:5432
2026-11-18 08:03:00 INFO Retrying database connection...
2026-11-18 08:03:15 ERROR Connection timeout after 15s (Container ID=a1b2c3d4e5f6)
2026-11-18 08:04:00 INFO Fallback cache enabled on PORT=6379
2026-11-18 08:05:10 INFO Healthcheck passed (HTTP 200 OK)
2026-11-18 08:05:30 INFO Application ready for traffic
EOF

echo "Lab 2 environment is ready!"
echo "Staging files created in: /tmp/staging-data"
echo "Sample log created at:    /opt/container-lab/logs/podman-app.log"
echo "Run 'sudo bash grade-lab.sh' anytime to check your score."
