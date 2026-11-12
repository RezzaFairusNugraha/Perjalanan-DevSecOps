#!/bin/bash
# Membuat 5 skenario rusak untuk Exercise 07 (rootless)
mkdir -p "$HOME/exam-work/broken"
# dimount tanpa :Z -> SELinux menolak tulis (pada sistem enforcing)

HTTPD=registry.access.redhat.com/ubi9/httpd-24
ALP=quay.io/libpod/alpine:latest

# 1: salah port (app listen 8080, publish ke port yang salah)
podman run -d --name broken-port -p 9090:80 $HTTPD >/dev/null
# 2: bind mount tanpa label SELinux
podman run -d --name broken-perm -v "$HOME/exam-work/broken:/data" $ALP sh -c 'echo ok > /data/f || { echo "Permission denied" >&2; sleep 3600; }' >/dev/null
# 3: env hilang
podman run -d --name broken-env $ALP sh -c '[ -n "$DB_HOST" ] || { echo "DB_HOST is required" >&2; exit 1; }; sleep 3600' >/dev/null
# 4: network salah
podman network create broken-net >/dev/null 2>&1
podman run -d --name db $ALP sleep 3600 >/dev/null
podman run -d --name broken-dns --network broken-net $ALP sh -c 'getent hosts db || { echo "cannot resolve db" >&2; }; sleep 3600' >/dev/null
# 5: memory terlalu kecil
podman run -d --name broken-oom --memory 6m $ALP sh -c 'head -c 50m /dev/zero | tail' >/dev/null 2>&1
echo "Broken scenarios created. Fix them, then run ./grade-lab.sh (7)."
