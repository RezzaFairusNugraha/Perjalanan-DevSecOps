# Exercise 07 — Troubleshooting Containerized Applications

Jalankan `./lab-setup.sh` lalu `./break-lab.sh` (membuat 5 skenario rusak). Perbaiki semuanya.

| # | Gejala | Alat diagnosis |
|---|---|---|
| 1 | `broken-port` exit/ tidak bisa diakses | `podman ps -a`, `podman port`, `podman logs` |
| 2 | `broken-perm` log `Permission denied` pada bind mount | `podman logs`, `ls -Z`, `ausearch -m avc`, `:Z` / keep-id |
| 3 | `broken-env` aplikasi crash karena variabel hilang | `podman inspect --format '{{.Config.Env}}'`, `-e` |
| 4 | `broken-dns` app tak bisa resolve `db` | `podman network inspect`, `--network` |
| 5 | `broken-oom` container ter-kill | `podman inspect --format '{{.State.OOMKilled}}'`, `--memory` |

## Teknik umum
- `podman logs -f --tail 50 NAME`, `podman events`, `podman inspect NAME --format ...`
- `podman exec -it NAME /bin/sh`, `podman top`, `podman stats --no-stream`, `podman diff`
- `podman run --rm -it --entrypoint /bin/sh IMAGE` untuk debug image yang langsung exit
- `podman healthcheck run NAME`, `podman system df`, `podman info`
- `podman unshare`, `podman system migrate` (setelah ubah subuid)
- Baca exit code: `podman inspect --format '{{.State.ExitCode}}'` (125 podman, 126/127 command, 137 SIGKILL/OOM)
