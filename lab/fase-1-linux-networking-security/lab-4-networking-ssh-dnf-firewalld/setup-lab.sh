#!/bin/bash
# Setup script for Lab 4: Networking (ss, curl), SSH Keys, scp, Package Management (dnf/rpm) & firewalld
# Must be executed as root / with sudo

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo: sudo bash setup-lab.sh"
    exit 1
fi

echo "Cleaning previous Lab 4 state..."
pkill -9 -f "http.server 8091" 2>/dev/null
rm -rf /opt/ex188-lab4

# Clean any old port 8091 rule if firewalld is active
if systemctl is-active --quiet firewalld; then
    firewall-cmd --remove-port=8091/tcp --permanent >/dev/null 2>&1
    firewall-cmd --reload >/dev/null 2>&1
fi

echo "Initializing Lab 4 environment..."
mkdir -p /opt/ex188-lab4/{reports,web,ssh,staging}
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Ensure sshd is running for Task 3 (scp test)
systemctl enable --now sshd 2>/dev/null

# 1. Create web payload and start background listener on port 8091 for Task 2
cat << 'EOF' > /opt/ex188-lab4/web/index.html
EX188_NET_LAB_OK: Container Web Endpoint Listening on 8091
EOF

nohup python3 -m http.server 8091 --directory /opt/ex188-lab4/web >/dev/null 2>&1 &

# 2. Create staged file for Task 3 (scp transfer)
cat << 'EOF' > /opt/ex188-lab4/staging/secret-payload.conf
# Staged Configuration for SCP Deployment
TRANSFER_TOKEN=SCP_ED25519_VERIFIED
TARGET_PORT=8091
EOF

echo "=================================================================="
echo " Lab 4 environment is READY!"
echo " - Web microservice started on TCP port 8091"
echo " - Staged config created at: /opt/ex188-lab4/staging/secret-payload.conf"
echo " - Reports folder ready at:  /opt/ex188-lab4/reports"
echo " Complete Task 1 to 5 in README.md, then run: sudo bash grade-lab.sh"
echo "=================================================================="
