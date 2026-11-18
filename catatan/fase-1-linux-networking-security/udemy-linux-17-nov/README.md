# Catatan Belajar Linux di Udemy — 17 November 2026

## 🎯 Tujuan

Mendokumentasikan penyelesaian materi **Module 3 dan Module 4** pada kursus Linux Fundamentals di **Udemy** (video No. 44 s/d 68), mencakup:
- Sifat dan properti berkas/direktori di Linux serta perbedaan absolute vs relative path.
- Operasi pembuatan dan penyalinan berkas/direktori (`touch`, `mkdir`, `cp`, `vi`).
- Pencarian berkas lanjutan dengan `find`, `locate`, dan penggunaan *Wildcards* (`*`, `?`, `[]`, `^`).
- Konsep tipe berkas Linux dan link berkas: *Soft Link* (Symbolic Link) vs *Hard Link* (`ln`, `ln -s`).
- Hak akses berkas dan direktori tingkat lanjut: *Symbolic Mode* vs *Numeric Mode* (`chmod`), serta kepemilikan berkas (`chown`, `chgrp`).
- Manipulasi aliran data (*Streams*): Input/Output Redirection (`>`, `>>`, `<`, `stdin`, `stdout`, `stderr`), perintah `tee`, dan *Pipes* (`|`).
- Pemetaan materi Udemy terhadap silabus sertifikasi **Red Hat EX188 (Containers)** serta praktik langsung membangun dan menguji *Hands-On Lab* berbasis skrip *Auto-Grader* (`grade-lab.sh`).

---

## 📚 Rangkuman Materi yang Diselesaikan

### 1. Struktur Path & Navigasi Berkas
- **Absolute Path:** Path lengkap yang selalu diawali dari root `/` (contoh: `/var/log/nginx/access.log`).
- **Relative Path:** Path yang relatif terhadap direktori kerja saat ini (`./`, `../`, `catatan/`).
- **Pencarian dengan `find` vs `locate`:**
  - `find`: Memindai filesystem secara langsung dan real-time berdasarkan filter kustom (`-name`, `-type`, `-size`, `-perm`).
  - `locate`: Memindai database indeks (`mlocate.db` / `updatedb`) dengan kecepatan sangat tinggi.
- **Wildcards untuk Efisiensi Pencarian:**
  - `*`: Mencocokkan nol atau banyak karakter sembarang (`*.log`).
  - `?`: Mencocokkan tepat satu karakter sembarang (`file?.txt`).
  - `[]`: Mencocokkan salah satu karakter di dalam kurung siku (`file[1-3].conf`).

### 2. Tipe Berkas & Tautan Berkas (Links)
- **Tipe Berkas di Linux:**
  - `-`: Regular file (berkas biasa).
  - `d`: Directory.
  - `l`: Symbolic / Soft link.
  - `c` / `b`: Character / Block device (pada `/dev`).
  - `s`: Socket (komunikasi antar proses).
- **Hard Link vs Soft Link (`ln`):**
  - **Soft Link (Symbolic Link / `ln -s sumber target`):** Bekerja seperti shortcut di Windows yang merujuk ke path berkas asli. Jika berkas asli dihapus, link akan rusak (*broken link*). Dapat melintasi partisi/filesystem yang berbeda.
  - **Hard Link (`ln sumber target`):** Berbagi nomor inode yang sama persis dengan berkas asli. Jika berkas asli dihapus, data masih tetap bisa diakses melalui hard link selama masih ada link yang menunjuk ke inode tersebut.

### 3. Hak Akses (Permissions) & Kepemilikan (Ownership)
Fondasi utama dalam arsitektur keamanan server dan container:
- **Format Izin Berkas:** `rwx` (Read = 4, Write = 2, Execute = 1).
- **Representasi Numerik (`chmod`):**
  - `chmod 755 file`: User (7 = rwx), Group (5 = r-x), Others (5 = r-x) — standar untuk direktori atau executable.
  - `chmod 644 file`: User (6 = rw-), Group (4 = r--), Others (4 = r--) — standar untuk berkas konfigurasi biasa.
  - `chmod 600 file`: Akses privat hanya untuk user pemilik — standar wajib untuk private key SSH (`id_rsa`).
- **Kepemilikan Berkas (`chown` & `chgrp`):**
  - Mengubah pemilik dan grup sekaligus: `chown user:group nama_berkas`.
  - Mengubah secara rekursif ke seluruh subfolder: `chown -R user:group /path/direktori`.

### 4. Input/Output Redirection, `tee`, & Pipes (Video 65–68)
- **Standard Streams di Linux:**
  - `stdin` (0): Standard Input (keyboard / berkas input via `<`).
  - `stdout` (1): Standard Output (hasil normal perintah).
  - `stderr` (2): Standard Error (pesan error).
- **Redirection Operators:**
  - `>`: Menulis output ke berkas baru atau **menimpa (*overwrite*)** isi berkas yang sudah ada.
  - `>>`: Menambahkan (*append*) output ke baris paling akhir berkas tanpa menghapus isi sebelumnya.
- **Perintah `tee`:**
  - Menampilkan output langsung ke layar terminal **sekaligus** menyimpannya ke dalam berkas log (contoh: `uname -a | tee logs/system_info.log`).
- **Pipes (`|`):**
  - Menghubungkan *stdout* dari perintah pertama menjadi *stdin* bagi perintah berikutnya untuk pemrosesan berantai (contoh: `cat logs/system_info.log | wc -w`).

---

## 💻 Lab, Proyek & Troubleshooting yang Diselesaikan

- [x] **Lab 54:** *Organize Project Files into Directories* (Strukturisasi direktori kerja).
- [x] **Lab 55:** *Organize Office Records with Wildcards and Links* (Implementasi soft link & pengelompokan berkas via wildcard).
- [x] **Tugas 3:** *Module 3 Project: Build a Linux File Workspace* (Simulasi penyiapan workspace berkas sistem).
- [x] **Kuis 3:** Berhasil menyelesaikan kuis evaluasi Module 3.
- [x] **Video 57–60 & 65–68:** Penguasaan sintaks command, `chmod` (symbolic & numeric), *Redirections* (`>`, `>>`), `tee`, dan *Pipes* (`|`).
- [x] **Custom Hands-On Lab (`lab/fase-1-linux-networking-security`):**
  - Membangun skrip *setup* (`setup-lab.sh`), instruksi berbahasa Inggris (`README.md`), dan *Auto-Grader* (`grade-lab.sh`) bergaya ujian Red Hat untuk workspace `~/app-deploy`, lalu mem-push ke repositori GitHub.
  - Mempraktikkan Task 1–5 di VM AlmaLinux: struktur direktori, pembuatan skrip `deploy.sh`, permission `755` & `600`, wildcard `[12]`, serta perbandingan *Hard Link* vs *Symbolic Link*.
  - **Catatan Troubleshooting Lab:**
    - Kesalahan lokasi direktori saat menjalankan `cp -r` dari working directory yang berbeda menyebabkan `configs-backup` tidak berada di dalam `~/app-deploy/configs-backup`.
    - Memahami langsung perbedaan fundamental inode saat *grading*: *Hard Link* (`hard_master.conf`) wajib memiliki inode yang sama dengan `master.conf.bak`, sedangkan *Symbolic Link* (`quick_access.conf`) wajib dibuat dengan `ln -s` sehingga memiliki inode berbeda dan bertipe `l` (*symlink*).
    - Ketelitian ejaan nama berkas (*case-sensitive* & *typo* seperti `quick_acces.conf` vs `quick_access.conf`) sangat krusial di lingkungan CLI Linux dan ujian praktik Red Hat.

---

## 🧠 Hubungan dengan Ujian Red Hat EX188 & DevSecOps

1. **Strategi Efisiensi Kurikulum EX188:** Memetakan ulang kurikulum Udemy agar fokus pada materi relevan untuk **EX188 (Containers/Podman)** seperti dasar CLI, redirection, `grep`, `vi/vim`, `systemctl`, *Environment Variables*, `curl`, dan Podman (Video 191), serta melewatkan materi legacy sysadmin yang tidak diujikan (LVM, RAID, Samba, Squid, Nagios).
2. **Pembuatan Containerfile:** Perintah `chmod` dan `chown` sering disisipkan ke dalam instruksi `RUN` pada `Containerfile` untuk memastikan file aplikasi di dalam container dapat dibaca oleh user non-root (`USER 1001`).
3. **Bind Mounts & Host Security:** Memahami perizinan numerik mencegah terjadinya issue *Permission Denied* saat menghubungkan direktori host ke dalam container Podman.
4. **Symbolic Links di Container:** Banyak binary dan konfigurasi di dalam image container enterprise (RHEL/UBI 9) yang menggunakan symlink (seperti `/bin -> /usr/bin`).

---

## 📌 Next

- Menyelesaikan pengecekan penuh (`5 / 5 PASS`) pada `grade-lab.sh` di VM AlmaLinux.
- Mempelajari text processing dasar (`cat`, `head`, `tail`, `grep`), text editor `vi`/`vim` (Video 88–89), `systemctl` (Video 102), dan *Environment Variables* (Video 123).
- Mulai masuk fokus inti **Podman & Containerfile** (Video 191 + latihan mandiri EX188).
