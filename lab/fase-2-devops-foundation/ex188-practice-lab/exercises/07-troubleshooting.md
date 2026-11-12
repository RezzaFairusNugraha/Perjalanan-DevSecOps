# Exercise 07 — Troubleshooting Containerized Applications

Jalankan `./lab-setup.sh` lalu `./break-lab.sh` (membuat 5 skenario rusak). Perbaiki semuanya.

| # | Gejala | Alat diagnosis |
|---|---|---|
| 1 | `broken-port` exit/ tidak bisa diakses | `podman ps -a`, `podman port`, `podman logs` |
| 2 | `broken-perm` log `Permission denied` pada bind mount | `podman logs`, `ls -Z`, `ausearch -m avc`, `:Z` / keep-id |
| 3 | `broken-env` aplikasi crash karena variabel hilang | `podman inspect --format '{{.Config.Env}}'`, `-e` |
| 4 | `broken-dns` app tak bisa resolve `db` | `podman network inspect`, `--network` |
| 5 | `broken-oom` container ter-kill | `podman inspect --format '{{.State.OOMKilled}}'`, `--memory` |

## Remote debugging (DO188 bab 6)
- Masuk shell: `podman exec -it NAME /bin/sh`; image tanpa shell → `podman cp`, `podman diff`, `podman logs`.
- Debug container yang crash: `podman run --rm -it --entrypoint /bin/sh IMAGE` atau `podman commit` lalu jalankan.
- Port debug aplikasi: publish port debugger (`-p 127.0.0.1:5005:5005`) dan sambungkan dari host.
- Tambah tool sementara: `podman exec -u 0 NAME microdnf install -y procps-ng iproute`.
- Logging: `--log-driver journald` dan `journalctl CONTAINER_NAME=NAME`; `podman logs --since`.
- Resource: `podman inspect --format '{{.HostConfig.Memory}} {{.State.Pid}}'`.

## Teknik umum
- `podman logs -f --tail 50 NAME`, `podman events`, `podman inspect NAME --format ...`
- `podman exec -it NAME /bin/sh`, `podman top`, `podman stats --no-stream`, `podman diff`
- `podman run --rm -it --entrypoint /bin/sh IMAGE` untuk debug image yang langsung exit
- `podman healthcheck run NAME`, `podman system df`, `podman info`
- `podman unshare`, `podman system migrate` (setelah ubah subuid)
- Baca exit code: `podman inspect --format '{{.State.ExitCode}}'` (125 podman, 126/127 command, 137 SIGKILL/OOM)
