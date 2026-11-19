# Catatan Belajar Linux di Udemy — 19 November 2026: Systemd, Processes, Signals, Logs (`journalctl`) & Environment Variables (s/d No. 123)

## 🎯 Tujuan

Mendokumentasikan penyelesaian materi **Module 5** pada kursus Linux Fundamentals di **Udemy** (video No. 102, 103–106, 111–113, dan 123) yang sangat krusial untuk ujian **Red Hat EX188 (Containers)** dan operasional **DevSecOps**:
- **`systemctl` (No. 102):** Manajemen lifecycle service (`start`, `stop`, `restart`, `enable --now`, `status`, `daemon-reload`).
- **`ps` & `top` (No. 103–104):** Inspeksi proses yang berjalan di background dan monitoring CPU/RAM proses container.
- **`kill` & Process Signals (No. 105–106):** Perbedaan sinyal terminasi halus (`SIGTERM` / `15`) dan penghentian paksa (`SIGKILL` / `9`).
- **System Monitoring (No. 111):** Pemeriksaan kapasitas disk (`df -h`) dan memori (`free -h` / `free -m`).
- **System Logs & `journalctl` (No. 112–113):** Analisis log di `/var/log` dan troubleshooting service systemd menggunakan `journalctl -u` / `journalctl --user -xe`.
- **Environment Variables (No. 123):** Variabel lokal vs environment (`export`), file konfigurasi `/etc/profile.d/`, serta `EnvironmentFile` untuk service/container.

---

## 📚 Rangkuman Materi Kunci

### 1. Manajemen Service dengan `systemctl`
Di RHEL / Rocky Linux 9, `systemd` adalah sistem inisialisasi utama yang mengelola seluruh daemon dan container autostart:
```bash
# Reload konfigurasi unit baru/diubah
systemctl daemon-reload

# Menjalankan sekaligus mengaktifkan service saat boot
systemctl enable --now nama-service.service

# Mengecek status apakah active (running)
systemctl status nama-service.service

# Untuk Rootless Container (EX188 User Service):
systemctl --user daemon-reload
systemctl --user enable --now container-web.service
loginctl enable-linger $USER
```

### 2. Proses & Sinyal (`ps`, `top`, `kill`)
- **`ps aux | grep <nama>`:** Melihat daftar seluruh proses yang berjalan beserta **PID (Process ID)**, pemilik user, pemakaian CPU/MEM, dan command.
- **`top`:** Monitoring proses secara *real-time* interaktif.
- **Process Signals (`kill`):**
  - **`SIGTERM` (`15` — Default):** Meminta proses berhenti secara rapi (*graceful shutdown*, menyimpan state dan menutup koneksi). Saat kita menjalankan `podman stop`, Podman mengirim `SIGTERM` terlebih dahulu.
  - **`SIGKILL` (`9` — Force Kill):** Mematikan proses secara paksa di level kernel (`kill -9 <PID>`) jika proses macet (*hang*) atau mengabaikan `SIGTERM`.
  - **`SIGHUP` (`1`):** Meminta proses me-reload konfigurasi tanpa mati.

### 3. System Monitoring (`df` & `free`)
```bash
# Mengecek sisa ruang penyimpanan disk per partisi secara human-readable
df -h

# Mengecek penggunaan RAM dan Swap (dalam MB atau Human-readable)
free -m
free -h
```

### 4. System Logs (`/var/log`) & `journalctl`
Ketika service atau container systemd gagal berjalan, langkah pertama troubleshooting adalah membaca log:
```bash
# Membaca log khusus untuk satu unit service tertentu
journalctl -u nama-service.service

# Membaca log terbaru secara live (follow)
journalctl -u nama-service.service -f

# Membaca log disertai penjelasan error terakhir
journalctl -xe

# Untuk service rootless container (level user biasa di EX188):
journalctl --user -u container-web.service --no-pager
```

### 5. Environment Variables (`export` & `EnvironmentFile`)
- Menampilkan semua environment variables: `env` atau `printenv`.
- Membuat variabel berlaku untuk child process: `export APP_PORT=9090`.
- Menyimpan secara permanen untuk user: `~/.bashrc` atau `~/.bash_profile` (atau global di `/etc/profile.d/*.sh`).
- Menggunakan environment variable di Podman (`podman run -e VAR=val` atau `--env-file`).

---

## 🧪 Hands-On Lab 3

Untuk mempraktikkan keenam materi di atas secara langsung, telah dibuat **Lab 3** lengkap dengan `setup-lab.sh` dan `grade-lab.sh`:
- Lokasi Lab: [`lab/fase-1-linux-networking-security/lab-3-systemd-processes-logs-env/`](../../../lab/fase-1-linux-networking-security/lab-3-systemd-processes-logs-env/README.md)

---

## 📌 Next (Bagian 4 — Jaringan, Port & Firewall)

Melanjutkan materi wajib berikutnya di Udemy (Module 7):
- No. 153–155: **SSH & SSH-Keys**
- No. 156–157: **`ss` command & `curl`** (cek port & koneksi container)
- No. 164: **`rpm` & `yum`/`dnf`** (package management)
- No. 187: **Firewall (`firewalld`)**
