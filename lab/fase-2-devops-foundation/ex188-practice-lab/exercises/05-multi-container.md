# Exercise 05: Multi-container Applications

**Objectives:** application stacks, dependencies, environment variables, secrets, volumes, configuration.

**Time:** 45 minutes

## Task 1: Network and DNS

Containers on the same user-defined network find each other by name.

```bash
podman network create app-net
podman run -d --name db --network app-net \
  -e POSTGRESQL_USER=app -e POSTGRESQL_PASSWORD=pw -e POSTGRESQL_DATABASE=appdb \
  quay.io/fedora/postgresql-16
podman run --rm --network app-net registry.access.redhat.com/ubi9/ubi getent hosts db
```

**Expected:** the name `db` resolves to an IP address.

## Task 2: Secrets

```bash
printf 'S3cret!' | podman secret create db-password -
podman run -d --name db2 --network app-net \
  --secret db-password,type=env,target=POSTGRESQL_PASSWORD \
  -e POSTGRESQL_USER=app -e POSTGRESQL_DATABASE=appdb \
  quay.io/fedora/postgresql-16
podman secret ls
podman exec db2 ls /run/secrets 2>/dev/null
```

| Secret type | How the container sees it |
|---|---|
| Default (mount) | File at `/run/secrets/<name>` |
| `type=env,target=VAR` | Environment variable `VAR` |

The secret value does not appear in `podman inspect`.

## Task 3: Compose stack

Create `~/exam-work/stack/compose.yaml`:

```yaml
services:
  db:
    image: quay.io/fedora/postgresql-16
    environment:
      POSTGRESQL_USER: app
      POSTGRESQL_DATABASE: appdb
      POSTGRESQL_PASSWORD: pw
    volumes:
      - dbdata:/var/lib/pgsql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "app"]
      interval: 5s
      retries: 10
  web:
    image: registry.access.redhat.com/ubi9/httpd-24
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "8083:8080"
    volumes:
      - ./conf/app.conf:/etc/httpd/conf.d/app.conf:ro,Z
volumes:
  dbdata: {}
```

Create the config file, then run the stack:

```bash
mkdir -p ~/exam-work/stack/conf && cd ~/exam-work/stack
echo "# app config" > conf/app.conf
podman compose up -d
podman compose ps
podman compose logs
curl -I http://127.0.0.1:8083
podman compose down        # add -v to remove volumes too
```

## Task 4: Dependencies

`depends_on` with `condition: service_healthy` makes `web` wait until `db` passes its health check.

```bash
podman healthcheck run db
podman inspect db --format '{{.State.Health.Status}}'
```

## Task 5: Configuration

Provide configuration in three ways and know when to use each:

| Method | Example |
|---|---|
| Environment variable | `-e KEY=value` |
| Env file | `--env-file app.env` |
| Mounted file | `-v ./app.conf:/etc/app.conf:ro,Z` |

Change the mounted file, restart the container, and confirm the new setting applies.

## Task 6: Pods

Containers in one pod share `localhost`.

```bash
podman pod create --name web-pod -p 8084:80
podman run -d --pod web-pod --name pod-web docker.io/library/nginx
podman run --rm --pod web-pod registry.access.redhat.com/ubi9/ubi curl -s localhost | head -5
podman ps --pod
```

## Task 7: Kubernetes YAML

```bash
podman kube generate web-pod -f web-pod.yaml
podman pod rm -f web-pod
podman kube play web-pod.yaml
podman kube down web-pod.yaml
```

## Check your work

```bash
podman ps --pod
podman secret ls
podman network ls
```
