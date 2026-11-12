# Exercise 02: Containerfile

**Objectives:** FROM, RUN, ADD vs COPY, WORKDIR, USER, CMD vs ENTRYPOINT, EXPOSE, ENV, ARG, VOLUME, security.

**Time:** 35 minutes

## Task 1: Create the application

```bash
mkdir -p ~/exam-work/webapp && cd ~/exam-work/webapp
cat > app.py <<'EOF'
import os, http.server, socketserver
PORT = int(os.environ.get("APP_PORT", "8080"))
class H(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200); self.end_headers()
        self.wfile.write(f"Hello from {os.environ.get('APP_MSG','default')}\n".encode())
socketserver.TCPServer(("", PORT), H).serve_forever()
EOF
```

## Task 2: Write the Containerfile

Create `Containerfile` with these requirements:

| Requirement | Instruction |
|---|---|
| Base image | `FROM registry.access.redhat.com/ubi9/ubi-minimal:latest` |
| Label | `LABEL maintainer="student@example.com"` |
| Build argument | `ARG APP_VERSION=1.0` |
| Environment | `ENV APP_MSG="EX188" APP_PORT=8080` |
| Install Python | `RUN microdnf install -y python3 && microdnf clean all` |
| Working directory | `WORKDIR /app` |
| Add the script | `COPY app.py .` |
| Data volume | `VOLUME /data` |
| Document the port | `EXPOSE 8080` |
| Non-root user | `USER 1001` |
| Default command | `ENTRYPOINT ["python3"]` and `CMD ["app.py"]` |

## Task 3: Build and run

```bash
podman build -t localhost:5000/webapp:v1 --build-arg APP_VERSION=1.1 .
podman run -d --name web1 -p 8081:8080 localhost:5000/webapp:v1
curl http://127.0.0.1:8081
```

**Expected:** `Hello from EX188`

## Task 4: Override at run time

```bash
podman run --rm -e APP_MSG=Override localhost:5000/webapp:v1 -c 'import os; print(os.environ["APP_MSG"])'
podman run --rm --entrypoint /bin/sh localhost:5000/webapp:v1 -c 'id; pwd'
```

The first command replaces `CMD`. The second replaces `ENTRYPOINT`.

## Task 5: Inspect the image

```bash
podman exec web1 id                       # uid=1001
podman image inspect localhost:5000/webapp:v1 \
  --format 'User={{.Config.User}} Dir={{.Config.WorkingDir}} Ports={{.Config.ExposedPorts}}'
podman history localhost:5000/webapp:v1
```

## Task 6: ADD vs COPY

| | `COPY` | `ADD` |
|---|---|---|
| Copies local files | Yes | Yes |
| Extracts local `.tar` archives automatically | No | Yes |
| Downloads from a URL | No | Yes |
| Recommended | **Default choice** | Only when you need auto-extract |

Test it:

```bash
mkdir -p site && echo hi > site/index.html && tar czf site.tar.gz -C site .
cat > Containerfile.add <<'EOF'
FROM registry.access.redhat.com/ubi9/ubi-minimal
ADD site.tar.gz /opt/added/
COPY site.tar.gz /opt/copied/
EOF
podman build -f Containerfile.add -t add-test .
podman run --rm add-test ls -R /opt
```

**Expected:** `/opt/added` contains `index.html`. `/opt/copied` contains `site.tar.gz` unchanged.

## Task 7: CMD vs ENTRYPOINT

| | `CMD` | `ENTRYPOINT` |
|---|---|---|
| Purpose | Default command or default arguments | The fixed executable |
| Arguments after the image name | **Replace** it | Are **appended** to it |
| Replace it at run time | Pass a new command | `--entrypoint` |

Always use the **exec form** (`["a","b"]`). The shell form runs under `/bin/sh -c`, so your app is not PID 1.

```bash
podman run --rm localhost:5000/webapp:v1 -c 'print("args are passed to ENTRYPOINT")'
```

## Task 8: Security checklist

- Use a minimal, trusted base image such as UBI.
- Run as a non-root `USER`.
- Never put secrets in `ENV`, `ARG`, or a `RUN` line. They stay in the image layers.
- Combine `RUN` steps and clean package caches.
- Use ports above 1024.
- For OpenShift compatibility, set group 0 permissions: `COPY --chown=1001:0 ...` and `RUN chmod -R g=u /app`.
- `EXPOSE` only documents a port. You still need `-p` to publish it.

Prove the secret rule:

```bash
podman history --no-trunc localhost:5000/webapp:v1 | grep -i APP_MSG
```

## Task 9: ENV vs ARG

| | `ARG` | `ENV` |
|---|---|---|
| Available during build | Yes | Yes |
| Available in the running container | **No** | **Yes** |
| Set at build time | `--build-arg` | No |
| Set at run time | No | `-e` |

## Task 10 (bonus): Multi-stage build

Use a `builder` stage and copy only the result into a final `ubi9/ubi-minimal` stage with `COPY --from=builder`.

## Check your work

```bash
podman run --rm localhost:5000/webapp:v1 -c 'import os; print(os.getuid())'   # 1001
curl http://127.0.0.1:8081                                                    # Hello from EX188
```
