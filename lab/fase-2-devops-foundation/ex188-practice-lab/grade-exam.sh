#!/bin/bash
# Grader for mock-exam.md (100 points)
score=0
award() { # points description command...
  local p=$1 d=$2; shift 2
  if "$@" &>/dev/null; then echo "[PASS] +$p  $d"; score=$((score+p)); else echo "[FAIL]  0  $d"; fi
}
insp() { podman inspect -f "$2" "$1" 2>/dev/null; }

echo "== Task 1"
award 4 "alpha-web published on 127.0.0.1:8090" bash -c 'curl -fsS --max-time 5 http://127.0.0.1:8090'
award 2 "alpha-web has SITE=alpha" bash -c 'podman inspect -f "{{.Config.Env}}" alpha-web | grep -q SITE=alpha'
award 2 "alpha-web memory limit is 256m" bash -c '[[ "$(podman inspect -f "{{.HostConfig.Memory}}" alpha-web)" == 268435456 ]]'

echo "== Task 2"
I=localhost:5000/logistics-app:1.0
award 3 "image $I exists" podman image exists $I
award 3 "user 1001 and workdir /srv" bash -c "[[ \"\$(podman image inspect -f '{{.Config.User}} {{.Config.WorkingDir}}' $I)\" == '1001 /srv' ]]"
award 3 "ENV APP_ENV=prod and port 8080 exposed" bash -c "podman image inspect -f '{{.Config.Env}} {{.Config.ExposedPorts}}' $I | grep -q APP_ENV=prod"
award 3 "ENTRYPOINT python3 and CMD 8080" bash -c "podman image inspect -f '{{.Config.Entrypoint}} {{.Config.Cmd}}' $I | grep -q 'python3.*8080'"

echo "== Task 3"
award 8 "tags 1.0 and latest in :5000" bash -c 't=$(skopeo list-tags --tls-verify=false docker://localhost:5000/logistics-app); echo "$t" | grep -q 1.0 && echo "$t" | grep -q latest'

echo "== Task 4"
award 4 "registry on :5001 pushed 1.0" bash -c 'skopeo list-tags --tls-verify=false --creds student:redhat docker://localhost:5001/logistics-app | grep -q 1.0'
award 3 "login stored" bash -c 'grep -q 5001 ${XDG_RUNTIME_DIR}/containers/auth.json'
award 3 "5001 insecure in registries.conf.d" bash -c 'grep -rq "localhost:5001" /etc/containers/registries.conf.d/'

echo "== Task 5"
award 3 "/tmp/exam-logistics.tar" test -s /tmp/exam-logistics.tar
award 3 "/tmp/exam-alpha.tar" test -s /tmp/exam-alpha.tar

echo "== Task 6"
award 3 "logistics on 8091" bash -c 'curl -fsS --max-time 5 http://127.0.0.1:8091'
award 3 "volume logistics-data mounted at /data" bash -c 'podman inspect -f "{{range .Mounts}}{{.Name}}:{{.Destination}} {{end}}" logistics | grep -q logistics-data:/data'
award 4 "site mounted read-only at /srv/site" bash -c 'podman inspect -f "{{range .Mounts}}{{.Destination}}={{.RW}} {{end}}" logistics | grep -q "/srv/site=false"'

echo "== Task 7"
award 2 "secret db-pass" podman secret exists db-pass
award 2 "network shop-net" podman network exists shop-net
award 3 "shop-db running with env secret" bash -c 'podman exec shop-db printenv POSTGRESQL_PASSWORD | grep -q .'
award 3 "shop-db on shop-net with volume shop-data" bash -c 'podman inspect shop-db | grep -q shop-net && podman inspect shop-db | grep -q shop-data'

echo "== Task 8"
award 4 "compose.yaml exists" test -f ~/exam-work/shop/compose.yaml
award 4 "web answers on 8092" bash -c 'curl -sI --max-time 5 http://127.0.0.1:8092 | grep -q HTTP'
award 4 "compose uses healthcheck and service_healthy" bash -c 'grep -q healthcheck ~/exam-work/shop/compose.yaml && grep -q service_healthy ~/exam-work/shop/compose.yaml'

echo "== Task 9"
award 4 "linger enabled" bash -c 'loginctl show-user $USER -p Linger | grep -q yes'
award 4 "Quadlet file for logistics" bash -c 'ls ~/.config/containers/systemd/*.container | xargs grep -l logistics'
award 4 "logistics.service active, Restart=always" bash -c 'systemctl --user is-active --quiet logistics.service && grep -q Restart=always ~/.config/containers/systemd/logistics.container'

echo "== Task 10"
award 12 "fix-me writes without Permission denied" bash -c '! podman logs fix-me 2>&1 | grep -qi "permission denied" && test -f ~/exam-work/site/o'

echo
echo "TOTAL: $score / 100   (pass mark about 70)"
