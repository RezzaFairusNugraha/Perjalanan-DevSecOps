#!/bin/bash
# Exercise 06 reference solution
set -x
loginctl enable-linger "$USER"
mkdir -p ~/.config/containers/systemd
cat > ~/.config/containers/systemd/auto-web.container <<'EOF'
[Unit]
Description=Auto web
After=network-online.target

[Container]
ContainerName=auto-web
Image=registry.access.redhat.com/ubi9/httpd-24
PublishPort=8082:8080
Volume=%h/ex188-data/html:/var/www/html:ro,Z
Environment=EXAM=ex188

[Service]
Restart=always

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user start auto-web.service
systemctl --user status auto-web.service --no-pager
curl http://127.0.0.1:8082
