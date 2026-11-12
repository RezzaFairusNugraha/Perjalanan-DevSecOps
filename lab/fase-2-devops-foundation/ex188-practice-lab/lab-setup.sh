#!/bin/bash
# EX188 lab setup (rootless, Podman 5)
set -u
command -v podman >/dev/null || { echo "podman not installed"; exit 1; }
MAJOR=$(podman version --format '{{.Client.Version}}' | cut -d. -f1)
[[ $MAJOR -ge 5 ]] || echo "WARN: Podman v5 recommended (found v$MAJOR)"

IMAGES=(
  registry.access.redhat.com/ubi9/ubi:latest
  registry.access.redhat.com/ubi9/ubi-minimal:latest
  registry.access.redhat.com/ubi9/httpd-24:latest
  quay.io/fedora/postgresql-16:latest
  quay.io/libpod/alpine:latest
  docker.io/library/registry:2
  docker.io/library/nginx:latest
)
for i in "${IMAGES[@]}"; do echo "Pulling $i"; podman pull -q "$i" || echo "  failed: $i"; done

# Registry lokal (insecure, tanpa auth)
if ! podman container exists local-registry; then
  podman run -d --name local-registry -p 5000:5000 docker.io/library/registry:2
else
  podman start local-registry >/dev/null 2>&1
fi

mkdir -p "$HOME/ex188-data/html" "$HOME/ex188-data/mysql" "$HOME/ex188-data/auth" "$HOME/exam-work"
echo "Welcome to EX188 Practice" > "$HOME/ex188-data/html/index.html"
echo "Host file" > "$HOME/exam-work/local.txt"
echo "Setup complete. Registry: localhost:5000"
