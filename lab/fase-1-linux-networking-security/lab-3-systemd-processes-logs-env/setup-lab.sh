#!/bin/bash
# Setup script for Lab 3: Systemd Services, Process Signals, Resource Monitoring, journalctl & Environment Variables
# Must be executed as root / with sudo

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo: sudo bash setup-lab.sh"
    exit 1
fi

echo "Cleaning previous Lab 3 state..."
systemctl stop ex188-agent.service 2>/dev/null
systemctl disable ex188-agent.service 2>/dev/null
pkill -9 -f ex188-rogue-worker.sh 2>/dev/null
rm -rf /opt/ex188-lab3
rm -f /tmp/ex188-rogue-worker.sh
rm -f /usr/local/bin/ex188-agent-bin
rm -f /etc/systemd/system/ex188-agent.service
rm -f /etc/profile.d/ex188.sh

echo "Initializing Lab 3 environment..."
mkdir -p /opt/ex188-lab3/reports

# 1. Create and launch the rogue background worker for Task 1 (ignores SIGTERM)
cat << 'EOF' > /tmp/ex188-rogue-worker.sh
#!/bin/bash
trap "" SIGTERM SIGINT
while true; do
    sleep 5
done
EOF
chmod +x /tmp/ex188-rogue-worker.sh
nohup /tmp/ex188-rogue-worker.sh >/dev/null 2>&1 &
ROGUE_PID=$!
echo "$ROGUE_PID" > /opt/ex188-lab3/.expected_pid

# 2. Create the binary for ex188-agent.service (Task 2, 3, 4)
cat << 'EOF' > /usr/local/bin/ex188-agent-bin
#!/bin/bash
echo "EX188 Agent initialized: CONTAINER_ENV=${CONTAINER_ENV:-unset} APP_PORT=${APP_PORT:-unset} [TOKEN=EX188-SYSTEMD-OK]"
while true; do
    sleep 15
done
EOF
chmod +x /usr/local/bin/ex188-agent-bin

# 3. Create the systemd service unit file for Task 3 & 4
cat << 'EOF' > /etc/systemd/system/ex188-agent.service
[Unit]
Description=EX188 Container Readiness Monitoring Agent
After=network.target

[Service]
Type=simple
EnvironmentFile=/opt/ex188-lab3/agent.env
ExecStart=/usr/local/bin/ex188-agent-bin
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

echo "=================================================================="
echo " Lab 3 environment is READY!"
echo " - Rogue worker started in background (find it with ps/pgrep)"
echo " - Systemd unit created: /etc/systemd/system/ex188-agent.service"
echo " - Lab directory:        /opt/ex188-lab3"
echo " Complete Task 1 to 5 in README.md, then run: sudo bash grade-lab.sh"
echo "=================================================================="
