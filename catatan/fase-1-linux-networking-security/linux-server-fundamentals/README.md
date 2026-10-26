# Linux Server Fundamentals

## 🎯 Tujuan

Memahami dasar-dasar Linux Server sebagai fondasi untuk mempelajari DevOps, Cloud, dan DevSecOps.

Pada tahap awal ini saya menyiapkan environment Linux Server menggunakan virtual machine agar proses belajar dan praktik dapat dilakukan secara terisolasi dari sistem utama.

Target pembelajaran:

- Memahami struktur dasar Linux Server.
- Memahami filesystem Linux.
- Memahami user dan group.
- Memahami permission dan ownership.
- Memahami process dan service.
- Memahami package management.
- Memahami penggunaan terminal.
- Memahami cara membaca informasi sistem.
- Memahami dasar troubleshooting Linux.

---

## 📚 Yang Dipelajari

### 1. Linux Server

Linux Server adalah sistem operasi Linux yang digunakan untuk menjalankan service, aplikasi, database, web server, dan berbagai workload lainnya.

Pada pembelajaran DevOps, Linux menjadi salah satu fondasi penting karena banyak server dan infrastructure menggunakan Linux.

Untuk memulai pembelajaran, saya menyiapkan dua environment:

- **Ubuntu Server**
- **RHEL / RHEL-based environment**

Ubuntu akan digunakan sebagai environment utama untuk mengikuti pembelajaran, sedangkan environment RHEL digunakan untuk mengenal ekosistem Red Hat.

### 2. Virtual Machine

Saya menggunakan Virtual Machine (VM) agar dapat menjalankan Linux Server tanpa mengganti sistem operasi utama.

Konsep environment yang digunakan:

```text
Laptop
  │
  └── Virtual Machine
        │
        ├── Ubuntu Server
        │
        └── RHEL / RHEL-based
```

Dengan VM, saya dapat melakukan eksperimen terhadap Linux Server tanpa langsung mengubah konfigurasi sistem utama.

### 3. Ubuntu Server

Ubuntu Server digunakan sebagai environment utama untuk mempelajari Linux Fundamentals.

Materi yang akan dipelajari meliputi:

- Filesystem
- User & Group
- Permission
- Process
- Service
- Package Management
- Networking
- SSH
- System Monitoring
- Troubleshooting

### 4. RHEL

RHEL digunakan untuk mengenal sistem Linux berbasis Red Hat.

Hal yang nantinya akan dibandingkan dengan Ubuntu:

```text
Ubuntu / Debian
        ↕
RHEL ecosystem
```

Beberapa perbedaan yang akan dipelajari:

- Package management
- Service management
- Firewall
- Struktur konfigurasi
- Administrative workflow

---

## 💻 Praktik

### Status Saat Ini

**Environment masih dalam tahap persiapan.**

Saat ini saya sedang:

- [x] Menentukan Ubuntu Server sebagai Linux Server utama.
- [x] Menentukan RHEL sebagai environment tambahan.
- [ ] Download Ubuntu Server.
- [ ] Download RHEL / RHEL-based environment.
- [ ] Membuat VM Ubuntu.
- [ ] Membuat VM RHEL.
- [ ] Menyelesaikan instalasi.
- [ ] Melakukan login pertama.
- [ ] Mengecek informasi sistem.
- [ ] Mempelajari filesystem.
- [ ] Mempelajari user dan group.
- [ ] Mempelajari permission.
- [ ] Mempelajari process.
- [ ] Mempelajari service.
- [ ] Mempelajari package management.
- [ ] Melakukan basic troubleshooting.

---

## 🧾 Perintah Penting

Bagian ini akan diisi setelah environment Linux selesai dibuat dan command sudah dipraktikkan.

Beberapa command yang akan dipelajari:

```bash
pwd
ls
cd
mkdir
touch
cp
mv
rm
cat
less
grep
find
```

Informasi sistem:

```bash
uname -a
hostname
whoami
id
```

Resource sistem:

```bash
free -h
df -h
du -sh
```

Process:

```bash
ps
top
```

Service:

```bash
systemctl status
systemctl start
systemctl stop
systemctl restart
```

> Command akan ditambahkan dan dijelaskan setelah benar-benar dipraktikkan.

---

## ❌ Error

Belum ada error yang didokumentasikan karena environment VM masih dalam tahap download dan persiapan.

Nantinya setiap error yang ditemukan akan dicatat di bagian ini.

Contoh format:

```text
Error:
[isi error yang ditemukan]

Penyebab:
[hasil analisis]

Environment:
Ubuntu / RHEL

Command:
[command yang digunakan]
```

---

## 🔧 Solusi

Belum ada solusi yang dicatat karena belum masuk tahap praktik.

Setiap solusi akan ditulis berdasarkan hasil troubleshooting yang benar-benar dilakukan.

Format:

```text
Masalah:
...

Analisis:
...

Solusi:
...

Hasil:
...
```

---

## 🧠 Yang Saya Pahami

Untuk saat ini saya memahami bahwa Linux Server akan menjadi salah satu fondasi utama dalam perjalanan belajar DevOps dan DevSecOps.

Saya juga memahami bahwa menggunakan VM memungkinkan saya membuat environment Linux untuk belajar tanpa harus mengganti sistem operasi utama.

Saya memilih Ubuntu Server sebagai environment utama dan RHEL / RHEL-based sebagai environment tambahan agar nantinya dapat mengenal lebih dari satu ekosistem Linux.

Bagian teknis lainnya akan saya isi setelah melakukan praktik secara langsung.

---

## ❓ Belum Paham

Beberapa hal yang masih perlu dipelajari:

- Bagaimana filesystem Linux bekerja secara keseluruhan?
- Apa fungsi masing-masing directory seperti `/etc`, `/var`, `/home`, `/usr`, dan `/opt`?
- Bagaimana user dan group bekerja?
- Bagaimana permission Linux bekerja?
- Apa perbedaan process dan service?
- Bagaimana `systemd` bekerja?
- Bagaimana Linux mengelola package?
- Bagaimana Linux menangani networking?
- Bagaimana cara melakukan troubleshooting ketika service gagal?
- Apa perbedaan Ubuntu/Debian dengan RHEL ecosystem?

---

## 📌 Next

Setelah VM selesai dibuat, langkah berikutnya:

1. Menyelesaikan instalasi Ubuntu Server.
2. Menyelesaikan instalasi RHEL / RHEL-based environment.
3. Login ke masing-masing server.
4. Mengecek informasi sistem.
5. Mengenal struktur filesystem.
6. Membuat user dan group.
7. Memahami permission dan ownership.
8. Mempelajari process.
9. Mempelajari systemd dan service.
10. Mempelajari package management.
11. Melakukan basic troubleshooting.
12. Mendokumentasikan hasil praktik.

Setelah bagian Linux Fundamentals selesai, saya akan melanjutkan ke:

```text
Linux Server Fundamentals
        ↓
Networking Fundamentals
        ↓
SSH
        ↓
Nginx
        ↓
Firewall
        ↓
Security Hardening
        ↓
DevOps Foundation
```

---

## 📌 Catatan Belajar

Catatan ini akan terus diperbarui selama proses belajar.

Saya tidak akan menganggap suatu materi sudah dikuasai hanya karena sudah membaca atau mengikuti tutorial. Materi akan dianggap selesai setelah saya **mempraktikkannya sendiri dan memahami hasilnya**.
