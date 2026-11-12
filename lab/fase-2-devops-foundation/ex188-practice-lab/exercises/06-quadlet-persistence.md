# Exercise 06 — Persistence across Reboot (Quadlet)

> `podman generate systemd` deprecated. Pada Podman 5 / RHEL 10 pakai **Quadlet**
> (`man podman-systemd.unit`). Rootless: `~/.config/containers/systemd/`.

## Tasks

1. `loginctl enable-linger $USER` agar service user hidup tanpa login.
2. Buat `~/.config/containers/systemd/auto-web.container`:
   ```ini
   [Unit]
   Description=Auto web
   After=network-online.target

   [Container]
   ContainerName=auto-web
   Image=registry.access.redhat.com/ubi9/httpd-24
   PublishPort=8082:8080
   Volume=%h/ex188-data/html:/var/www/html:ro,Z
   Environment=EXAM=ex188

   [Service]
   Restart=always

   [Install]
   WantedBy=default.target
   ```
3. `systemctl --user daemon-reload && systemctl --user start auto-web.service`
   (unit `[Install]` di Quadlet bersifat *generated*; aktif lewat `WantedBy`, tidak perlu `enable`).
   Debug: `/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun`.
4. Verifikasi: `systemctl --user status auto-web`, `podman ps`, `curl 127.0.0.1:8082`,
   `journalctl --user -u auto-web`.
5. Quadlet lain: `.volume`, `.network`, `.kube` (`Yaml=web-pod.yaml`), `.pod`.
6. Auto-update (bonus): `AutoUpdate=registry`, `systemctl --user enable --now podman-auto-update.timer`.
7. Uji `systemctl --user restart auto-web` dan, bila boleh, **reboot**.

## Verifikasi
Container kembali berjalan setelah reboot tanpa perintah manual.
