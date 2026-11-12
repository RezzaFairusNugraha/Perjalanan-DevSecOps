# Mock Exam

| | |
|---|---|
| **Time** | 2.5 hours |
| **Environment** | Rootless user, Podman 5 |
| **Pass mark** | About 70% (this is an estimate, Red Hat does not publish it) |
| **Total** | 100 points |

## Rules

- Do the tasks in order.
- Everything must **survive a reboot** without manual action.
- You may use `man` pages. Do not use outside help.
- Run `./lab-setup.sh` first. Reference answers are in `solutions/mock-exam.sh`.

---

## Task 1: Run a container (8 points)

Run `alpha-web` from `registry.access.redhat.com/ubi9/httpd-24`.

- Publish `127.0.0.1:8090` to container port `8080`.
- Set the environment variable `SITE=alpha`.
- Limit memory to 256 MB.

## Task 2: Build an image (12 points)

In `~/exam-work/logistics`, write a Containerfile and build `localhost:5000/logistics-app:1.0`.

- Base image: `ubi9/ubi-minimal`. Install `python3`.
- Working directory `/srv`. Run as user `1001`.
- `ARG VERSION`, `ENV APP_ENV=prod`, `EXPOSE 8080`.
- `ENTRYPOINT ["python3","-m","http.server"]` and `CMD ["8080"]`.

## Task 3: Tags and registry (8 points)

- Tag the image `1.0` and `latest`.
- Push both to `localhost:5000` (insecure registry).
- Remove the local copies, then pull `1.0` again.

## Task 4: Private registry (10 points)

- Run a registry on `localhost:5001` that needs the login `student` / `redhat`.
- Log in and push `logistics-app:1.0` to it.
- Mark `localhost:5001` as insecure **permanently** in `/etc/containers/registries.conf.d/`.

## Task 5: Backups (6 points)

- Save the image to `/tmp/exam-logistics.tar` with `podman save`.
- Export the filesystem of `alpha-web` to `/tmp/exam-alpha.tar` with `podman export`.

## Task 6: Volumes (10 points)

Run a container named `logistics` from your image on host port `8091`.

- Mount a new named volume `logistics-data` at `/data`.
- Mount `~/exam-work/site` read-only at `/srv/site`, with the correct SELinux label.
- Data in the volume must survive removing the container.

## Task 7: Secret and database (10 points)

- Create the secret `db-pass` and the network `shop-net`.
- Run `shop-db` (`quay.io/fedora/postgresql-16`) on `shop-net`.
- Pass the secret as the environment variable `POSTGRESQL_PASSWORD`.
- Set user `shop`, database `shopdb`, and use the volume `shop-data`.

## Task 8: Compose stack (12 points)

In `~/exam-work/shop/compose.yaml`, define:

- `db`: PostgreSQL with a health check.
- `web`: `ubi9/httpd-24` on host port `8092`, starts only when `db` is healthy, and mounts a config file read-only.

Start it with `podman compose up -d`.

## Task 9: Persistence (12 points)

Make the `logistics` container (Task 6) a **Quadlet** service.

- Restart policy `always`.
- Lingering enabled for your user.
- It must start by itself after a reboot.

## Task 10: Troubleshooting (12 points)

Create the broken container:

```bash
podman run -d --name fix-me --user 1001 -v ~/exam-work/site:/data \
  quay.io/libpod/alpine sh -c 'echo x > /data/o; sleep 3600'
```

Find the cause with `podman logs` and `podman inspect`, then fix it so there is no `Permission denied`.
Hint: SELinux label and UID mapping.

---

## Final checks

```bash
podman ps -a
systemctl --user list-units 'logistics*'
curl http://127.0.0.1:8091
```
