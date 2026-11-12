#!/bin/bash
# Exercise 02 reference solution
set -x
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
cat > Containerfile <<'EOF'
FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
LABEL maintainer="student@example.com"
ARG APP_VERSION=1.0
ENV APP_MSG="EX188" APP_PORT=8080
RUN microdnf install -y python3 && microdnf clean all
WORKDIR /app
COPY app.py .
VOLUME /data
EXPOSE 8080
USER 1001
ENTRYPOINT ["python3"]
CMD ["app.py"]
EOF
podman build -t localhost:5000/webapp:v1 --build-arg APP_VERSION=1.1 .
podman run -d --name web1 -p 8081:8080 localhost:5000/webapp:v1
sleep 2; curl http://127.0.0.1:8081
podman exec web1 id
podman image inspect localhost:5000/webapp:v1 --format 'User={{.Config.User}} Dir={{.Config.WorkingDir}} Ports={{.Config.ExposedPorts}}'

# ADD vs COPY
mkdir -p site && echo hi > site/index.html && tar czf site.tar.gz -C site .
cat > Containerfile.add <<'EOF'
FROM registry.access.redhat.com/ubi9/ubi-minimal
ADD site.tar.gz /opt/added/
COPY site.tar.gz /opt/copied/
EOF
podman build -f Containerfile.add -t add-test .
podman run --rm add-test ls -R /opt
