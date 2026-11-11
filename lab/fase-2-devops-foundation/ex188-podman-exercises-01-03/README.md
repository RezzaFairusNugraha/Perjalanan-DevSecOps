# Lab Hands-On EX188 — Exercise 01, 02, & 03 (Podman Lifecycle, Image, & Storage)

## 🎯 Tujuan

Mendokumentasikan praktik *hands-on* langsung persiapan ujian **Red Hat EX188** yang telah berhasil dijalankan di environment lab Podman:
1. **Exercise 01 — Container Basics:** Menguasai manajemen lifecycle container, inspeksi, eksekusi command internal, penyalinan file (`podman cp`), dan environment variables.
2. **Exercise 02 — Image Management:** Membangun custom image non-root dengan `Containerfile` (UBI 9), tagging, push ke local registry (`localhost:5000`), dan inspeksi dengan `skopeo`.
3. **Exercise 03 — Persistent Storage:** Mengelola bind mounts & named volumes dengan label **SELinux** (`:Z`), mode read-only (`:ro`), serta verifikasi persistensi data antar container.

---

## 💻 Praktik & Perintah yang Dijalankan

### ✅ Exercise 01: Container Basics

1. **Menjalankan Container (`httpd:2.4`):**
   ```bash
   podman run -d --name my-web docker.io/library/httpd:2.4
   podman ps
   ```
2. **Inspeksi Detail Container (IP & Command):**
   ```bash
   podman inspect -f '{{.NetworkSettings.IPAddress}}' my-web
   podman inspect -f '{{.Config.Cmd}}' my-web
   ```
3. **Eksekusi Command di Dalam Container:**
   ```bash
   podman exec my-web sh -c 'echo "Hello EX188" > /tmp/hello.txt'
   podman exec my-web ls -l /tmp
   ```
4. **Menyalin File Host ↔ Container (`podman cp`):**
   ```bash
   echo "Host file" > local.txt
   podman cp local.txt my-web:/tmp/local_copy.txt
   podman cp my-web:/usr/local/apache2/conf/httpd.conf .
   ```
5. **Environment Variables (`ubi9`):**
   ```bash
   podman run --name my-env -e exam=ex188 registry.access.redhat.com/ubi9/ubi env
   podman logs my-env
   ```
6. **Cleanup:**
   ```bash
   podman stop my-web
   podman rm my-web my-env
   podman ps -a
   ```

---

### ✅ Exercise 02: Image Management

1. **Membuat Aplikasi & `Containerfile` (Non-root User & UBI9):**
   ```bash
   mkdir custom-app && cd custom-app
   echo 'print("Hello from Custom Image")' > app.py
   ```
   Isi `Containerfile`:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi:latest
   LABEL maintainer="student@example.com"

   RUN dnf install -y python3 && dnf clean all

   WORKDIR /app
   COPY app.py /app/

   USER 1001
   CMD ["python3", "app.py"]
   ```
2. **Build & Test Image:**
   ```bash
   podman build -t localhost:5000/my-custom-app:v1 .
   podman run --rm localhost:5000/my-custom-app:v1
   # Output: Hello from Custom Image
   ```
3. **Tagging & Pushing ke Insecure Local Registry:**
   ```bash
   podman tag localhost:5000/my-custom-app:v1 localhost:5000/my-custom-app:latest
   podman push --tls-verify=false localhost:5000/my-custom-app:v1
   podman push --tls-verify=false localhost:5000/my-custom-app:latest
   ```
4. **Inspeksi Registry dengan `skopeo`:**
   ```bash
   skopeo list-tags docker://localhost:5000/my-custom-app --tls-verify=false
   ```

---

### ✅ Exercise 03: Persistent Storage

1. **Bind Mount Web Server (dengan SELinux `:Z`):**
   ```bash
   podman run -d --name persistent-web -p 8080:80 \
     -v ~/ex188-data/html:/usr/share/nginx/html:Z \
     docker.io/library/nginx

   curl localhost:8080
   # Output: Welcome to EX188 Practice
   ```
2. **Modifikasi Data Real-time dari Host:**
   ```bash
   echo "Updated Content" > ~/ex188-data/html/index.html
   curl localhost:8080
   # Output: Updated Content
   ```
3. **Read-Only Mount (`:ro`):**
   ```bash
   podman stop persistent-web && podman rm persistent-web
   podman run -d --name persistent-web -p 8080:80 \
     -v ~/ex188-data/html:/usr/share/nginx/html:ro,Z \
     docker.io/library/nginx

   # Uji coba modifikasi dari dalam container (diharapkan gagal / Read-only file system)
   podman exec persistent-web sh -c 'echo "hack" > /usr/share/nginx/html/index.html'
   ```
4. **Named Volume Management:**
   ```bash
   podman volume create my-db-data
   podman run --name db-test -v my-db-data:/data registry.access.redhat.com/ubi9/ubi \
     sh -c 'echo "Data Aman" > /data/persist.txt'
   podman rm db-test

   # Verifikasi data tetap ada menggunakan container baru
   podman run --rm --name db-verify -v my-db-data:/data registry.access.redhat.com/ubi9/ubi \
     cat /data/persist.txt
   ```

---

## 🧠 Yang Saya Pahami

1. **Keamanan Container (`USER 1001` & `:ro`):** Menentukan user non-root pada `Containerfile` dan memasang mount read-only (`:ro`) mencegah modifikasi file statis/aplikasi jika container disusupi penyerang.
2. **SELinux Context (`:Z`):** Pada sistem RHEL/Rocky Linux yang menegakkan SELinux (*Enforcing*), bind mount direktori host wajib menyertakan opsi `:Z` (atau `:z`) agar container tidak terkena error *Permission Denied*.
3. **Alur Registry Lokal & `skopeo`:** Penggunaan `--tls-verify=false` dibutuhkan untuk registry lokal tanpa HTTPS, dan `skopeo` sangat berguna untuk menginspeksi isi repository/tag remote tanpa harus melakukan `podman pull`.
4. **Persistensi Data:** Data di dalam container bersifat *ephemeral* (hilang saat container dihapus), sedangkan named volume atau bind mount menjamin data tetap bertahan.

---

## 📌 Next

Melanjutkan ke latihan EX188 berikutnya:
- Container Networking & Podman Pods (`podman network`, `podman pod`, `generate kube`).
- Autostart Rootless Container menggunakan **Systemd** (`podman generate systemd` / Quadlet).
