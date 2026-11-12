# Exercise 04: Volumes, Permissions, and Security

**Objectives:** share host data with a container, named volumes, SELinux, rootless permissions, host and network access, lifecycle and cleanup.

**Time:** 40 minutes. Run `./lab-setup.sh` first.

## Task 1: Bind mount with SELinux

```bash
podman run -d --name persistent-web -p 8080:8080 \
  -v ~/ex188-data/html:/var/www/html:Z \
  registry.access.redhat.com/ubi9/httpd-24
curl http://127.0.0.1:8080
```

Change the file on the host and `curl` again. The change appears at once.

| Option | Meaning |
|---|---|
| `:Z` | Private label. Only this container can use the data |
| `:z` | Shared label. Several containers can use the data |
| `:ro` | Read-only |

Check the label with `ls -Zd ~/ex188-data/html`.

## Task 2: Read-only mount

```bash
podman rm -f persistent-web
podman run -d --name persistent-web -p 8080:8080 \
  -v ~/ex188-data/html:/var/www/html:ro,Z registry.access.redhat.com/ubi9/httpd-24
podman exec persistent-web touch /var/www/html/x
```

**Expected:** `Read-only file system` error.

## Task 3: Named volume

```bash
podman volume create my-db-data
podman run --name db-test -v my-db-data:/data:Z registry.access.redhat.com/ubi9/ubi \
  sh -c 'echo persisted > /data/file.txt'
podman rm db-test
podman run --rm --name db-verify -v my-db-data:/data:Z registry.access.redhat.com/ubi9/ubi cat /data/file.txt
podman volume inspect my-db-data --format '{{.Mountpoint}}'
```

**Expected:** `persisted`. The volume survives the container.

## Task 4: Rootless UID mapping

A non-root user inside the container maps to a different UID on the host. Fix `Permission denied` on a bind mount in one of two ways:

```bash
# Option A: map your user to the container user
podman run --rm --userns=keep-id:uid=1001,gid=1001 --user 1001 \
  -v ~/ex188-data/mysql:/data:Z registry.access.redhat.com/ubi9/ubi touch /data/ok

# Option B: change the owner inside the user namespace
podman unshare chown 1001:1001 ~/ex188-data/mysql
```

## Task 5: Database with persistent data

```bash
podman volume create pgdata
podman run -d --name db -v pgdata:/var/lib/pgsql/data:Z \
  -e POSTGRESQL_USER=app -e POSTGRESQL_PASSWORD=secret -e POSTGRESQL_DATABASE=appdb \
  quay.io/fedora/postgresql-16
podman exec db psql -U app appdb -c 'CREATE TABLE t(id int); INSERT INTO t VALUES (1);'
podman rm -f db
podman run -d --name db -v pgdata:/var/lib/pgsql/data:Z \
  -e POSTGRESQL_USER=app -e POSTGRESQL_PASSWORD=secret -e POSTGRESQL_DATABASE=appdb \
  quay.io/fedora/postgresql-16
podman exec db psql -U app appdb -c 'SELECT * FROM t;'
```

**Expected:** the row still exists.

## Task 6: tmpfs and the `--mount` syntax

```bash
podman run --rm --tmpfs /tmp:rw,size=16m registry.access.redhat.com/ubi9/ubi df -h /tmp
podman run --rm --mount type=bind,src=$HOME/ex188-data/html,dst=/mnt,ro,relabel=private \
  registry.access.redhat.com/ubi9/ubi ls /mnt
```

## Task 7: Reduce privileges

```bash
podman run -d --name hardened --cap-drop=ALL --read-only --security-opt no-new-privileges \
  registry.access.redhat.com/ubi9/ubi sleep 600
podman inspect hardened --format 'Drop={{.HostConfig.CapDrop}} ReadOnly={{.HostConfig.ReadonlyRootfs}}'
```

Do not use `--privileged` unless a task requires it. It gives the container nearly full host access.

## Task 8: Host and network access

| Option | Effect |
|---|---|
| `-p 127.0.0.1:8082:8080` | Reachable from the host only |
| `-p 8082:8080` | Reachable from all interfaces |
| `--network none` | No network at all |
| `--network host` | Shares the host network stack |

Rootless users cannot publish ports below 1024 (`-p 80:80` fails).

## Task 9: Rootless facts

```bash
podman unshare cat /proc/self/uid_map
grep $USER /etc/subuid
podman info --format '{{.Host.Security.Rootless}}'
```

Rootless storage lives in `~/.local/share/containers`.

## Task 10: Lifecycle and cleanup

- `podman rm` does **not** delete named volumes. Use `podman rm -v` or `podman volume rm`.
- Host folders used as bind mounts stay on the host after the container is removed.
- `:Z` relabels the host folder permanently. Restore with `restorecon -Rv ~/ex188-data/html`.

```bash
podman rm -af
podman volume prune -f
```

## Check your work

```bash
podman volume ls
podman inspect persistent-web --format '{{range .Mounts}}{{.Source}} writable={{.RW}}{{end}}'
```
