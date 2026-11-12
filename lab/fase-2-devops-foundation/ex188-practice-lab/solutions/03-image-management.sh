#!/bin/bash
# Exercise 03 reference solution (needs web1 and webapp:v1 from Exercise 02)
set -x
podman tag localhost:5000/webapp:v1 localhost:5000/webapp:latest
podman push --tls-verify=false localhost:5000/webapp:v1
podman push --tls-verify=false localhost:5000/webapp:latest
skopeo list-tags --tls-verify=false docker://localhost:5000/webapp
podman rmi localhost:5000/webapp:latest
podman pull --tls-verify=false localhost:5000/webapp:latest

# Private registry
mkdir -p ~/ex188-data/auth
podman run --rm docker.io/library/httpd:2 htpasswd -Bbn student redhat > ~/ex188-data/auth/htpasswd
podman run -d --name secure-registry -p 5001:5000 -v ~/ex188-data/auth:/auth:Z \
  -e REGISTRY_AUTH=htpasswd -e REGISTRY_AUTH_HTPASSWD_REALM=Registry \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd docker.io/library/registry:2
sleep 3
podman login --tls-verify=false localhost:5001 -u student -p redhat
podman tag localhost:5000/webapp:v1 localhost:5001/webapp:v1
podman push --tls-verify=false localhost:5001/webapp:v1
sudo tee /etc/containers/registries.conf.d/99-lab.conf <<'EOF'
[[registry]]
location = "localhost:5001"
insecure = true
EOF

# Backups
podman save -o /tmp/webapp.tar localhost:5000/webapp:v1
podman export -o /tmp/web1-fs.tar web1
podman import /tmp/web1-fs.tar localhost:5000/webapp-imported:v1
podman history localhost:5000/webapp:v1
podman history localhost:5000/webapp-imported:v1
