# Fase 1 — TryHackMe Pre Security & Linux Server Fundamentals

## 🎯 Tujuan

Memahami fondasi dasar Cybersecurity melalui **TryHackMe (Pre Security)** serta dasar-dasar **Linux Server** sebagai fondasi untuk mempelajari DevOps, Cloud, dan DevSecOps.

Pada tahap awal ini saya menggabungkan dua pendekatan belajar:
1. **TryHackMe** (mulai dari *Pre Security* hingga nantinya ke jalur *DevSecOps*) untuk memahami konsep fundamental komputer/hardware, pengenalan *Offensive & Defensive Security*, *Careers in Cyber*, networking, dan lab Linux interaktif.
2. **Virtual Machine (VM)** lokal untuk mempraktikkan administrasi Linux Server secara terisolasi dari sistem utama.

Target pembelajaran:

- Memahami konsep dasar **Offensive Security Intro**, **Defensive Security Intro**, dan **Careers in Cyber** di TryHackMe.
- Memahami dasar **Hardware** komputer (CPU, RAM, Storage, I/O) dan hubungannya dengan sistem operasi.
- Memahami struktur dasar Linux Server & filesystem Linux.
- Memahami user, group, permission, dan ownership.
- Memahami process, service (`systemd`), dan package management.
- Memahami cara membaca informasi resource sistem dan dasar troubleshooting Linux.

> 💡 **Catatan khusus TryHackMe Pre Security:** Dokumentasi lengkap mengenai apa yang saya pelajari di TryHackMe hari ini juga dicatat secara mendalam di [`../tryhackme-pre-security/README.md`](../tryhackme-pre-security/README.md).

---

## 📚 Yang Dipelajari

### 1. TryHackMe — Cyber Security Intro & Pre Security

Sebelum masuk lebih jauh ke konfigurasi server, saya memulai pembelajaran di **TryHackMe** pada bagian pengantar dan **Pre Security** karena di TryHackMe juga terdapat jalur pembelajaran **DevSecOps** yang akan sering saya gunakan ke depannya.

Materi yang sudah saya pelajari di TryHackMe:

- **Offensive Security Intro:** Memahami bagaimana sisi *attacker* / *penetration tester* mencari celah keamanan pada aplikasi. Saya mempraktikkan simulasi menemukan halaman tersembunyi pada website *FakeBank* menggunakan tool `gobuster` di terminal.
- **Defensive Security Intro:** Memahami bagaimana sisi *defender* (Blue Team / SOC) memonitor sistem, menganalisis alert SIEM, memeriksa *Threat Intelligence* terhadap IP mencurigakan, dan memblokir serangan melalui firewall.
- **Careers in Cyber:** Mempelajari berbagai peran di dunia keamanan siber (SOC Analyst, Incident Responder, Penetration Tester, hingga **Security Engineer / DevSecOps**). Ini semakin memperjelas target belajar saya menuju **DevSecOps**.
- **Hardware & Computer Fundamentals:** Mempelajari cara kerja komponen perangkat keras komputer (CPU, RAM yang bersifat *volatile*, Storage yang bersifat *non-volatile*, Motherboard) sebagai fondasi sebelum mempelajari cara sistem operasi Linux mengelola resource tersebut.

### 2. Linux Server

Linux Server adalah sistem operasi Linux yang digunakan untuk menjalankan service, aplikasi, database, web server, dan berbagai workload lainnya.

Pada pembelajaran DevOps dan DevSecOps, Linux menjadi salah satu fondasi utama karena hampir seluruh server, container, dan cloud infrastructure berjalan di atas Linux.

Untuk memulai pembelajaran mandiri di luar lab TryHackMe, saya menyiapkan dua environment:

- **Ubuntu Server**
- **RHEL / RHEL-based environment**

Ubuntu akan digunakan sebagai environment utama untuk mengikuti pembelajaran, sedangkan environment RHEL digunakan untuk mengenal ekosistem Red Hat.

### 3. Virtual Machine & Lab TryHackMe

Saya menggunakan kombinasi **TryHackMe AttackBox / Cloud Lab** dan **Virtual Machine (VM)** lokal agar dapat menjalankan Linux Server tanpa mengganti sistem operasi utama.

Konsep environment yang digunakan:

```text
Pembelajaran Fase 1
  │
  ├── TryHackMe (Pre Security → Linux & Network → DevSecOps)
  │     ├── Offensive & Defensive Security Intro
  │     ├── Careers in Cyber
  │     └── Hardware & System Fundamentals
  │
  └── Virtual Machine (Lokal)
        ├── Ubuntu Server
        └── RHEL / RHEL-based
```

### 4. Ubuntu Server & RHEL

Ubuntu Server digunakan sebagai environment utama untuk mempelajari Linux Fundamentals:

- Filesystem
- User & Group
- Permission
- Process & Service
- Package Management
- Networking & SSH
- System Monitoring (CPU, RAM, Disk — menyambung dari materi *Hardware*)
- Troubleshooting

Sedangkan RHEL digunakan untuk mengenal sistem Linux berbasis Red Hat dan membandingkannya dengan ekosistem Ubuntu/Debian (package management, service management, firewall, dan struktur konfigurasi).

---

## 💻 Praktik

### Status Saat Ini

**Sedang aktif belajar di TryHackMe (Pre Security) sambil menyiapkan environment VM Linux.**

Progress yang sudah dan sedang saya kerjakan:

#### 🛡️ TryHackMe (Pre Security & Intro)
- [x] Menyelesaikan **Offensive Security Intro** (praktik enumerasi direktori web dengan `gobuster`).
- [x] Menyelesaikan **Defensive Security Intro** (praktik analisis SIEM alert, threat intelligence, dan blokir IP di firewall).
- [x] Menyelesaikan **Careers in Cyber** (mengenal peran Security Engineer & arah karier ke DevSecOps).
- [x] Mempelajari **Hardware Fundamentals** di Pre Security.
- [ ] Melanjutkan modul **Network Fundamentals** & **How the Web Works** di TryHackMe.
- [ ] Melanjutkan modul **Linux Fundamentals** di TryHackMe.

#### 🐧 Persiapan & Praktik Linux Server (VM)
- [x] Menentukan Ubuntu Server sebagai Linux Server utama.
- [x] Menentukan RHEL sebagai environment tambahan.
- [ ] Download Ubuntu Server & RHEL-based environment.
- [ ] Membuat VM Ubuntu & VM RHEL.
- [ ] Menyelesaikan instalasi dan melakukan login pertama.
- [ ] Mengecek informasi sistem & hardware resource.
- [ ] Mempelajari filesystem, user, group, dan permission.
- [ ] Mempelajari process, service, dan package management.
- [ ] Melakukan basic troubleshooting.

---

## 🧾 Perintah Penting

### Command dari Praktik TryHackMe (Offensive Security Intro)

Mencari direktori atau halaman tersembunyi pada web server menggunakan `gobuster`:

```bash
gobuster -u http://fakebank.com -w wordlist.txt dir
```

### Command Linux Server yang Akan & Sedang Dipelajari

Navigasi dan manipulasi file:

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

Resource sistem (terkait materi Hardware — RAM & Storage):

```bash
free -h
df -h
du -sh
```

Process & Service:

```bash
ps
top
systemctl status
systemctl start
systemctl stop
systemctl restart
```

---

## ❌ Error

Belum ada error kritis yang menghambat proses belajar.

Pada saat menggunakan TryHackMe AttackBox, web target lokal (`fakebank.com`) hanya dapat diakses dari dalam browser *AttackBox* (jaringan internal lab) dan bukan dari browser laptop utama.

Nantinya setiap error konfigurasi Linux yang ditemukan saat praktik VM maupun lab TryHackMe akan dicatat di bagian ini dengan format:

```text
Error:
[isi error yang ditemukan]

Penyebab:
[hasil analisis]

Environment:
TryHackMe / Ubuntu / RHEL

Command:
[command yang digunakan]
```

---

## 🔧 Solusi

Setiap solusi akan ditulis berdasarkan hasil troubleshooting yang benar-benar dilakukan.

```text
Masalah:
Mengakses target lab di TryHackMe Offensive Security Intro.

Analisis:
Target berjalan di jaringan terisolasi milik lab TryHackMe.

Solusi:
Menggunakan terminal dan browser bawaan di dalam AttackBox untuk melakukan scanning dengan gobuster dan membuka halaman web target.

Hasil:
Berhasil menemukan endpoint tersembunyi /bank-transfer dan menyelesaikan simulasi.
```

---

## 🧠 Yang Saya Pahami

Dari apa yang sudah saya pelajari sejauh ini:

1. **Gambaran Besar Cybersecurity (Offensive vs Defensive):** Melalui TryHackMe, saya memahami perbedaan cara kerja tim penyerang (*Offensive*) yang mencari celah seperti direktori terbuka, dan tim bertahan (*Defensive*) yang memantau SIEM serta memblokir ancaman lewat firewall. Keduanya sangat relevan dengan **DevSecOps** karena tujuan akhirnya adalah mengotomatisasi keamanan sejak awal.
2. **Arah Karier Menuju DevSecOps:** Dari materi *Careers in Cyber* dan tersedianya learning path *DevSecOps* di TryHackMe, saya memutuskan akan sering belajar di TryHackMe untuk memperkuat sisi security sembari membangun skill DevOps.
3. **Dasar Hardware ke Linux Server:** Memahami cara kerja CPU, RAM, dan Storage di materi *Pre Security* membuat konsep monitoring resource di Linux Server menjadi lebih masuk akal.
4. **Isolasi Environment Belajar:** Baik menggunakan lab interaktif di TryHackMe maupun VM lokal (Ubuntu Server & RHEL) memungkinkan saya bereksperimen dengan aman tanpa merusak sistem utama.

---

## ❓ Belum Paham

Beberapa hal yang masih perlu dipelajari di tahap selanjutnya:

- Bagaimana cara mengamankan web server (misalnya di Nginx) agar endpoint sensitif tidak mudah ditemukan menggunakan tool seperti `gobuster`?
- Bagaimana filesystem Linux bekerja secara keseluruhan (`/etc`, `/var`, `/home`, `/usr`, `/opt`)?
- Bagaimana user, group, dan permission Linux bekerja secara detail?
- Apa perbedaan process dan service serta bagaimana `systemd` bekerja?
- Bagaimana Linux mengelola package dan menangani networking?
- Apa perbedaan administrasi sistem antara Ubuntu/Debian dengan RHEL ecosystem?

---

## 📌 Next

Langkah berikutnya pada Fase 1:

1. Melanjutkan modul **Pre Security** di TryHackMe (khususnya *Network Fundamentals*, *How the Web Works*, dan *Linux Fundamentals*).
2. Menyelesaikan instalasi VM Ubuntu Server & RHEL-based environment.
3. Mempraktikkan langsung command dasar Linux, manajemen user/permission, process, dan service.
4. Mendokumentasikan setiap perkembangan belajar dari TryHackMe dan VM ke dalam catatan Fase 1.

Alur belajar Fase 1:

```text
TryHackMe Pre Security (Intro, Hardware, Network, Linux)
        ↓
Linux Server Fundamentals (VM Ubuntu & RHEL)
        ↓
Networking Fundamentals
        ↓
SSH & SSH Hardening
        ↓
Nginx & SSL/TLS
        ↓
Firewall & Security Hardening
        ↓
DevOps Foundation (Fase 2)
```

---

## 📌 Catatan Belajar

Catatan ini akan terus diperbarui selama proses belajar.

Saya tidak akan menganggap suatu materi sudah dikuasai hanya karena sudah membaca atau mengikuti tutorial. Materi akan dianggap selesai setelah saya **mempraktikkannya sendiri dan memahami hasilnya**.
