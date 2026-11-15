# Catatan Belajar Linux — 15 November 2026

## 🎯 Tujuan

Melanjutkan pendalaman administrasi sistem operasi Linux pada Fase 1 (Linux, Networking, & Security Hardening), memperkuat keterampilan command-line, pengelolaan sistem, serta menghubungkannya dengan kebutuhan otomatisasi dan keamanan container (Podman & DevSecOps).

Target pembelajaran sesi ini:
- Mereview dan mempraktikkan navigasi direktori serta manipulasi berkas tingkat lanjut.
- Memperdalam konsep manajemen hak akses (*Permissions & Ownership*: `chmod`, `chown`, user, group).
- Mempelajari pemantauan proses dan status service (*Process & Systemd*: `ps`, `top`, `systemctl`).
- Memahami analisis log sistem dan inspeksi berkas konfigurasi (`tail -f /var/log/...`, `grep`, redirection).
- Menjaga konsistensi belajar mandiri untuk memperkuat fondasi sebelum masuk ke materi Networking & SSH Hardening.

---

## 📚 Ringkasan Materi yang Dipelajari & Dilatih

### 1. Navigasi & Manipulasi File Cepat
Operasi terminal yang terus dilatih agar menjadi refleks:
- `ls -lah`: Memeriksa detail permission, ownership, hidden files, dan ukuran berkas secara human-readable.
- `mkdir -p` & `cp -r`: Membuat hierarki direktori bertingkat dan menyalin folder secara rekursif.
- `find /path -type f -name "*.conf" 2>/dev/null`: Mencari berkas konfigurasi tertentu dan membuang pesan error izin akses.

### 2. Hak Akses & Keamanan Berkas (Permissions & Ownership)
Pondasi penting untuk mencegah celah keamanan server dan container:
- Format izin `rwxrwxrwx` (User, Group, Others) dengan representasi numerik:
  - `chmod 755`: User punya akses penuh, group dan others hanya bisa baca & eksekusi.
  - `chmod 600`: Akses hanya untuk pemilik (standar untuk private key SSH `id_rsa` atau file rahasia).
  - `chmod 644`: Berkas konfigurasi standar yang aman dibaca publik namun hanya root/pemilik yang bisa mengubah.
- Mengubah kepemilikan: `chown user:group nama_berkas`.

### 3. Pemantauan Proses & Service (`systemd`)
- **Proses:** Memeriksa penggunaan CPU dan memori menggunakan `ps aux | grep <nama_service>` dan `top`.
- **Service Management (`systemctl`):**
  - `systemctl status <service>`: Cek status apakah *active (running)* atau *failed*.
  - `systemctl start / stop / restart <service>`: Mengontrol siklus hidup service.
  - `systemctl enable --now <service>`: Mengaktifkan service agar otomatis berjalan saat booting.

### 4. Inspeksi Log & Troubleshooting
- `tail -f /var/log/messages` atau `journalctl -u <service> -f`: Membaca log sistem secara real-time saat terjadi kendala.
- Mengombinasikan `grep` dan filter output untuk mempercepat pencarian pesan error (`journalctl -xe | grep -i error`).

---

## 🧠 Yang Saya Pahami & Hubungannya dengan DevSecOps

1. **Linux adalah Tulang Punggung DevOps & Security:** Setiap container Podman/Docker, node Kubernetes, dan instance cloud (AWS EC2) berjalan di atas Linux. Menguasai Linux di level terminal membuat konfigurasi container dan debugging error menjadi jauh lebih mudah.
2. **Prinsip Least Privilege Dimulai dari Permission:** Pengaturan izin berkas (`chmod 600` / `644`) dan penentuan non-root user adalah langkah pertama pengamanan sistem (*security hardening*) sebelum masuk ke firewall dan konfigurasi Nginx.

---

## 📌 Next

- Melanjutkan ke topik berikutnya di Fase 1: **Networking Fundamentals & Troubleshooting** (`ip a`, `netstat`/`ss`, ping, DNS, dan TCP/IP).
- Mempraktikkan konfigurasi **SSH & SSH Hardening** (login via SSH key, disable root login, port forwarding).
