#!/bin/bash
# EX188 multi-grader (Podman 5, rootless)
P="[PASS]"; F="[FAIL]"
chk() { # desc, command...
  local d="$1"; shift
  if "$@" &>/dev/null; then echo "$P $d"; else echo "$F $d"; fi
}
running() { [[ "$(podman inspect -f '{{.State.Running}}' "$1" 2>/dev/null)" == "true" ]]; }
http() { curl -fsS --max-time 5 "$1" 2>/dev/null | grep -q "$2"; }

g01() { echo "== 01 Containers"
  chk "my-web running" running my-web
  chk "my-web reachable on 127.0.0.1:8080" curl -fsS --max-time 5 http://127.0.0.1:8080
  chk "my-env logs contain exam=ex188" bash -c 'podman logs my-env | grep -q exam=ex188'
}
g02() { echo "== 02 Containerfile"
  chk "image localhost:5000/webapp:v1 exists" podman image exists localhost:5000/webapp:v1
  chk "image user is 1001" bash -c '[[ "$(podman image inspect -f "{{.Config.User}}" localhost:5000/webapp:v1)" == 1001 ]]'
  chk "workdir /app" bash -c '[[ "$(podman image inspect -f "{{.Config.WorkingDir}}" localhost:5000/webapp:v1)" == /app ]]'
  chk "EXPOSE 8080" bash -c 'podman image inspect -f "{{.Config.ExposedPorts}}" localhost:5000/webapp:v1 | grep -q 8080'
  chk "ENTRYPOINT python3" bash -c 'podman image inspect -f "{{.Config.Entrypoint}}" localhost:5000/webapp:v1 | grep -q python3'
  chk "web1 responds Hello from EX188" http http://127.0.0.1:8081 "Hello from EX188"
}
g03() { echo "== 03 Images/registries"
  chk "tags v1 & latest in registry" bash -c 'skopeo list-tags --tls-verify=false docker://localhost:5000/webapp | grep -q v1 && skopeo list-tags --tls-verify=false docker://localhost:5000/webapp | grep -q latest'
  chk "saved archive /tmp/webapp.tar" test -s /tmp/webapp.tar
  chk "exported fs /tmp/web1-fs.tar" test -s /tmp/web1-fs.tar
  chk "imported image exists" podman image exists localhost:5000/webapp-imported:v1
}
g04() { echo "== 04 Storage/security"
  chk "persistent-web serves index" http http://127.0.0.1:8080 "EX188"
  chk "volume my-db-data" podman volume exists my-db-data
  chk "db-verify saw file" bash -c 'podman run --rm -v my-db-data:/data:Z registry.access.redhat.com/ubi9/ubi test -f /data/file.txt'
  chk "persistent-web mount is read-only" bash -c '[[ "$(podman inspect -f "{{range .Mounts}}{{.RW}}{{end}}" persistent-web)" == false ]]'
}
g05() { echo "== 05 Multi-container"
  chk "secret db-password" podman secret exists db-password
  chk "network app-net" podman network exists app-net
  chk "compose web on 8083" curl -fsS --max-time 5 http://127.0.0.1:8083
  chk "pod web-pod" podman pod exists web-pod
}
g06() { echo "== 06 Quadlet persistence"
  chk "linger enabled" bash -c 'loginctl show-user $USER -p Linger | grep -q yes'
  chk "quadlet file exists" test -f "$HOME/.config/containers/systemd/auto-web.container"
  chk "auto-web.service active" systemctl --user is-active --quiet auto-web.service
  chk "auto-web on 8082" curl -fsS --max-time 5 http://127.0.0.1:8082
  chk "unit has Restart=always" grep -q "Restart=always" "$HOME/.config/containers/systemd/auto-web.container"
}
g07() { echo "== 07 Troubleshooting"
  chk "broken-port reachable on 9090 -> fixed" curl -fsS --max-time 5 http://127.0.0.1:9090
  chk "broken-perm running without error" bash -c '! podman logs broken-perm 2>&1 | grep -qi "permission denied"'
  chk "broken-env running" running broken-env
  chk "broken-dns resolves db" bash -c 'podman exec broken-dns getent hosts db'
  chk "broken-oom not OOMKilled" bash -c '[[ "$(podman inspect -f "{{.State.OOMKilled}}" broken-oom)" == false ]]'
}
gm() { [[ -x ./grade-exam.sh ]] && ./grade-exam.sh || echo "$F run mock exam grader: ./grade-exam.sh"; }

case "${1:-}" in
  01) g01;; 02) g02;; 03) g03;; 04) g04;; 05) g05;; 06) g06;; 07) g07;; mock) gm;;
  all) g01; g02; g03; g04; g05; g06; g07;;
  *) PS3="Choice: "; select o in 01 02 03 04 05 06 07 mock all quit; do
       case $o in quit) break;; "") ;; *) "$0" "$o";; esac; done;;
esac
