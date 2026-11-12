#!/bin/bash
# EX188 lab cleanup: removes lab resources only (base images preserved).
echo "[1/6] Quadlet units"
for f in "$HOME"/.config/containers/systemd/*.container "$HOME"/.config/containers/systemd/*.kube; do
  [[ -f "$f" ]] || continue
  n=$(basename "${f%.*}")
  systemctl --user stop "$n.service" 2>/dev/null
  rm -f "$f"
done
systemctl --user daemon-reload

echo "[2/6] Pods, containers"
podman pod rm -af 2>/dev/null
podman rm -af 2>/dev/null

echo "[3/6] Volumes, networks, secrets"
podman volume rm -af 2>/dev/null
for n in $(podman network ls --format '{{.Name}}' | grep -v '^podman$'); do podman network rm -f "$n" 2>/dev/null; done
podman secret ls -q | xargs -r podman secret rm 2>/dev/null

echo "[4/6] Built images"
podman images --format '{{.Repository}}:{{.Tag}}' | grep -E 'localhost[:/]|webapp|my-custom-app' | xargs -r podman rmi -f 2>/dev/null
podman image prune -f >/dev/null 2>&1

echo "[5/6] Host artifacts"
rm -rf "$HOME/ex188-data" "$HOME/exam-work"
rm -f /tmp/webapp.tar /tmp/web1-fs.tar /tmp/exam-*.tar

echo "[6/6] Done"
podman ps -a; podman pod ps
