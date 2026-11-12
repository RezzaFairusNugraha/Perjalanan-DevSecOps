#!/bin/bash
# Exercise 01 reference solution
set -x
mkdir -p ~/exam-work && cd ~/exam-work
podman run -d --name my-web -p 127.0.0.1:8080:8080 registry.access.redhat.com/ubi9/httpd-24
podman inspect my-web --format '{{.ImageName}}'
podman inspect my-web --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
podman port my-web
podman restart my-web
podman events --since 5m --until 0s --filter container=my-web
podman logs --tail 5 my-web
podman exec my-web sh -c 'echo "Hello EX188" > /tmp/hello.txt'
podman cp ~/exam-work/local.txt my-web:/tmp/local_copy.txt
podman cp my-web:/etc/httpd/conf/httpd.conf ./httpd.conf
echo "LEVEL=dev" > app.env
podman run --name my-env -e exam=ex188 --env-file app.env registry.access.redhat.com/ubi9/ubi env
podman logs my-env | grep -E 'exam|LEVEL'
podman run -d --name limited --memory 128m --cpus 0.5 registry.access.redhat.com/ubi9/ubi sleep 600
podman inspect limited --format '{{.HostConfig.Memory}} {{.HostConfig.NanoCpus}}'
