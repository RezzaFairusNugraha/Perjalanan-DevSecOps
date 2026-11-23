#!/bin/bash
# Setup script for Lab 5 (Grand Capstone): EX188 Prerequisite Mock Exam (Sections 1-5 All-in-One)
# Must be executed as root / with sudo

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo: sudo bash setup-lab.sh"
    exit 1
fi

echo "Cleaning previous Lab 5 (Capstone) state..."
systemctl stop ex188-capstone.service 2>/dev/null
systemctl disable ex188-capstone.service 2>/dev/null
pkill -9 -f capstone-stuck-job.sh 2>/dev/null
pkill -9 -f "http.server 8095" 2>/dev/null
userdel -r capuser 2>/dev/null
groupdel capteam 2>/dev/null
rm -rf /opt/ex188-capstone /tmp/capstone-staging
rm -f /usr/local/bin/ex188-capstone-bin
rm -f /etc/systemd/system/ex188-capstone.service
rm -f /tmp/capstone-stuck-job.sh

if systemctl is-active --quiet firewalld; then
    firewall-cmd --remove-port=8095/tcp --permanent >/dev/null 2>&1
    firewall-cmd --reload >/dev/null 2>&1
fi

echo "Initializing Lab 5 (Grand Capstone) environment..."
mkdir -p /tmp/capstone-staging
mkdir -p /opt/ex188-capstone
mkdir -p /root/.ssh
chmod 700 /root/.ssh
systemctl enable --now sshd 2>/dev/null

# 1. Create raw HTTP access log for Task 1 (Section 1)
cat << 'EOF' > /tmp/capstone-staging/raw-access.log
2026-11-23 10:00:01 GET /api/v1/health STATUS=200 LATENCY=4ms
2026-11-23 10:01:12 POST /api/v1/login STATUS=200 LATENCY=18ms
2026-11-23 10:02:44 GET /api/v1/orders STATUS=500 ERR="DB_CONN_REFUSED"
2026-11-23 10:03:05 GET /api/v1/profile STATUS=200 LATENCY=9ms
2026-11-23 10:04:19 POST /api/v1/checkout STATUS=503 ERR="UPSTREAM_TIMEOUT"
2026-11-23 10:05:00 GET /api/v1/items STATUS=404 LATENCY=3ms
2026-11-23 10:06:33 POST /api/v1/payment STATUS=500 ERR="CONTAINER_OOM"
EOF

# 2. Launch stuck background process for Task 3 (Section 3 - ignores SIGTERM)
cat << 'EOF' > /tmp/capstone-stuck-job.sh
#!/bin/bash
trap "" SIGTERM SIGINT
while true; do
    sleep 5
done
EOF
chmod +x /tmp/capstone-stuck-job.sh
nohup /tmp/capstone-stuck-job.sh >/dev/null 2>&1 &
STUCK_PID=$!
echo "$STUCK_PID" > /opt/ex188-capstone/.expected_pid

# 3. Create systemd service binary and unit file for Task 3 & Task 4
cat << 'EOF' > /usr/local/bin/ex188-capstone-bin
#!/bin/bash
echo "CAPSTONE_SERVICE_READY: Mode=${CAPSTONE_MODE:-unset} Port=${LISTEN_PORT:-8095}"
exec python3 -m http.server "${LISTEN_PORT:-8095}" --directory /opt/ex188-capstone/html
EOF
chmod +x /usr/local/bin/ex188-capstone-bin

cat << 'EOF' > /etc/systemd/system/ex188-capstone.service
[Unit]
Description=EX188 Grand Capstone Web & Monitoring Service
After=network.target

[Service]
Type=simple
EnvironmentFile=/opt/ex188-capstone/capstone.env
ExecStart=/usr/local/bin/ex188-capstone-bin
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

echo "=================================================================="
echo " LAB 5 (GRAND CAPSTONE: SECTIONS 1-5 ALL-IN-ONE) IS READY!"
echo " - Raw access log:    /tmp/capstone-staging/raw-access.log"
echo " - Stuck process:     capstone-stuck-job.sh (running in background)"
echo " - Systemd unit:      /etc/systemd/system/ex188-capstone.service"
echo " - Target workspace:  /opt/ex188-capstone"
echo " Complete Task 1 to 5 in README.md, then run: sudo bash grade-lab.sh"
echo "=================================================================="
