# Persiapan Event Red Hat & Pendalaman Linux

## 🎯 Tujuan

Memperkuat pemahaman fundamental ekosistem Linux, khususnya standar enterprise berbasis **Red Hat (RHEL/Fedora/CentOS)** dan teknologi container/cloud-native, serta mempersiapkan diri untuk menghadiri **Event Red Hat** esok hari.

Target sesi ini:
- Mereview kembali konsep dasar sistem Linux berbasis enterprise (RHEL ecosystem).
- Mempersiapkan wawasan seputar teknologi unggulan Red Hat (RHEL, OpenShift, Podman, Ansible, Enterprise Linux Security).
- Menghubungkan materi Linux Fundamentals yang sedang dipelajari dengan implementasi nyata di dunia industri enterprise.
- Memanfaatkan momentum event untuk memperluas networking, insight industri, dan arah karir DevOps/DevSecOps.

---

## 📚 Yang Dipelajari & Dipersiapkan

### 1. Refleksi Ekosistem Red Hat vs Debian/Ubuntu
Dalam perjalanan belajar Linux sejauh ini, ada dua keluarga besar yang sering ditemui di industri:
- **Debian / Ubuntu Family:** Banyak dipakai untuk server startup, cloud instance umum, dan praktis untuk pemula (package manager: `apt`).
- **Red Hat Family (RHEL / CentOS Stream / Fedora / Rocky Linux):** Standar *de facto* untuk enterprise, perbankan, dan sistem pemerintahan karena stabilitas, dukungan keamanan jangka panjang, dan sertifikasi compliance (package manager: `dnf` / `rpm`).

Perbedaan penting yang direview:
- **Package Management:** `dnf` / `rpm` vs `apt`.
- **Security:** RHEL menggunakan **SELinux (Security-Enhanced Linux)** secara default sebagai mekanisme kontrol akses wajib (*Mandatory Access Control / MAC*), bukan hanya model permission standar Linux (`chmod`/`chown`).
- **Service Management:** `systemctl` (systemd) dan konfigurasi unit service.
- **Firewall:** `firewalld` (menggunakan konsep *zones*) vs `ufw` di Ubuntu.

### 2. Teknologi Kunci Red Hat yang Relevan dengan DevSecOps
- **RHEL (Red Hat Enterprise Linux):** Fondasi sistem operasi server enterprise yang aman dan stabil.
- **Podman & Buildah:** Container engine daemonless dan rootless dari Red Hat (standar OCI), yang lebih aman dibandingkan arsitektur Docker tradisional.
- **Red Hat OpenShift:** Platform orkestrasi enterprise Kubernetes dengan built-in security, pipeline CI/CD, dan image registry.
- **Ansible:** Alat automasi dan *Infrastructure as Code* (IaC) untuk konfigurasi sistem tanpa agen (*agentless*).

### 3. Agenda & Ekspektasi Menghadiri Event Red Hat
- **Insight Industri Terkini:** Mempelajari bagaimana perusahaan enterprise mengadopsi Hybrid Cloud, AI/ML workload di atas Linux/OpenShift, dan implementasi DevSecOps.
- **Praktik Terbaik Keamanan Enterprise:** Memahami bagaimana Red Hat menangani vulnerability patching, supply chain security, dan compliance.
- **Networking & Karir:** Berinteraksi dengan praktisi IT, engineer, dan komunitas untuk mendapatkan gambaran kebutuhan industri bagi lulusan baru di bidang Linux, Cloud, dan DevOps.

---

## 💻 Rencana & Checklist Menjelang Event

- [x] Review perintah dasar Linux & navigasi sistem.
- [x] Memahami arsitektur ekosistem Red Hat (RHEL, Podman, OpenShift, Ansible).
- [ ] Menghadiri sesi seminar / tech talk pada Event Red Hat.
- [ ] Mencatat poin-poin penting dan teknologi baru yang dipresentasikan.
- [ ] Mendokumentasikan hasil insight dan takeaway dari event ke repositori ini.

---

## 🧠 Yang Saya Pahami

1. **Relevansi Sertifikat Red Hat Container:** Sertifikat Red Hat Container yang sudah saya miliki menjadi modal awal yang sangat berharga. Dengan menghadiri event ini, saya bisa melihat bagaimana teknologi container enterprise tersebut diterapkan pada skala besar.
2. **Koneksi Linux ke DevSecOps:** Belajar Linux bukan sekadar menghafal command navigasi (`ls`, `find`), tetapi memahami bagaimana sistem operasi enterprise dikelola secara otomatis, aman, dan dapat diskalakan (*scalable*).
3. **Peluang di Ekosistem Red Hat:** Kebutuhan profesional yang memahami sistem Red Hat, OpenShift, dan Ansible di pasar kerja enterprise sangat tinggi dengan nilai tawar yang kuat.

---

## 📌 Next

1. Mengikuti rangkaian acara **Event Red Hat**.
2. Membuat rangkuman catatan (*key takeaways & insights*) setelah event selesai.
3. Melanjutkan sisa materi praktis **Linux Fundamentals** di Hack The Box Academy dan TryHackMe.
