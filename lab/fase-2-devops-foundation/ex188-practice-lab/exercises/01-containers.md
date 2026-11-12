# Exercise 01 — Run Containers Locally

**Objective:** run containers, logs, events, inspect, environment, expose ports, lifecycle.

## Tasks

1. Jalankan container detached `my-web` dari `registry.access.redhat.com/ubi9/httpd-24`
   (atau `docker.io/library/httpd:2.4`), publish host `127.0.0.1:8080` → container `8080`
   (ubi9/httpd-24 listen di 8080; httpd:2.4 di 80). Verifikasi dengan `curl`.
2. Dengan `podman inspect --format` ambil: (a) image, (b) command/entrypoint,
   (c) IP address container, (d) port mapping. Gunakan `podman port`.
3. Buka terminal kedua: `podman events --filter container=my-web` lalu `podman restart my-web`;
   catat event `died/start`. Gunakan juga `--since` / `--until`.
4. Lihat log: `podman logs --tail 5 -f my-web`, lalu `--since 10m`, `-t`.
5. `podman exec` untuk membuat `/tmp/hello.txt` berisi `Hello EX188`; `podman cp` file host
   `local.txt` ke container dan sebaliknya.
6. Jalankan `my-env` (ubi9) dengan `-e exam=ex188` dan `--env-file` (file `app.env` berisi
   `LEVEL=dev`), command `env`. Cek `podman logs my-env`.
7. Jalankan container interaktif sekali pakai: `podman run --rm -it ubi9 cat /etc/os-release`.
8. Lifecycle: `stop`, `start`, `pause`, `unpause`, `kill -s`, `rm -f`, `--restart=on-failure`,
   `podman ps -a --filter status=exited`, `podman container prune`.
9. Batasi resource: `--memory 128m --cpus 0.5`; verifikasi dengan `podman inspect` dan `podman stats --no-stream`.
10. Cleanup semua container.

## Verifikasi
`podman ps -a`, `curl -s 127.0.0.1:8080`, `podman logs my-env | grep exam=ex188`.
