# Exercise 01: Run Containers

**Objectives:** run containers, get logs, listen to events, use `podman inspect`, set environment variables, expose ports, manage the lifecycle.

**Time:** 20 minutes

## Task 1: Run a web container

Run a detached container named `my-web` from `registry.access.redhat.com/ubi9/httpd-24`.
Publish `127.0.0.1:8080` on the host to port `8080` in the container.

```bash
podman run -d --name my-web -p 127.0.0.1:8080:8080 registry.access.redhat.com/ubi9/httpd-24
curl -s http://127.0.0.1:8080 | head
```

**Expected:** `curl` returns the Apache test page.

## Task 2: Inspect the container

Use `podman inspect --format` to print the image, the command, the IP address, and the port mapping.

```bash
podman inspect my-web --format '{{.ImageName}}'
podman inspect my-web --format '{{.Config.Cmd}} {{.Config.Entrypoint}}'
podman inspect my-web --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
podman port my-web
```

## Task 3: Watch events

Open a second terminal and run `podman events --filter container=my-web`.
Back in the first terminal, restart the container and watch the events appear.

```bash
podman restart my-web
podman events --since 5m --until 0s --filter container=my-web
```

## Task 4: Read logs

```bash
podman logs my-web
podman logs --tail 5 -f my-web      # follow, press Ctrl+C to stop
podman logs --since 10m -t my-web   # with timestamps
```

## Task 5: Run commands and copy files

1. Create `/tmp/hello.txt` inside `my-web` with the text `Hello EX188`.
2. Copy `~/exam-work/local.txt` into the container and copy `/etc/httpd/conf/httpd.conf` out to the host.

```bash
podman exec my-web sh -c 'echo "Hello EX188" > /tmp/hello.txt'
podman exec my-web ls -l /tmp
podman cp ~/exam-work/local.txt my-web:/tmp/local_copy.txt
podman cp my-web:/etc/httpd/conf/httpd.conf ./httpd.conf
```

## Task 6: Environment variables

Run a container named `my-env` from `ubi9/ubi` that prints its environment and exits.
Set `exam=ex188` with `-e`, and `LEVEL=dev` from an env file.

```bash
echo "LEVEL=dev" > app.env
podman run --name my-env -e exam=ex188 --env-file app.env registry.access.redhat.com/ubi9/ubi env
podman logs my-env | grep -E 'exam|LEVEL'
```

## Task 7: Lifecycle commands

```bash
podman stop my-web && podman start my-web
podman pause my-web && podman unpause my-web
podman kill -s SIGTERM my-web
podman ps -a --filter status=exited
podman run -d --name flaky --restart=on-failure:3 registry.access.redhat.com/ubi9/ubi false
podman container prune -f
```

## Task 8: Limit resources

```bash
podman run -d --name limited --memory 128m --cpus 0.5 registry.access.redhat.com/ubi9/ubi sleep 600
podman inspect limited --format '{{.HostConfig.Memory}} {{.HostConfig.NanoCpus}}'
podman stats --no-stream
```

## Task 9: Clean up

```bash
podman rm -af
```

## Check your work

- `podman ps -a` shows no leftover containers.
- `podman logs my-env` showed `exam=ex188` before you removed it.

## Find it in the man pages

No internet in the exam. Practice finding each item.

| Need | Command | Search for |
|---|---|---|
| Publish a port | `man podman-run` | `/--publish` |
| Environment file | `man podman-run` | `/--env-file` |
| Format inspect output | `man podman-inspect` | `/--format` |
| Filter events | `man podman-events` | `/--filter` |
| Restart policy | `man podman-run` | `/--restart` |
