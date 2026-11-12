# Exercise 07: Troubleshooting Containerized Applications

**Objectives:** understand application resources, read logs, inspect running applications, connect to running containers.

**Time:** 30 minutes

## Setup

```bash
./lab-setup.sh
./break-lab.sh      # creates five broken scenarios
```

Fix all five. Then run `./grade-lab.sh 07`.

## Scenarios

| # | Container | Symptom | Where to look |
|---|---|---|---|
| 1 | `broken-port` | The web page is not reachable | `podman port`, `podman logs`, the port the app listens on |
| 2 | `broken-perm` | `Permission denied` on a bind mount | `podman logs`, `ls -Z`, missing `:Z` or UID mapping |
| 3 | `broken-env` | Exits because a variable is missing | `podman inspect --format '{{.Config.Env}}'`, add `-e` |
| 4 | `broken-dns` | Cannot resolve `db` | `podman network inspect`, put both on one network |
| 5 | `broken-oom` | Killed (exit code 137) | `podman inspect --format '{{.State.OOMKilled}}'`, raise `--memory` |

## Diagnosis workflow

1. **Status:** `podman ps -a` shows state and exit code.
2. **Logs:** `podman logs --tail 50 NAME`.
3. **Config:** `podman inspect NAME --format '{{...}}'`.
4. **Inside:** `podman exec -it NAME /bin/sh`.
5. **Fix:** remove and recreate the container with the right options.

## Useful commands

```bash
podman logs -f --tail 50 NAME
podman events
podman inspect NAME --format '{{.State.ExitCode}} {{.State.OOMKilled}} {{.State.Error}}'
podman top NAME
podman stats --no-stream
podman diff NAME
podman healthcheck run NAME
podman system df
```

## Exit codes

| Code | Meaning |
|---|---|
| 125 | Podman itself failed |
| 126 | Command found but not executable |
| 127 | Command not found |
| 137 | Killed (SIGKILL), often out of memory |
| 143 | Stopped by SIGTERM |

## Remote debugging

| Goal | Command |
|---|---|
| Open a shell | `podman exec -it NAME /bin/sh` |
| Debug an image that exits at once | `podman run --rm -it --entrypoint /bin/sh IMAGE` |
| No shell in the image | `podman cp`, `podman diff`, `podman logs` |
| Install a tool temporarily | `podman exec -u 0 NAME microdnf install -y procps-ng iproute` |
| Reach a debug port | Publish it: `-p 127.0.0.1:5005:5005` |
| Read logs from the journal | `podman run --log-driver journald ...` then `journalctl CONTAINER_NAME=NAME` |

## Check your work

All five containers run without errors in `podman logs`, and `./grade-lab.sh 07` passes.

## Find it in the man pages

No internet in the exam. Practice finding each item.

| Need | Command | Search for |
|---|---|---|
| Run a command inside | `man podman-exec` | `/--interactive` |
| Filter logs by time | `man podman-logs` | `/--since` |
| Run a health check | `man podman-healthcheck-run` | - |
| Resource usage | `man podman-stats` | `/--no-stream` |
