#!/bin/bash
# Reference solutions for mock exam (rootless, Podman 5)
set -x
W=$HOME/exam-work; mkdir -p $W/{logistics,site,shop/conf} $HOME/ex188-data/auth
echo "alpha site" > $W/site/index.html

# 1
podman run -d --name alpha-web -p 127.0.0.1:8090:8080 -e SITE=alpha --memory 256m registry.access.redhat.com/ubi9/httpd-24

# 2
cat > $W/logistics/Containerfile <<'EOF'
FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
ARG VERSION=1.0
ENV APP_ENV=prod
RUN microdnf install -y python3 && microdnf clean all
WORKDIR /srv
COPY index.html .
EXPOSE 8080
USER 1001
ENTRYPOINT ["python3","-m","http.server"]
CMD ["8080"]
EOF
echo logistics > $W/logistics/index.html
podman build -t localhost:5000/logistics-app:1.0 --build-arg VERSION=1.0 $W/logistics

# 3
podman tag localhost:5000/logistics-app:1.0 localhost:5000/logistics-app:latest
podman push --tls-verify=false localhost:5000/logistics-app:1.0
podman push --tls-verify=false localhost:5000/logistics-app:latest
podman rmi localhost:5000/logistics-app:1.0 localhost:5000/logistics-app:latest
podman pull --tls-verify=false localhost:5000/logistics-app:1.0

# 4
htpasswd -Bbn student redhat > $HOME/ex188-data/auth/htpasswd
podman run -d --name secure-registry -p 5001:5000 -v $HOME/ex188-data/auth:/auth:Z \
  -e REGISTRY_AUTH=htpasswd -e REGISTRY_AUTH_HTPASSWD_REALM=Registry \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd docker.io/library/registry:2
sudo tee /etc/containers/registries.conf.d/99-lab.conf <<'EOF'
[[registry]]
location = "localhost:5001"
insecure = true
EOF
podman login -u student -p redhat localhost:5001
podman tag localhost:5000/logistics-app:1.0 localhost:5001/logistics-app:1.0
podman push localhost:5001/logistics-app:1.0

# 5
podman save -o /tmp/exam-logistics.tar localhost:5000/logistics-app:1.0
podman export -o /tmp/exam-alpha.tar alpha-web

# 6 + 9 (Quadlet)
podman volume create logistics-data
loginctl enable-linger "$USER"
mkdir -p ~/.config/containers/systemd
cat > ~/.config/containers/systemd/logistics.container <<'EOF'
[Unit]
Description=Logistics app
[Container]
ContainerName=logistics
Image=localhost:5000/logistics-app:1.0
PublishPort=8091:8080
Volume=logistics-data:/data:Z
Volume=%h/exam-work/site:/srv/site:ro,Z
[Service]
Restart=always
[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user start logistics.service

# 7
printf 'S3cret!' | podman secret create db-pass -
podman network create shop-net
podman run -d --name shop-db --network shop-net --secret db-pass,type=env,target=POSTGRESQL_PASSWORD \
  -e POSTGRESQL_USER=shop -e POSTGRESQL_DATABASE=shopdb -v shop-data:/var/lib/pgsql/data:Z quay.io/fedora/postgresql-16

# 8
echo "# config" > $W/shop/conf/app.conf
cat > $W/shop/compose.yaml <<'EOF'
services:
  db:
    image: quay.io/fedora/postgresql-16
    environment: { POSTGRESQL_USER: app, POSTGRESQL_PASSWORD: pw, POSTGRESQL_DATABASE: appdb }
    healthcheck: { test: ["CMD","pg_isready","-U","app"], interval: 5s, retries: 10 }
  web:
    image: registry.access.redhat.com/ubi9/httpd-24
    depends_on: { db: { condition: service_healthy } }
    ports: ["8092:8080"]
    volumes: ["./conf/app.conf:/etc/httpd/conf.d/app.conf:ro,Z"]
EOF
(cd $W/shop && podman compose up -d)

# 10
podman rm -f fix-me
podman run -d --name fix-me --userns=keep-id:uid=1001,gid=1001 --user 1001 -v $W/site:/data:Z quay.io/libpod/alpine \
  sh -c 'echo x > /data/o; sleep 3600'
