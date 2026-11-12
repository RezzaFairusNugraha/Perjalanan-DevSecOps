#!/bin/bash
# Exercise 07 reference solution (run after ./break-lab.sh)
set -x
HTTPD=registry.access.redhat.com/ubi9/httpd-24
ALP=quay.io/libpod/alpine:latest

# 1: app listens on 8080, not 80
podman rm -f broken-port
podman run -d --name broken-port -p 9090:8080 $HTTPD

# 2: add the SELinux label
podman rm -f broken-perm
podman run -d --name broken-perm -v "$HOME/exam-work/broken:/data:Z" $ALP sh -c 'echo ok > /data/f; sleep 3600'

# 3: provide the missing variable
podman rm -f broken-env
podman run -d --name broken-env -e DB_HOST=db $ALP sh -c '[ -n "$DB_HOST" ] || exit 1; sleep 3600'

# 4: attach to the same network as db
podman rm -f broken-dns db
podman network create fixed-net 2>/dev/null
podman run -d --name db --network fixed-net $ALP sleep 3600
podman run -d --name broken-dns --network fixed-net $ALP sleep 3600
podman exec broken-dns getent hosts db

# 5: raise the memory limit
podman rm -f broken-oom
podman run -d --name broken-oom --memory 256m $ALP sleep 3600
podman inspect broken-oom --format '{{.State.OOMKilled}}'
