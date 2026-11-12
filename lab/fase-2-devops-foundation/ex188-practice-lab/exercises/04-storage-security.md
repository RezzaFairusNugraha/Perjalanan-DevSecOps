# Exercise 04 — Volumes, Host Data, Security & Permissions

## Tasks

1. **Bind mount + SELinux**: jalankan `persistent-web` (`ubi9/httpd-24`) dengan
   `-v ~/ex188-data/html:/var/www/html:Z -p 8080:8080`. `curl` harus menampilkan isi `index.html`.
   Ubah file di host, curl lagi. Kenapa `:Z` vs `:z`? Cek `ls -Z`.
2. **Read-only**: ulangi dengan `:ro,Z`; tulis dari dalam container harus gagal.
3. **Named volume**: `podman volume create my-db-data`; `db-test` menulis `/data/file.txt`;
   hapus container; `db-verify` mengonfirmasi file masih ada. `podman volume inspect` (cari `Mountpoint`).
4. **Rootless UID mapping**: bind-mount `~/ex188-data/mysql` untuk container user 1001.
   Selesaikan `Permission denied` dengan salah satu:
   `--userns=keep-id:uid=1001,gid=1001` atau `podman unshare chown 1001:1001 ~/ex188-data/mysql`.
5. **tmpfs & anonymous volume**: `--tmpfs /tmp:rw,size=16m`; `--mount type=bind,src=...,dst=...,ro`.
6. **Hak istimewa**: jalankan container `--cap-drop=ALL --cap-add=NET_BIND_SERVICE --read-only
   --security-opt no-new-privileges`. Cek `podman inspect` → `HostConfig.CapDrop`, `ReadonlyRootfs`.
7. **Akses jaringan/host**: tunjukkan beda `--network none`, `--network host`,
   `-p 127.0.0.1:8082:8080`. Jelaskan kenapa rootless tidak boleh `-p 80:80`.
8. Jangan pakai `--privileged` kecuali diminta; jelaskan risikonya.
9. Cleanup volume: `podman volume prune`, `podman volume rm`.

## Verifikasi
`podman volume ls`, `podman inspect persistent-web --format '{{range .Mounts}}{{.Source}} {{.RW}}{{end}}'`.
