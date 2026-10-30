# Hack The Box Academy — Linux Fundamentals

## 🎯 Tujuan

Mempelajari dan mendalami pengoperasian sistem operasi Linux melalui modul **Linux Fundamentals** di **Hack The Box (HTB) Academy** sebagai pondasi teknis di Fase 1 (Linux, Networking, & Security Hardening).

Progress saat ini: **38% (In Progress)**.

Target pembelajaran pada modul ini:
- Memahami struktur hirarki sistem file Linux (FHS - Filesystem Hierarchy Standard).
- Menguasai navigasi direktori dan manipulasi file/direktori (`ls`, `cd`, `pwd`, `cp`, `mv`, `rm`, `mkdir`, `touch`).
- Menguasai teknik pencarian file dan direktori secara efisien (`which`, `find`, `locate`).
- Memahami perbedaan performa dan cara kerja antara pencarian langsung via filesystem (`find`) dan database indeks (`locate`).
- Menyelesaikan seluruh soal dan target tantangan lab interaktif di HTB Academy.

---

## 📚 Yang Dipelajari

### 1. Navigasi & Eksplorasi Direktori (`ls`, `cd`, `pwd`)
- **`pwd` (Print Working Directory):** Menampilkan path absolut direktori saat ini.
- **`ls` (List):** Menampilkan isi direktori dengan berbagai parameter penting:
  - `ls -l`: Format panjang (*long listing*), menampilkan permission, jumlah hard link, owner, group, ukuran file, dan waktu modifikasi.
  - `ls -a`: Menampilkan seluruh file termasuk hidden file (dimulai dengan titik `.`).
  - `ls -la` / `ls -lah`: Kombinasi lengkap dengan format ukuran file yang mudah dibaca manusia (*human-readable*, misal: KB, MB).
  - `ls -t`: Mengurutkan berdasarkan waktu modifikasi terbaru.
  - `ls -R`: Menampilkan isi direktori secara rekursif.

### 2. Manipulasi File & Direktori (`cp`, `mv`, `touch`, `mkdir`, `rm`)
- **`touch <nama_file>`:** Membuat file kosong baru atau memperbarui timestamp file.
- **`mkdir <nama_dir>`:** Membuat direktori baru. Menggunakan flag `-p` untuk membuat struktur direktori bertingkat sekaligus (`mkdir -p folder/subfolder/data`).
- **`cp` (Copy):** Menyalin file atau direktori.
  - `cp sumber.txt tujuan.txt`: Menyalin file.
  - `cp -r folder_sumber/ folder_tujuan/`: Menyalin direktori secara rekursif beserta seluruh isinya.
  - `cp -v`: Verbose mode (menampilkan proses penyalinan ke layar).
- **`mv` (Move):** Memindahkan file/direktori atau mengganti nama file (*rename*).
- **`rm` (Remove):** Menghapus file atau direktori.
  - `rm -r <folder>`: Menghapus folder dan seluruh isinya secara rekursif.

### 3. Pencarian File & Direktori (`which`, `find`, `locate`)
Mencari file konfigurasi, binary eksekusi, log, atau artefak sistem sangat sering dilakukan di administrasi server maupun penetration testing:

- **`which`:** Mencari lokasi binary/program executable yang ada di dalam variabel environment `$PATH`.
  ```bash
  which bash
  which python3
  ```
- **`find` (Pencarian Real-Time di Filesystem):**
  Mencari file langsung dengan memindai struktur disk. Sangat fleksibel dan kuat karena mendukung filter berdasarkan nama, tipe, ukuran, permission, dan waktu modifikasi:
  ```bash
  # Mencari file berdasarkan nama di seluruh filesystem
  find / -type f -name "config.php" 2>/dev/null

  # Mencari direktori dengan nama tertentu
  find . -type d -name "backup"

  # Mencari file berdasarkan ekstensi
  find /var/log -type f -name "*.log"

  # Mencari file berdasarkan permission (misal file SUID untuk privilege escalation)
  find / -perm -4000 -type f 2>/dev/null
  ```
  *(Catatan: `2>/dev/null` digunakan untuk membuang pesan error `Permission denied` agar output bersih).*

- **`locate` (Pencarian Cepat Berbasis Database Indeks):**
  Mencari file jauh lebih cepat daripada `find` karena mencari di dalam database lokal (`mlocate.db` / `plocate.db`), bukan memindai disk secara langsung.
  ```bash
  locate id_rsa
  locate nginx.conf
  ```
  - **Penting:** Jika ada file yang baru saja dibuat, file tersebut belum tercatat di database `locate`. Database harus diperbarui terlebih dahulu menggunakan:
    ```bash
    sudo updatedb
    ```

---

## 💻 Praktik di HTB Academy

### Status Modul: **38% Selesai**
- [x] Basic Navigation (`cd`, `pwd`, `ls -la`)
- [x] Working with Files and Directories (`touch`, `mkdir`, `cp`, `mv`, `rm`)
- [x] Finding Files and Directories (`which`, `find`, `locate`, `updatedb`)
- [ ] File Descriptors, Redirection & Piping (`>`, `>>`, `|`, `tee`)
- [ ] Filtering Contents (`cat`, `head`, `tail`, `grep`, `sed`, `awk`)
- [ ] User Management & Permissions (`chmod`, `chown`, user/group)
- [ ] Service & Process Management (`ps`, `top`, `systemctl`)
- [ ] Package Management & System Information
- [ ] Module Skills Assessment (Tantangan Akhir)

---

## 🧾 Perintah Penting Hari Ini

```bash
# Eksplorasi direktori detail & hidden files
ls -lah

# Menyalin direktori secara rekursif
cp -r /path/sumber /path/tujuan

# Mencari file tertentu dan membuang error permission denied
find / -name "*secret*" -type f 2>/dev/null

# Memperbarui database pencarian locate lalu mencari file
sudo updatedb
locate id_rsa
```

---

## 🧠 Yang Saya Pahami

1. **Perbedaan `find` vs `locate`:**
   - Gunakan `locate` saat butuh pencarian instan untuk file-file sistem yang relatif permanen.
   - Gunakan `find` saat mencari file yang baru dibuat, atau saat butuh filter spesifik (ukuran file, owner, permission, modifikasi waktu).
2. **Keterkaitan dengan DevSecOps & Server Hardening:**
   - Perintah `find` sangat krusial dalam auditing server Linux. Misalnya untuk mencari file konfigurasi yang tidak aman, file yang permission-nya terlalu terbuka (`chmod 777`), atau file dengan bit SUID aktif yang bisa dimanfaatkan attacker.
3. **Pengalaman Belajar di HTB Academy:**
   - Lab interaktif di HTB Academy memberikan pemahaman langsung karena setiap teori langsung diuji melalui challenge command-line di target VM.

---

## 📌 Next

Melanjutkan sisa materi **Linux Fundamentals (HTB Academy)** dari 38% ke 100%:
1. Mempelajari File Descriptors, I/O Redirection (`<`, `>`, `>>`), dan Piping (`|`).
2. Mempelajari Text Filtering (`grep`, `cut`, `awk`, `sed`).
3. Mempelajari Manajemen User, Group, dan Hak Akses (`chmod`, `chown`).
4. Menyelesaikan Skills Assessment akhir modul.
