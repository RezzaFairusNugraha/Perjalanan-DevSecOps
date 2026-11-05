# Red Hat Event — SysAdmin & Container Session + Quiz

## 🎯 Tujuan

Mendokumentasikan keikutsertaan dan insight dari sesi **Virtual Meet & Quiz Red Hat** seputar peran **System Administrator (SysAdmin)** modern dan teknologi **Container** di ekosistem Red Hat enterprise.

Sesi ini memperkuat pemahaman praktis antara pondasi administrasi Linux (Fase 1) dan teknologi kontainerisasi (Fase 2) dalam perjalanan menuju **DevSecOps**.

---

## 📚 Yang Dipelajari di Sesi Meet

### 1. Peran SysAdmin Modern di Era Cloud & Enterprise
- **Evolusi SysAdmin:** SysAdmin zaman sekarang tidak lagi hanya mengurus instalasi dan konfigurasi server secara manual, melainkan mengelola infrastruktur berbasis kode (*Infrastructure as Code*), otomasi berkas konfigurasi, serta menjaga kepatuhan dan keamanan (*security compliance*).
- **Stabilitas & Keamanan RHEL:** Red Hat Enterprise Linux (RHEL) dirancang dengan standar keamanan tinggi (termasuk modul kernel terverifikasi, SELinux aktif, dan sistem live-patching tanpa reboot kernel).
- **Troubleshooting Sistem:** Pentingnya pemantauan logs (`journalctl`, `/var/log`), manajemen service berbasis `systemd`, serta analisis performa CPU, memori, dan I/O disk.

### 2. Teknologi Container Enterprise (Podman vs Docker)
- **Arsitektur Daemonless:**
  - Docker bergantung pada satu *daemon* terpusat (`dockerd`) yang berjalan dengan hak akses root. Jika daemon crash, container di bawahnya bisa terpengaruh.
  - **Podman (Pod Manager)** berjalan secara *daemonless*—setiap container berjalan sebagai proses independen di bawah kendali pengguna langsung.
- **Rootless Containers:**
  - Kemampuan menjalankan dan mengelola container tanpa privilege `root`. Hal ini secara signifikan memangkas risiko *container breakout* atau eskalasi hak akses jika aplikasi di dalam container berhasil diretas oleh attacker.
- **Pod Concept (K8s Ready):**
  - Podman mendukung konsep **Pod** (kumpulan kontainer yang berbagi namespace jaringan dan storage bersama) serupa dengan arsitektur pod di Kubernetes/OpenShift, sehingga mempermudah transisi dari kontainer lokal ke orkestrasi skala besar.
- **OCI (Open Container Initiative) Compliance:** Image yang dibuat menggunakan Podman atau Dockerfile sepenuhnya kompatibel satu sama lain.

### 3. Sesi Interaktif & Quiz
- Mengikuti kuis evaluasi pemahaman materi seputar:
  - Perintah dan manajemen dasar Linux SysAdmin (file permission, proses, manajemen paket `dnf/rpm`, service management).
  - Konsep kontainerisasi, perbedaan container vs virtual machine, isolasi cgroups & namespaces.
  - Fitur unggulan Podman (rootless, daemonless, Kubernetes pod yaml generation).
- Berhasil menguji pemahaman teori yang telah dipelajari sebelumnya dan memverifikasi pengetahuan dari sertifikasi Red Hat Container yang sudah saya miliki.

---

## 🧠 Yang Saya Pahami & Relevansinya ke DevSecOps

1. **Rootless Container sebagai Standar DevSecOps:** Dalam pipeline DevSecOps, prinsip *least privilege* wajib diterapkan sampai ke level container runtime. Menggunakan rootless container membatasi dampak serangan jika aplikasi memiliki kerentanan (vulnerability).
2. **Kesiapan Menuju Kubernetes/OpenShift:** Memahami bagaimana SysAdmin enterprise mengelola container menggunakan RHEL dan Podman memberikan jembatan yang sangat jelas menuju materi Fase 4 (Kubernetes & Container Security).
3. **Validasi Kompetensi:** Mengikuti meet dan kuis ini menjadi pembuktian bahwa materi yang dipelajari selama PKL dan belajar mandiri sangat selaras dengan kebutuhan teknologi industri saat ini.

---

## 📌 Next

1. Menerapkan konsep container aman (rootless & non-root user) pada praktikum lab lokal.
2. Melanjutkan sisa materi praktis **Linux Fundamentals** di Hack The Box Academy.
3. Mempersiapkan materi automasi bash dan Git di Fase 2 (DevOps Foundation).
