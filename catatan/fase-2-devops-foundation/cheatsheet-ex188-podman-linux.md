# Cheat Sheet Lengkap: Red Hat EX188 (Podman, SELinux, Systemd & Networking)

Ringkasan perintah wajib (*quick reference*) untuk persiapan ujian **Red Hat Certified Specialist in Containers (EX188)** di **Rocky Linux 9 / RHEL 9**.

---

## 1. Registry & Image Management (`podman` & `skopeo`)

```bash
# Login ke container registry
podman login registry.access.redhat.com
podman login localhost:5000 --tls-verify=false

# Mencari dan mengunduh image
podman search ubi9
podman pull registry.access.redhat.com/ubi9/ubi-minimal:latest

# Melihat daftar image lokal
podman images

# Memberi tag baru pada image
podman tag localhost:5000/my-app:v1 localhost:5000/my-app:latest

# Push image ke local/insecure registry
podman push --tls-verify=false localhost:5000/my-app:v1

# Inspeksi tag di remote registry tanpa pull image (menggunakan skopeo)
skopeo list-tags docker://localhost:5000/my-app --tls-verify=false
skopeo inspect docker://localhost:5000/my-app:v1 --tls-verify=false

# Menghapus image lokal
podman rmi localhost:5000/my-app:v1
```

---

## 2. Container Lifecycle & Debugging

```bash
# Menjalankan container di background (-d) dengan port forwarding (-p) dan env var (-e)
podman run -d --name web-srv -p 8080:80 -e APP_ENV=prod docker.io/library/nginx

# Melihat container yang sedang berjalan & semua container
podman ps
podman ps -a

# Membaca log container
podman logs web-srv
podman logs -f web-srv

# Mengeksekusi perintah di dalam container yang sedang berjalan
podman exec -it web-srv /bin/sh
podman exec web-srv cat /etc/os-release

# Menyalin file antara Host dan Container
podman cp ./config.json web-srv:/tmp/config.json
podman cp web-srv:/etc/nginx/nginx.conf ./nginx.conf.bak

# Mengambil informasi spesifik container menggunakan format Go-template atau grep
podman inspect -f '{{.NetworkSettings.IPAddress}}' web-srv
podman inspect -f '{{.Config.Cmd}}' web-srv
podman inspect web-srv | grep -i IPAddress

# Menghentikan, merestart, dan menghapus container
podman stop web-srv
podman restart web-srv
podman rm -f web-srv
```

---

## 3. Menyusun `Containerfile` Standar EX188

```dockerfile
FROM registry.access.redhat.com/ubi9/ubi:latest
LABEL maintainer="rezza@ex188.lab"

# Instalasi paket dan bersihkan cache metadata
RUN dnf install -y python3 && dnf clean all

# Direktori kerja di dalam container
WORKDIR /app

# Salin kode aplikasi ke dalam container
COPY app.py /app/

# Jalankan sebagai non-root user (Prinsip Least Privilege)
USER 1001

# Environment variable default & dokumentasi port
ENV PORT=8080
EXPOSE 8080

# Perintah utama saat container dijalankan
CMD ["python3", "app.py"]
```

Perintah build:
```bash
podman build -t localhost:5000/custom-python:v1 -f Containerfile .
```

---

## 4. Persistent Storage & Konteks SELinux (`:Z`, `:z`, `:ro`)

```bash
# 1. Bind Mount direktori host dengan relabeling SELinux privat (:Z)
mkdir -p ~/web-data
podman run -d --name nginx-persist -p 8080:80 \
  -v ~/web-data:/usr/share/nginx/html:Z \
  docker.io/library/nginx

# 2. Bind Mount dalam mode Read-Only (:ro,Z)
podman run -d --name nginx-ro -p 8081:80 \
  -v ~/web-data:/usr/share/nginx/html:ro,Z \
  docker.io/library/nginx

# 3. Named Volume (dikelola otomatis oleh Podman di ~/.local/share/containers/storage/volumes)
podman volume create db-vol
podman volume ls
podman volume inspect db-vol
podman run -d --name mariadb-srv -v db-vol:/var/lib/mysql:Z -e MYSQL_ROOT_PASSWORD=secret mariadb

# Catatan Penting User Namespace di Rootless Podman:
# Mengubah kepemilikan folder host agar cocok dengan UID di dalam container rootless
podman unshare chown -R 1001:1001 ~/web-data
```

---

## 5. Custom Network & Podman Pods (Kubernetes YAML)

```bash
# Membuat custom bridge network di Podman
podman network create app-net
podman network ls

# Membuat Pod (sekumpulan container yang berbagi IP/localhost & port)
podman pod create --name my-pod -p 8080:80

# Menjalankan container di dalam Pod yang sudah dibuat
podman run -d --pod my-pod --name pod-web docker.io/library/nginx

# Mengecek status Pod dan container di dalamnya
podman pod ps
podman ps --pod

# Generate manifest Kubernetes YAML dari Pod atau Container
podman generate kube my-pod > my-pod-k8s.yaml

# Menjalankan ulang Pod dari file Kubernetes YAML
podman play kube my-pod-k8s.yaml
```

---

## 6. Autostart Rootless Container dengan Systemd

Ini adalah salah satu topik paling krusial di ujian **Red Hat EX188**:

```bash
# 1. Pastikan berada di user biasa (bukan root) dan buat direktori systemd user
mkdir -p ~/.config/systemd/user
cd ~/.config/systemd/user

# 2. Generate file service systemd dari container yang sedang berjalan
#    Flag --new memastikan container selalu dibuat ulang secara bersih saat start/stop
podman generate systemd --new --files --name web-srv

# 3. Reload daemon systemd level user
systemctl --user daemon-reload

# 4. Enable dan start service container
systemctl --user enable --now container-web-srv.service

# 5. Aktifkan linger agar service user tetap menyala saat boot walaupun user belum login
loginctl enable-linger $USER
loginctl show-user $USER | grep Linger

# 6. Verifikasi status & log service systemd
systemctl --user status container-web-srv.service
journalctl --user -u container-web-srv.service --no-pager
```
