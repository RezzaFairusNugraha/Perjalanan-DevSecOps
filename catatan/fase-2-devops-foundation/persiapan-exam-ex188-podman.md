# Persiapan Sertifikasi Red Hat EX188 — Podman & Container Fundamentals

## 🎯 Tujuan

Mempersiapkan diri menghadapi ujian sertifikasi **Red Hat Certified Specialist in Containers (EX188)** dengan mendalami penggunaan **Podman**, pengelolaan image container, persistent storage, pod, serta integrasi service systemd pada sistem operasi berbasis enterprise (RHEL).

Target pembelajaran:
- Memahami konsep arsitektur **Podman** (*daemonless* dan *rootless*) dibandingkan Docker.
- Menguasai manajemen lifecycle container menggunakan perintah CLI Podman.
- Mampu membuat, mengoptimalkan, dan mengamankan image container menggunakan `Containerfile` / `Dockerfile`.
- Mengelola persistent storage menggunakan volume dan bind mounts dengan memperhatikan konteks **SELinux** (`:Z` flag).
- Mengelola multi-container menggunakan konsep **Pod** lokal di Podman serta mengekspornya menjadi format Kubernetes YAML.
- Mengonfigurasi container agar berjalan otomatis sebagai **systemd service** di level user (*rootless autostart*).

---

## 📚 Ringkasan Materi & Objektif Ujian EX188

### 1. Arsitektur Podman (Daemonless & Rootless)
- **Tanpa Daemon (Daemonless):** Podman tidak memerlukan background service/daemon terpusat seperti Docker (`dockerd`). Setiap container berjalan langsung sebagai child process dari user yang mengeksekusinya.
- **Rootless by Default:** Pengguna non-root dapat menjalankan container dengan aman menggunakan fitur Linux user namespaces (`subuid` dan `subgid`). Jika container mengalami pembobolan (*container breakout*), attacker tidak akan mendapatkan hak akses root pada host server.

### 2. Perintah Penting Manajemen Container
```bash
# Mencari dan mengunduh image dari registry
podman search registry.access.redhat.com/ubi9
podman pull ubi9/ubi-minimal

# Menjalankan container dengan port forwarding & background mode
podman run -d --name web-app -p 8080:8080 ubi9/httpd-24

# Memeriksa container aktif dan seluruh container
podman ps
podman ps -a

# Memeriksa log dan inspeksi container
podman logs -f web-app
podman inspect web-app

# Menghentikan dan menghapus container
podman stop web-app
podman rm web-app
```

### 3. Pembuatan Container Image (`Containerfile`)
Dalam standar Red Hat, file instruksi biasanya dinamakan `Containerfile` (identik dengan `Dockerfile`):
```dockerfile
FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

# Update & install dependensi
RUN microdnf install -y python3 && microdnf clean all

# Best practice keamanan: gunakan user non-root
WORKDIR /app
COPY app.py /app/

USER 1001
EXPOSE 8080

CMD ["python3", "app.py"]
```
Perintah build:
```bash
podman build -t my-app:1.0 -f Containerfile .
```

### 4. Persistent Storage & Flag SELinux
Karena RHEL mengaktifkan SELinux secara default, bind mount host directory memerlukan flag `:Z` (private label) atau `:z` (shared label) agar container memiliki izin membaca/menulis ke folder host:
```bash
# Membuat named volume
podman volume create db-data

# Menjalankan container dengan volume
podman run -d --name db -v db-data:/var/lib/mysql:Z -e MYSQL_ROOT_PASSWORD=secret mysql

# Bind mount direktori host ke container
podman run -d -v /home/user/web:/var/www/html:Z -p 8080:80 httpd
```

### 5. Mengelola Podman Pods (Kubernetes-Ready)
Podman dapat mengelompokkan beberapa container ke dalam satu **Pod** yang berbagi namespace jaringan dan localhost yang sama:
```bash
# Membuat pod dengan port mapping
podman pod create --name web-pod -p 8080:80

# Menjalankan container di dalam pod
podman run -d --pod web-pod --name web-server httpd

# Menghasilkan manifest Kubernetes YAML dari Podman
podman generate kube web-pod > web-pod.yaml
```

### 6. Autostart via Systemd (Rootless Service)
Fitur unggulan RHEL untuk menjalankan container secara otomatis saat server boot tanpa user harus login:
```bash
# Generate file unit systemd untuk container
cd ~/.config/systemd/user/
podman generate systemd --new --files --name web-app

# Aktifkan service systemd
systemctl --user daemon-reload
systemctl --user enable --now container-web-app.service

# Pastikan proses user tetap berjalan saat logout
loginctl enable-linger $USER
```

---

## 💻 Checklist Persiapan EX188

- [x] Memahami konsep rootless & daemonless container di Podman.
- [x] **Exercise 01 — Container Basics** (`run`, `inspect`, `exec`, `cp`, `env`, cleanup).
- [x] **Exercise 02 — Image Management** (membuat `Containerfile` UBI9 non-root, build, tag, push ke registry lokal, `skopeo`).
- [x] **Exercise 03 — Persistent Storage** (bind mount, read-only `:ro`, SELinux label `:Z`, dan named volume).
- [ ] Latihan membuat Podman Pods dan export ke Kubernetes YAML.
- [ ] Latihan konfigurasi container sebagai service systemd user.
- [ ] Simulasi pengerjaan soal lab sesuai batas waktu ujian.

---

## 🧠 Hubungan dengan DevSecOps

Mempelajari Podman untuk ujian EX188 melatih implementasi keamanan kontainer nyata:
1. **Container Hardening:** Menghindari container berjalan sebagai `root`.
2. **Minimal Base Image:** Menggunakan image minimal (seperti UBI Minimal) untuk memperkecil *attack surface* (celah kerentanan paket).
3. **Pondasi Kubernetes:** Konsep Pod pada Podman mempermudah transisi menuju orkestrasi container dan pengamanan pipeline di Fase 4 & 5.

---

## 📌 Next

Melanjutkan latihan praktikum perintah CLI Podman dan penyelesaian lab simulasi EX188.
