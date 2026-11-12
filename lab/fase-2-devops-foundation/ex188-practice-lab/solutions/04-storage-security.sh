#!/bin/bash
# Exercise 04 reference solution
set -x
podman rm -f persistent-web 2>/dev/null
podman run -d --name persistent-web -p 8080:8080 \
  -v ~/ex188-data/html:/var/www/html:ro,Z registry.access.redhat.com/ubi9/httpd-24
curl http://127.0.0.1:8080
podman exec persistent-web touch /var/www/html/x   # must fail

podman volume create my-db-data
podman run --name db-test -v my-db-data:/data:Z registry.access.redhat.com/ubi9/ubi sh -c 'echo persisted > /data/file.txt'
podman rm db-test
podman run --rm --name db-verify -v my-db-data:/data:Z registry.access.redhat.com/ubi9/ubi cat /data/file.txt

podman run --rm --userns=keep-id:uid=1001,gid=1001 --user 1001 \
  -v ~/ex188-data/mysql:/data:Z registry.access.redhat.com/ubi9/ubi touch /data/ok

podman volume create pgdata
for i in 1 2; do
  podman rm -f db 2>/dev/null
  podman run -d --name db -v pgdata:/var/lib/pgsql/data:Z \
    -e POSTGRESQL_USER=app -e POSTGRESQL_PASSWORD=secret -e POSTGRESQL_DATABASE=appdb quay.io/fedora/postgresql-16
  sleep 10
  [[ $i == 1 ]] && podman exec db psql -U app appdb -c 'CREATE TABLE t(id int); INSERT INTO t VALUES (1);'
done
podman exec db psql -U app appdb -c 'SELECT * FROM t;'

podman run -d --name hardened --cap-drop=ALL --read-only --security-opt no-new-privileges \
  registry.access.redhat.com/ubi9/ubi sleep 600
podman inspect hardened --format 'Drop={{.HostConfig.CapDrop}} ReadOnly={{.HostConfig.ReadonlyRootfs}}'
