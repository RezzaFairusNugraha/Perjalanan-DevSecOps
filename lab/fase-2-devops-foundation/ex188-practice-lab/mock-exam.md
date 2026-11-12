# Mock Exam EX188 (2,5 jam, rootless user `student`, Podman 5)

Kerjakan berurutan. Hasil harus **persisten setelah reboot**. Boleh pakai `man`; tanpa internet selain registry yang disebut.

| # | Task | Pts |
|---|---|---|
| 1 | Jalankan `alpha-web` dari `registry.access.redhat.com/ubi9/httpd-24`, publish `127.0.0.1:8090→8080`, env `SITE=alpha`, resource `--memory 256m`. | 8 |
| 2 | Bangun image `localhost:5000/logistics-app:1.0` dari Containerfile di `~/exam-work/logistics`: base `ubi9/ubi-minimal`, install `python3`, WORKDIR `/srv`, `USER 1001`, `ARG VERSION`, `ENV APP_ENV=prod`, `EXPOSE 8080`, `ENTRYPOINT ["python3","-m","http.server"]`, `CMD ["8080"]`. | 12 |
| 3 | Tag `latest` & `1.0`, push ke `localhost:5000` (insecure). Hapus lokal lalu pull ulang. | 8 |
| 4 | Registry privat `localhost:5001` (htpasswd user `student/redhat`): login, push `logistics-app:1.0`, dan jadikan `5001` insecure secara permanen di `registries.conf.d`. | 10 |
| 5 | Backup image dengan `podman save` (`/tmp/exam-logistics.tar`); backup filesystem container `alpha-web` dengan `podman export` (`/tmp/exam-alpha.tar`). | 6 |
| 6 | Buat volume `logistics-data`, bind mount `~/exam-work/site` (`:ro,Z`) ke container `logistics` dari image task 2 (port `8091`). Data di volume harus bertahan setelah container dihapus. | 10 |
| 7 | Secret `db-pass` dan network `shop-net`; jalankan `shop-db` (postgresql-16) dengan secret sebagai env `POSTGRESQL_PASSWORD`, user `shop`, DB `shopdb`, volume `shop-data`. | 10 |
| 8 | `compose.yaml` di `~/exam-work/shop`: service `db` (healthcheck) + `web` (`depends_on: service_healthy`, port `8092`, config `:ro,Z`). `podman compose up -d`. | 12 |
| 9 | Jadikan `logistics` (task 6) layanan **Quadlet** rootless (`Restart=always`, `loginctl enable-linger`), aktif otomatis saat boot. | 12 |
| 10 | Troubleshoot: container `fix-me` (lihat catatan) gagal menulis; temukan penyebab dari `logs/inspect` & perbaiki. | 12 |

**Catatan task 10:** jalankan
`podman run -d --name fix-me --user 1001 -v ~/exam-work/site:/data quay.io/libpod/alpine sh -c 'echo x > /data/o; sleep 3600'`
dan perbaiki sampai tidak ada `Permission denied` (hint: SELinux/UID mapping).

Skor lulus ≈ 70%. Solusi: `solutions/mock-exam.sh`.
