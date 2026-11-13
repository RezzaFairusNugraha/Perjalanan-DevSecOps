# Belajar Linux Fundamentals di Udemy

## 🎯 Tujuan

Memperkuat fondasi administrasi sistem operasi Linux melalui kursus video komprehensif di **Udemy** sebagai pelengkap hands-on lab di TryHackMe, Hack The Box Academy, dan VM Rocky Linux 9.

Target pembelajaran:
- Memahami konsep arsitektur kernel Linux, shell, dan sistem file hierarki (FHS).
- Menguasai perintah navigasi, manajemen berkas/direktori, serta manipulasi teks.
- Menguasai konsep hak akses (*file permissions & ownership*), user management, dan grup.
- Memahami pengelolaan proses, service (*systemd*), serta monitoring resource server.
- Menerapkan materi ke dalam skenario nyata administrasi server DevOps & DevSecOps.

---

## 📚 Modul & Topik yang Dipelajari

### 1. Fondasi Sistem Operasi & Arsitektur Linux
- **Kernel vs Shell:** Peran kernel sebagai jembatan hardware-software dan shell (Bash) sebagai penerjemah perintah pengguna.
- **Filesystem Hierarchy Standard (FHS):** Struktur direktori Linux (`/`, `/etc` untuk konfigurasi, `/var/log` untuk berkas dinamis/logs, `/home` untuk direktori user, `/bin` & `/usr/bin` untuk file executable/biner).

### 2. Navigasi & Operasi File Tingkat Lanjut
- Navigasi dan manipulasi: `ls -lah`, `cd`, `pwd`, `mkdir -p`, `cp -r`, `mv`, `rm -rf`.
- Analisis dan filter teks:
  - `cat`, `less`, `head`, `tail -f` (sangat krusial untuk pemantauan log server secara real-time).
  - Menggabungkan pipeline `|` dengan `grep`, `awk`, dan `sort`.
- Redirection: Standard Input (`0`), Standard Output (`1` / `>`), dan Standard Error (`2` / `2> /dev/null`).

### 3. Hak Akses & User Management
- Format izin berkas (*Read, Write, Execute*): `rwx` (nilai oktal: `4`, `2`, `1`).
- Mengubah izin dan kepemilikan: `chmod` dan `chown`.
- Konsep user privileges: `sudo`, berkas `/etc/sudoers`, dan group admin (`wheel` di RHEL/Rocky atau `sudo` di Debian/Ubuntu).

### 4. Manajemen Proses & Monitoring Sistem
- Melihat proses berjalan: `ps aux`, `top`, `htop`.
- Mengontrol proses: `kill`, `killall`, background/foreground (`&`, `Ctrl+Z`, `bg`, `fg`).
- Monitoring resource sistem:
  - RAM: `free -h`
  - Disk Space & Usage: `df -h`, `du -sh`
  - Beban sistem (*Load Average*): `uptime`

---

## 🧠 Yang Saya Pahami & Hubungannya dengan DevSecOps

1. **Pemahaman Teori yang Lebih Terstruktur:** Belajar via kursus video di Udemy memberikan visualisasi konsep (seperti alur proses kernel, perizinan bit SUID/SGID, dan pipeline I/O) yang melengkapi latihan command-line praktis di lab HTB dan TryHackMe.
2. **Kesiapan Ujian Sertifikasi (EX188):** Seluruh konsep izin berkas, user non-root, dan inspeksi sistem di Linux langsung terpakai saat membangun container aman menggunakan Podman.

---

## 📌 Next

- Melanjutkan modul administrasi jaringan dasar (networking commands: `ip`, `netstat`/`ss`, `ping`, `curl`) di kursus Udemy.
- Mengombinasikan materi dengan konfigurasi SSH Key & hardening di VM Rocky Linux 9.
