# Catatan Belajar Linux di Udemy — 18 November 2026: User Management & Special Permissions (s/d No. 97)

## 🎯 Tujuan

Mendokumentasikan penyelesaian materi **Module 4 dan Module 5** pada kursus Linux Fundamentals di **Udemy** hingga video **No. 97 (Special Permissions with setuid, setgid and sticky bit)**, mencakup:
- Pemeliharaan berkas & display: `cp`, `rm`, `mv`, `mkdir`, `cat`, `head`, `tail`, `grep`.
- Editor teks terminal standar industri: `vi` & `vim` (mode perintah, insert, visual, simpan/keluar).
- Manajemen akun pengguna & grup: `useradd`, `usermod`, `userdel`, `groupadd`, `groupdel`.
- Akses administratif & pergantian user: `su`, `sudo`, file `/etc/sudoers`, dan group `wheel`/`sudo`.
- Monitoring user aktif: `id`, `who`, `w`, `last`.
- Izin khusus tingkat lanjut (**Special Permissions**):
  - **SUID (Set User ID)**: Eksekusi biner dengan hak pemilik biner.
  - **SGID (Set Group ID)**: Pewarisan grup otomatis pada direktori bersama tim (*shared workspace*).
  - **Sticky Bit**: Proteksi penghapusan berkas pada direktori publik/bersama (hanya pemilik berkas yang bisa menghapus).

---

## 📚 Rangkuman Materi Kunci (Video 69 s/d 97)

### 1. Editor Teks Terminal (`vi` / `vim`)
Skill wajib tanpa mouse/GUI untuk mengonfigurasi server dan membuat `Containerfile`:
- `vi <nama_file>`: Membuka file dalam *Command Mode*.
- Tekan `i`: Masuk ke *Insert Mode* (mengetik teks).
- Tekan `Esc`: Kembali ke *Command Mode*.
- `:w` (Simpan), `:q` (Keluar), `:wq` atau `:x` (Simpan & keluar), `:q!` (Keluar tanpa menyimpan).
- `dd` (Hapus/cut 1 baris), `yy` (Copy 1 baris), `p` (Paste di bawah kursor).

### 2. User & Group Management (Prinsip Non-Root Container)
Di Linux dan lingkungan container enterprise (Red Hat EX188):
- **User Management:**
  ```bash
  # Membuat user baru dengan UID spesifik dan grup tambahan
  useradd -u 1024 -G engineers apprunner

  # Mengubah user (misal menambah grup baru tanpa menghapus grup lama: flag -aG)
  usermod -aG devteam apprunner

  # Menghapus user beserta home directory-nya
  userdel -r username_lama
  ```
- **Primary Group vs Supplementary Group:**
  - *Primary Group (`-g`)*: Ditugaskan otomatis sebagai pemilik default setiap file baru yang dibuat user tersebut.
  - *Supplementary Group (`-G`)*: Grup tambahan yang memungkinkan user berkolaborasi dan mengakses file/folder tim lain (seperti grup `engineers`).
- **Inspeksi Identitas:**
  ```bash
  id apprunner
  # Output: uid=1024(apprunner) gid=1024(apprunner) groups=1024(apprunner),1002(engineers)
  ```

### 3. Hak Akses Khusus (Special Permissions: SUID, SGID, Sticky Bit)
Format permission 4 digit numerik: `chmod [Special][User][Group][Other]`

#### A. SUID (Set User ID) — Nilai Oktal: `4`
- **Konsep:** Saat file biner dieksekusi oleh user biasa, proses tersebut akan berjalan dengan hak akses **pemilik file** (biasanya root).
- **Contoh Nyata:** Program `/usr/bin/passwd` memiliki bit SUID (`-rwsr-xr-x`). User biasa bisa mengubah password mereka sendiri karena biner `passwd` sementara waktu bertindak sebagai root untuk mengubah berkas sensitif `/etc/shadow`.
- **Perintah:** `chmod 4755 <biner>` atau `chmod u+s <biner>`.

#### B. SGID (Set Group ID) — Nilai Oktal: `2` (Sangat Penting untuk Tim & Container!)
- **Pada File Biner:** Menjalankan file dengan hak akses grup pemilik file.
- **Pada Direktori (Shared Workspace):** Setiap file baru yang dibuat di dalam direktori tersebut **secara otomatis mewarisi kepemilikan grup direktori**, bukan grup primer dari user yang membuatnya!
- **Contoh Nyata:** Folder `/opt/container-lab/shared-workspace` yang dimiliki grup `engineers`.
- **Perintah:**
  ```bash
  chown :engineers /opt/container-lab/shared-workspace
  chmod 2770 /opt/container-lab/shared-workspace
  # Izin terlihat: drwxrws--- (ada huruf 's' pada bagian group)
  ```

#### C. Sticky Bit — Nilai Oktal: `1`
- **Konsep:** Diterapkan pada direktori publik di mana semua user memiliki izin tulis (`write`). **Hanya pemilik file atau root yang diizinkan menghapus file tersebut**, mencegah user iseng menghapus pekerjaan user lain.
- **Contoh Nyata:** Direktori `/tmp` di Linux memiliki Sticky Bit (`drwxrwxrwt`).
- **Perintah:**
  ```bash
  chmod 1777 /opt/container-lab/public-drop
  # Izin terlihat: drwxrwxrwt (ada huruf 't' pada bagian others)
  ```

---

## 🧠 Hubungan Langsung dengan Ujian Red Hat EX188 & DevSecOps

1. **Non-Root Container Execution:**
   - Memahami alokasi UID user biasa (seperti UID `1024` atau `1001` pada `Containerfile`) mencegah container berjalan sebagai `root` host.
2. **Kolaborasi Volume & SGID:**
   - Direktori host yang dimount ke container sering diatur dengan SGID (`2770`) agar file log/output yang ditulis oleh container (`apprunner`) bisa langsung dibaca dan diedit oleh developer tim (`engineers`) tanpa error *Permission Denied*.
3. **Audit Keamanan SUID:**
   - Dalam DevSecOps hardening, auditor keamanan selalu memindai biner SUID yang tidak perlu (`find / -perm -4000`) karena biner SUID yang rentan (*vulnerable*) adalah celah utama eskalasi hak akses (*Privilege Escalation*).

---

## 📌 Status Belajar di Udemy

- [x] Video 1 s/d 68: Fundamental Navigasi, Izin Dasar, Redirect (`>`, `>>`, `tee`), Pipes (`|`).
- [x] Video 69 s/d 87: Maintenance Files, Display (`cat`, `tail`), Text Filter (`grep`), Editor `vi`/`vim`.
- [x] Video 88 s/d 97: User Management (`useradd`, `usermod`, `id`), SUID, **SGID (`2770`)**, dan **Sticky Bit (`1777`)**.
- [ ] Next: Module 5 lanjutan — Manajemen Proses (`ps`, `top`, `kill`), Service (`systemctl`), dan Log Analysis (`journalctl`).
