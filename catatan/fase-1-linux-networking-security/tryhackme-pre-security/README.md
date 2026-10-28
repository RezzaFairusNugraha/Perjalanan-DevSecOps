# TryHackMe — Cyber Security Intro & Pre Security

## 🎯 Tujuan

Memahami fondasi dasar dunia Cybersecurity dan cara kerja sistem komputer melalui platform **TryHackMe** sebelum masuk lebih dalam ke Linux Server, Networking, dan DevSecOps.

Selain membangun lab mandiri menggunakan Virtual Machine, saya memutuskan untuk aktif menggunakan **TryHackMe** sebagai platform belajar dan latihan utama karena di dalamnya sudah tersedia jalur pembelajaran yang terstruktur mulai dari **Pre Security** hingga **DevSecOps**.

Target pembelajaran pada sesi ini:

- Memahami perbedaan serta peran **Offensive Security** (Red Team) dan **Defensive Security** (Blue Team).
- Mengenal berbagai jalur karier di bidang Cybersecurity (**Careers in Cyber**), khususnya yang relevan dengan **Security Engineering** dan **DevSecOps**.
- Memahami komponen dasar **Hardware** komputer dan bagaimana perangkat keras bekerja menjalankan sistem operasi.
- Memulai jalur pembelajaran **Pre Security** sebagai pondasi sebelum lanjut ke Networking dan Linux Fundamentals.

---

## 📚 Yang Dipelajari

### 1. Offensive Security Intro

Offensive Security berfokus pada cara **menemukan dan mengeksploitasi celah keamanan (vulnerability)** pada suatu sistem layaknya seorang penyerang (attacker), tetapi dilakukan secara legal dan terarah untuk memperbaiki keamanan sistem tersebut.

Hal-hal yang dipelajari pada room ini:

- Konsep dasar bagaimana *ethical hacker* / *penetration tester* bekerja mencari celah pada aplikasi atau sistem.
- Praktik simulasi pertama melakukan *hacking* terhadap website bank palsu (*FakeBank*) menggunakan terminal (mencari halaman tersembunyi menggunakan `gobuster` untuk melakukan transfer saldo).
- Memahami bahwa untuk mengamankan sebuah sistem (DevSecOps), kita juga perlu tahu bagaimana cara penyerang berpikir dan mencari celah.

### 2. Defensive Security Intro

Defensive Security adalah kebalikan dari Offensive Security, yaitu berfokus pada **mencegah intrusi, mendeteksi serangan, dan merespons insiden keamanan** ketika serangan terjadi.

Beberapa konsep utama di dalam Defensive Security:

- **SOC (Security Operations Center):** Tim yang memantau jaringan dan sistem secara *real-time* untuk mendeteksi aktivitas mencurigakan.
- **Threat Intelligence:** Mengumpulkan informasi mengenai ancaman dan aktor serangan untuk menyiapkan pertahanan.
- **DFIR (Digital Forensics and Incident Response):** Menganalisis bukti digital dan menanggulangi dampak serangan yang terjadi.
- **Malware Analysis:** Menganalisis program berbahaya untuk memahami cara kerjanya dan cara memitigasinya.
- Praktik simulasi di room: Memantau alert pada SIEM sederhana, mengecek IP berbahaya melalui *threat intelligence scanner*, dan melakukan pemblokiran IP melalui firewall.

### 3. Careers in Cyber

Mempelajari berbagai peran dan profesi di dunia Cybersecurity untuk memetakan arah karier yang paling sesuai dengan minat saya:

- **Security Analyst / SOC Analyst:** Bertugas memonitor dan menganalisis anomali atau serangan pada sistem.
- **Security Engineer:** Merancang, membangun, dan mengimplementasikan kontrol keamanan pada infrastructure, jaringan, maupun pipeline aplikasi (**sangat dekat dengan DevSecOps**).
- **Incident Responder & Digital Forensics Examiner:** Menangani insiden ketika sistem berhasil ditembus dan menelusuri jejak serangan.
- **Penetration Tester & Red Teamer:** Menguji ketahanan keamanan sistem dengan melakukan simulasi serangan.

Dari pembahasan *Careers in Cyber* ini, saya semakin yakin bahwa peran **Security Engineer / DevSecOps** sangat cocok karena menggabungkan infrastruktur, pengembangan aplikasi, automasi, dan keamanan.

### 4. Hardware & Computer Fundamentals

Sebelum mempelajari sistem operasi (Linux) dan jaringan pada jalur **Pre Security**, saya mempelajari bagaimana komputer bekerja dari sisi perangkat keras (*Hardware*):

```text
Hardware (CPU, RAM, Storage, Motherboard, I/O)
                    ↓
               BIOS / UEFI
                    ↓
          Operating System (Linux)
                    ↓
           Services & Applications
```

Komponen penting yang dipelajari:

- **CPU (Central Processing Unit):** Otak komputer yang mengeksekusi instruksi dan memproses data.
- **RAM (Random Access Memory):** Penyimpanan sementara berkecepatan tinggi (*volatile*) untuk menyimpan data dari proses yang sedang berjalan.
- **Storage (HDD / SSD):** Penyimpanan permanen (*non-volatile*) tempat sistem operasi, file konfigurasi, dan data disimpan.
- **Motherboard & Bus:** Papan utama yang menghubungkan seluruh komponen hardware agar dapat saling berkomunikasi.
- **Perangkat I/O (Input/Output):** Perangkat untuk berinteraksi dengan sistem.

Memahami hardware ini sangat membantu ketika nanti melakukan **Resource Monitoring** di Linux Server (seperti membaca penggunaan CPU, RAM dengan `free -h`, dan Disk dengan `df -h`).

---

## 💻 Praktik

### Status Saat Ini

**Sedang menjalankan modul pengantar Cybersecurity dan Pre Security di TryHackMe.**

Progress yang sudah dikerjakan hari ini:

- [x] Menyelesaikan room **Offensive Security Intro** (simulasi enumerasi direktori web dengan `gobuster` pada aplikasi FakeBank).
- [x] Menyelesaikan room **Defensive Security Intro** (simulasi analisis log alert SIEM, pengecekan reputasi IP, dan blokir IP berbahaya).
- [x] Menyelesaikan room **Careers in Cyber** (eksplorasi berbagai jalur karier security dan pemetaan menuju Security Engineer / DevSecOps).
- [x] Mempelajari materi **Hardware / Computer Fundamentals** pada jalur **Pre Security**.
- [ ] Melanjutkan modul **Network Fundamentals** di Pre Security.
- [ ] Melanjutkan modul **How the Web Works** di Pre Security.
- [ ] Melanjutkan modul **Linux Fundamentals** di Pre Security.
- [ ] Melanjutkan modul **Windows Fundamentals** di Pre Security.

---

## 🧾 Perintah Penting

Pada room **Offensive Security Intro**, saya mempraktikkan penggunaan `gobuster` di terminal *AttackBox* untuk mencari halaman/direktori tersembunyi pada sebuah web server:

```bash
gobuster -u http://fakebank.com -w wordlist.txt dir
```

Penjelasan flag:

- `gobuster`: Tool command-line untuk melakukan *brute-force* direktori/file pada web server.
- `-u http://fakebank.com`: Menentukan target URL yang ingin dipindai.
- `-w wordlist.txt`: Menggunakan daftar kata (*wordlist*) untuk menebak nama direktori pada website.
- `dir`: Mode pencarian direktori (*directory/file enumeration*).

Dari hasil pemindaian tersebut ditemukan endpoint sensitif (seperti `/bank-transfer`) yang seharusnya tidak bisa diakses publik tanpa autentikasi.

---

## ❌ Error

Belum ada error teknis yang menghambat saat menjalankan *AttackBox* dan simulasi di TryHackMe.

Catatan kecil saat praktik:

```text
Kondisi:
Koneksi ke mesin virtual browser (AttackBox) di TryHackMe terkadang membutuhkan waktu loading beberapa saat saat pertama kali dijalankan.

Penyebab:
Proses provisioning instance cloud container/VM di sisi server TryHackMe.
```

---

## 🔧 Solusi

```text
Masalah:
Menunggu AttackBox siap digunakan dan memastikan target IP/URL dapat diakses dari dalam environment lab.

Analisis:
AttackBox berjalan di jaringan internal lab TryHackMe sehingga URL lokal seperti fakebank.com hanya bisa diakses dari browser di dalam AttackBox, bukan dari browser laptop utama.

Solusi:
Menggunakan browser dan terminal bawaan di dalam AttackBox untuk menjalankan gobuster dan mengakses aplikasi target.

Hasil:
Berhasil menemukan halaman tersembunyi /bank-transfer dan menyelesaikan lab.
```

---

## 🧠 Yang Saya Pahami

Dari sesi belajar hari ini di TryHackMe, saya memahami bahwa:

1. **Offensive dan Defensive Security saling melengkapi:** Dalam dunia **DevSecOps**, kita perlu memahami cara kerja serangan (*Offensive*) agar bisa membangun pipeline, konfigurasi server, dan sistem monitoring yang tahan terhadap serangan (*Defensive*).
2. **Pentingnya membatasi akses endpoint sensitif:** Dari simulasi *FakeBank*, terlihat bagaimana halaman admin (`/` atau `/bank-transfer`) yang tidak diamankan dengan autentikasi dapat ditemukan dengan mudah menggunakan tool otomatis seperti `gobuster`.
3. **Koneksi antara Hardware dan Administrasi Server:** Memahami fungsi CPU, RAM (*volatile*), dan Storage (*non-volatile*) menjadi dasar penting sebelum mengelola resource server Linux, container, maupun instance Cloud (seperti memilih ukuran EC2 di AWS).
4. **TryHackMe sebagai pendamping belajar DevSecOps:** Karena TryHackMe menyediakan alur dari **Pre Security** sampai **DevSecOps** (termasuk Container Security, CI/CD Security, dan IaC Security), saya akan rutin menggunakannya di sepanjang perjalanan 18 minggu ini.

---

## ❓ Belum Paham

Beberapa hal yang ingin saya pelajari lebih dalam pada tahap berikutnya:

- Bagaimana cara mencegah serangan enumerasi direktori seperti `gobuster` pada web server (misalnya menggunakan konfigurasi Nginx atau rate limiting)?
- Bagaimana SIEM yang sesungguhnya (di dunia kerja) mengumpulkan log dari berbagai server Linux dan aplikasi?
- Bagaimana detail paket data dikirimkan melalui jaringan dari satu komputer ke komputer lain pada materi *Network Fundamentals* nanti?

---

## 📌 Next

Langkah selanjutnya di TryHackMe dan Fase 1:

1. Melanjutkan learning path **Pre Security** di TryHackMe:
   - **Network Fundamentals** (What is Networking, Intro to LAN, OSI Model, Packets & Frames, Extending Your Network)
   - **How the Web Works** (DNS in Detail, HTTP in Detail, How Websites Work, Putting it all together)
   - **Linux Fundamentals** (Part 1, Part 2, Part 3)
2. Menggabungkan materi dari TryHackMe dengan praktik langsung di **VM Ubuntu Server & RHEL**.
3. Mendokumentasikan setiap room dan praktik Linux yang sudah diselesaikan ke dalam repository ini.
