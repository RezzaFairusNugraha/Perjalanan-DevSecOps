# Hands-On Lab 2 (v2): EX188 Advanced Prep — Containerfile, Multi-Target grep, vi/vim, User SubUIDs & Shared SGID

Selamat datang di **Lab 2 (Edisi Latihan Ulang / Reset)**!  
Skenario pada lab ini telah diperbarui agar lebih menantang dan semakin mendekati ujian **Red Hat EX188**.

Latihan ini menguji:
- Operasi berkas & direktori (`mkdir -p`, `cp`, `mv`, `rm`).
- Pemfilteran log multi-pola menggunakan `grep -E` (regex), `tail`, dan `head`.
- Penulisan **`Containerfile`** berbasis Python micro-service langsung menggunakan editor **`vi` / `vim`**.
- Manajemen user non-root (`useradd`, `groupadd`, `usermod`, `id`) dan verifikasi alokasi **SubUID / SubGID** (fondasi *Rootless Container* di RHEL/Podman).
- Izin khusus keamanan: **SGID** (`2770`) dan **Sticky Bit** (`1777`) dengan validasi file baru.

> 💡 **PENTING:** Seluruh setup, pengerjaan, dan penilaian lab ini membutuhkan hak akses root. Jalankan perintah atau masuk ke mode root dengan:
> ```bash
> sudo -i
> ```

---

## 🚀 Cara Memulai / Reset Lab

1. Jalankan script setup untuk me-reset lingkungan lab:
   ```bash
   sudo bash setup-lab.sh
   ```
2. Kerjakan **Task 1** sampai **Task 5** di bawah ini secara mandiri di terminal VM.
3. Jalankan penilaian otomatis kapan saja untuk memeriksa skor:
   ```bash
   sudo bash grade-lab.sh
   ```

---

## 📋 Daftar Tugas (Tasks)

### Task 1: Staging Storage & File Operations (`mkdir -p`, `mv`, `cp`, `rm`)
Siapkan struktur folder host yang akan digunakan untuk volume container:
1. Buat direktori:
   - `/opt/container-lab/app/data`
   - `/opt/container-lab/app/conf`
2. Pindahkan file konfigurasi `/tmp/staging-ex188/app.conf` ke `/opt/container-lab/app/conf/app.conf`.
3. Salin file template `/tmp/staging-ex188/default.env` menjadi `/opt/container-lab/app/conf/.env`.
4. Hapus folder temporary `/tmp/staging-ex188` beserta seluruh isinya yang sudah tidak diperlukan (`rm -rf`).

---

### Task 2: Log Extraction & Analysis (`cat`, `tail`, `grep`, `egrep`)
Sistem telah menghasilkan file log realistis di **`/opt/container-lab/logs/podman-service.log`**.
1. Cari baris yang berstatus **`CRITICAL`** atau **`FATAL`** (case-sensitive) menggunakan `grep -E` atau `egrep`, lalu simpan ke **`/opt/container-lab/logs/alerts.txt`**.
2. Cari semua baris yang mencatat IP internal container dengan format kata kunci **`REMOTE_ADDR=`**, lalu simpan ke **`/opt/container-lab/logs/connections.txt`**.
3. Ambil tepat **5 baris terakhir** dari `/opt/container-lab/logs/podman-service.log` menggunakan `tail -n 5`, lalu simpan ke **`/opt/container-lab/logs/recent.txt`**.

---

### Task 3: Bikin Custom `Containerfile` Pakai `vi` / `vim`
Latih kemampuan membuat berkas instruksi container tanpa mouse/GUI:
1. Buat dan buka berkas **`/opt/container-lab/Containerfile`** menggunakan perintah:
   ```bash
   vi /opt/container-lab/Containerfile
   ```
2. Tekan tombol `i` untuk masuk mode Insert, lalu ketik persis 6 baris berikut:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
   LABEL maintainer="student@ex188.lab"
   WORKDIR /app
   USER 1001
   EXPOSE 8080
   CMD ["python3", "-m", "http.server", "8080"]
   ```
3. Tekan `Esc`, lalu ketik `:wq` dan tekan `Enter` untuk menyimpan dan keluar.
4. Pastikan isinya benar dengan perintah:
   ```bash
   cat /opt/container-lab/Containerfile
   ```

---

### Task 4: Manajemen User & SubUID Rootless (`groupadd`, `useradd`, `id`)
Dalam ujian EX188, container dijalankan oleh user biasa non-root:
1. Buat grup baru bernama **`engineers`**.
2. Buat user baru bernama **`apprunner`** dengan:
   - UID spesifik **`1024`**
   - Grup tambahan (supplementary group) **`engineers`**
   *(Contoh command: `useradd -u 1024 -G engineers apprunner`)*.
3. Simpan ringkasan `id apprunner` ke berkas **`/opt/container-lab/logs/apprunner-info.txt`**.
4. Periksa apakah user `apprunner` otomatis memiliki range SubUID di sistem dengan menjalankan:
   ```bash
   grep apprunner /etc/subuid
   ```

---

### Task 5: Izin Khusus Keamanan — SGID & Sticky Bit (`chmod`, `chown`)
Konfigurasikan direktori berbagi tim agar file baru otomatis aman:
1. Buat dua direktori:
   - `/opt/container-lab/shared-workspace`
   - `/opt/container-lab/public-drop`
2. Ubah kepemilikan grup pada `/opt/container-lab/shared-workspace` menjadi grup **`engineers`** (`chown :engineers ...`).
3. Pasang izin **SGID** dengan nilai numerik **`2770`** pada `/opt/container-lab/shared-workspace` (agar setiap file baru yang dibuat di dalamnya otomatis memiliki kepemilikan grup `engineers`).
4. Pasang izin **Sticky Bit** dengan nilai numerik **`1777`** pada `/opt/container-lab/public-drop` (agar pengguna bebas membuat file tetapi tidak bisa menghapus file milik user lain).
5. Verifikasi izin menggunakan:
   ```bash
   ls -ld /opt/container-lab/shared-workspace /opt/container-lab/public-drop
   ```
   *(Pastikan ada flag `s` pada shared-workspace dan flag `t` pada public-drop!)*
