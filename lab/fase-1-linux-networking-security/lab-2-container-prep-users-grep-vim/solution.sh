#!/bin/bash
# Reference Solution for Lab 2 (Only open if you get stuck!)

# Task 1: File Maintenance & Bind Mount Prep
sudo mkdir -p /opt/container-lab/web/html /opt/container-lab/logs
sudo mv /tmp/staging-data/index.html /opt/container-lab/web/html/index.html
sudo rm -f /tmp/staging-data/old-trash.tmp

# Task 2: Log Inspection & Filtering
sudo grep "ERROR" /opt/container-lab/logs/podman-app.log > /tmp/errors.txt && sudo mv /tmp/errors.txt /opt/container-lab/logs/errors.txt
sudo grep -E "IP=|PORT=" /opt/container-lab/logs/podman-app.log > /tmp/network.txt && sudo mv /tmp/network.txt /opt/container-lab/logs/network.txt
sudo tail -n 3 /opt/container-lab/logs/podman-app.log > /tmp/latest.txt && sudo mv /tmp/latest.txt /opt/container-lab/logs/latest.txt

# Task 3: Create Containerfile (normally done interactively with: sudo vi /opt/container-lab/Containerfile)
sudo tee /opt/container-lab/Containerfile > /dev/null << 'EOF'
FROM registry.access.redhat.com/ubi9/ubi-minimal
USER 1001
EXPOSE 8080
CMD ["echo", "Hello EX188"]
EOF

# Task 4: Non-Root User & Group Management
sudo groupadd devteam
sudo useradd -u 1050 poduser
sudo usermod -aG devteam poduser
id poduser | sudo tee /opt/container-lab/logs/poduser-id.txt

# Task 5: Special Permissions (SGID & Sticky Bit)
sudo mkdir -p /opt/container-lab/shared-team /opt/container-lab/shared-drop
sudo chown :devteam /opt/container-lab/shared-team
sudo chmod 2770 /opt/container-lab/shared-team
sudo chmod 1777 /opt/container-lab/shared-drop
