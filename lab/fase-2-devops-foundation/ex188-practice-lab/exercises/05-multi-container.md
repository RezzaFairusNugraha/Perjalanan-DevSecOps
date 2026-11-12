# Exercise 05 — Multi-container Applications

**Objective:** application stack, dependencies, env vars, secrets, volumes, configuration.

## Tasks

1. **Network & DNS**: `podman network create app-net`; jalankan `db` (`quay.io/fedora/postgresql-16` atau
   `docker.io/library/postgres:16`) dan `app` pada network yang sama; resolve `db` dari `app`
   (`getent hosts db`). Publish hanya `app`.
2. **Secrets**:
   ```bash
   printf 'S3cret!' | podman secret create db-password -
   podman run -d --name db --network app-net --secret db-password,type=env,target=POSTGRESQL_PASSWORD \
     -e POSTGRESQL_USER=app -e POSTGRESQL_DATABASE=appdb quay.io/fedora/postgresql-16
   ```
   File-mount default: `/run/secrets/db-password`. Cek `podman secret ls/inspect`
   (nilai tidak muncul di `podman inspect`).
3. **Compose** — file `~/exam-work/stack/compose.yaml`:
   ```yaml
   services:
     db:
       image: quay.io/fedora/postgresql-16
       environment:
         POSTGRESQL_USER: app
         POSTGRESQL_DATABASE: appdb
       secrets: [db_password]
       volumes: [dbdata:/var/lib/pgsql/data]
       healthcheck:
         test: ["CMD", "pg_isready", "-U", "app"]
         interval: 5s
         retries: 5
     web:
       image: registry.access.redhat.com/ubi9/httpd-24
       depends_on:
         db: { condition: service_healthy }
       ports: ["8083:8080"]
       volumes: ["./conf/app.conf:/etc/httpd/conf.d/app.conf:ro,Z"]
   secrets:
     db_password: { file: ./db_password.txt }
   volumes:
     dbdata: {}
   ```
   `podman compose up -d`, `podman compose ps`, `podman compose logs`, `podman compose down -v`.
4. **Configuration**: pasang config lewat bind-mount `:ro,Z` dan env (`--env-file`). Ubah config, restart, verifikasi.
5. **Dependency/startup order**: tunjukkan `depends_on` + healthcheck
   (`podman healthcheck run db`, `podman inspect --format '{{.State.Health.Status}}'`).
6. **Pods**: `podman pod create --name web-pod -p 8084:80`; tambahkan `nginx` dan `ubi9` sidecar
   (`--pod web-pod`), `curl localhost` dari sidecar.
7. **Kube YAML**: `podman kube generate web-pod -f web-pod.yaml`; `podman pod rm -f web-pod`;
   `podman kube play web-pod.yaml`; `podman kube down web-pod.yaml`.

## Verifikasi
`podman ps --pod`, `curl 127.0.0.1:8083`, `podman secret ls`.
