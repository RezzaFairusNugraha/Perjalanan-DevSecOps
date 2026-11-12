#!/bin/bash
# Exercise 05 reference solution
set -x
podman network create app-net
printf 'S3cret!' | podman secret create db-password -
podman run -d --name db2 --network app-net --secret db-password,type=env,target=POSTGRESQL_PASSWORD \
  -e POSTGRESQL_USER=app -e POSTGRESQL_DATABASE=appdb quay.io/fedora/postgresql-16
podman run --rm --network app-net registry.access.redhat.com/ubi9/ubi getent hosts db2

mkdir -p ~/exam-work/stack/conf && cd ~/exam-work/stack
echo "# app config" > conf/app.conf
cat > compose.yaml <<'EOF'
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
EOF
podman compose up -d
podman compose ps
curl -I http://127.0.0.1:8083

podman pod create --name web-pod -p 8084:80
podman run -d --pod web-pod --name pod-web docker.io/library/nginx
podman run --rm --pod web-pod registry.access.redhat.com/ubi9/ubi curl -s localhost | head -5
podman kube generate web-pod -f web-pod.yaml
