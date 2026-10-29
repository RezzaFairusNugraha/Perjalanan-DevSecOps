# Pengenalan ke DevOps (Dicoding)

## 🎯 Tujuan

Memahami konsep dasar, filosofi, prinsip, dan metodologi DevOps secara terstruktur melalui kelas **"Pengenalan ke DevOps"** di **Dicoding**, serta berhasil menyelesaikan evaluasi dan meraih sertifikat kelulusan.

Target pembelajaran:
- Memahami latar belakang munculnya DevOps dan masalah pada proses pengembangan tradisional (*Silo Mentality* / *Wall of Confusion*).
- Memahami pengertian, tujuan, dan manfaat penerapan DevOps bagi developer dan tim operasional.
- Memahami prinsip utama DevOps melalui konsep **The Three Ways**.
- Memahami kerangka kerja **CALMS (Culture, Automation, Lean, Measurement, Sharing)**.
- Mengetahui tahapan pada **DevOps Pipeline** serta perkakas (*tools*) yang digunakan di setiap tahap.
- Mempelajari studi kasus transformasi nyata implementasi DevOps pada perusahaan skala besar (Amazon).

---

## 📚 Yang Dipelajari

### 1. Masalah pada Pengembangan Tradisional & Latar Belakang DevOps
- **Silo Mentality & Wall of Confusion:** Pemisahan kaku antara tim Developer (yang fokus pada perubahan cepat / rilis fitur) dan tim Operations (yang fokus pada stabilitas sistem). Hal ini sering menyebabkan saling lempar kesalahan saat deployment gagal.
- **Pengertian DevOps:** DevOps bukan sekadar jabatan (*job role*) atau penggunaan alat tertentu, melainkan kombinasi dari filosofi budaya, praktik, dan kumpulan alat (*tools*) yang meningkatkan kemampuan organisasi untuk merilis aplikasi dengan kecepatan dan kualitas tinggi.
- **Manfaat:** Waktu rilis lebih singkat (*faster time to market*), frekuensi deployment lebih sering, deteksi bug lebih dini, dan pemulihan sistem yang lebih cepat (*faster mean time to recovery / MTTR*).

### 2. Prinsip-Prinsip DevOps (The Three Ways)
Prinsip dasar yang menjadi pedoman alur kerja DevOps:
1. **The First Way (Flow / Alur Kerja):** Mengoptimalkan aliran kerja dari hulu (Development) ke hilir (Operations/Pengguna). Mempercepat proses rilis dengan membagi pekerjaan menjadi batch-batch kecil dan meminimalkan hambatan (*bottleneck*).
2. **The Second Way (Feedback / Umpan Balik):** Memperpendek dan mempercepat siklus umpan balik dari hilir kembali ke hulu. Setiap kegagalan atau bug langsung terdeteksi sedini mungkin (misalnya lewat automated testing dan monitoring).
3. **The Third Way (Continual Learning & Experimentation):** Membangun budaya eksperimen, berani mengambil risiko terkontrol, belajar dari kesalahan (*blameless post-mortem*), dan terus melakukan peningkatan sistem secara berkelanjutan.

### 3. CALMS Framework
Kerangka kerja lima pilar untuk menilai dan mengukur kesuksesan adopsi DevOps:
- **C — Culture:** Perubahan pola pikir, rasa tanggung jawab bersama (*shared ownership*), kolaborasi tanpa silo, dan komunikasi terbuka.
- **A — Automation:** Mengotomatiskan proses berulang seperti testing, build, deployment, dan provisioning infrastruktur demi mengurangi human-error dan mempercepat proses.
- **L — Lean:** Menerapkan prinsip efisiensi, memangkas proses yang tidak memberi nilai tambah (*waste reduction*), serta membagi pekerjaan dalam ukuran kecil.
- **M — Measurement:** Mengukur metrik keberhasilan secara terukur (seperti *Deployment Frequency*, *Lead Time for Changes*, *Change Failure Rate*, dan *MTTR*).
- **S — Sharing:** Berbagi pengetahuan, dokumentasi, transparansi proses, serta keberhasilan maupun kegagalan di seluruh tim.

### 4. Praktik & Pipeline DevOps
Tahapan utama dalam siklus hidup DevOps (*infinity loop*):
- **Plan:** Perencanaan kebutuhan fitur, arsitektur, dan backlog (Jira, Trello, GitHub Projects).
- **Code:** Menulis kode aplikasi dan version control (Git, GitHub, GitLab).
- **Build & Test (CI):** Mengompilasi kode, menjalankan automated unit test, dan membungkus artifact/container (GitHub Actions, Jenkins, Docker).
- **Release & Deploy (CD):** Merilis dan menyebarkan aplikasi ke staging/production secara otomatis.
- **Operate & Monitor:** Menjalankan aplikasi, memonitor metrik performa, dan mencatat log (Kubernetes, Prometheus, Grafana).

### 5. Studi Kasus: Transformasi DevOps di Amazon
- Mengamati bagaimana Amazon bertransformasi dari sistem lama yang monolitik dan lambat menjadi arsitektur microservices dengan tim kecil (*Two-Pizza Teams*).
- Penerapan filosofi *"You build it, you run it"*: tim yang mengembangkan suatu service juga bertanggung jawab untuk menjaga kestabilannya saat berjalan di production.
- Hasil transformasi memungkinkan jutaan deployment terjadi per tahun tanpa mengorbankan stabilitas layanan.

---

## 💻 Praktik & Evaluasi

### Status Kelulusan
- [x] Menyelesaikan seluruh materi modul 1 sampai 7 di Dicoding.
- [x] Menyelesaikan Kuis Pengenalan DevOps.
- [x] Menyelesaikan Kuis Prinsip-Prinsip DevOps (The Three Ways).
- [x] Menyelesaikan Kuis CALMS Framework.
- [x] Menyelesaikan Kuis Praktik DevOps.
- [x] Menyelesaikan Kuis Kisah Implementasi DevOps (Studi Kasus Amazon).
- [x] Lulus **Ujian Akhir Kelas** dan resmi memperoleh **Sertifikat Kelulusan Dicoding: Pengenalan ke DevOps**.

---

## 🧠 Yang Saya Pahami

1. **DevOps Adalah Budaya, Bukan Sekadar Tool:** Tool seperti Docker, Kubernetes, atau GitHub Actions hanyalah instrumen pendukung (*enabler*). Inti dari DevOps adalah kolaborasi erat antara manusia (Developer & Operations) dengan tujuan yang selaras.
2. **Keterkaitan dengan DevSecOps:** Fondasi CALMS dan *The Three Ways* sangat relevan untuk DevSecOps. Dalam DevSecOps, prinsip umpan balik (*Second Way*) diperluas dengan menambahkan security scanning otomatis sejak tahap awal (*shift-left security*).
3. **Pemberdayaan sebagai Siswa SMK & Calon Engineer:** Pemahaman konsep ini sangat sinkron dengan pengalaman PKL Fullstack saya: sekarang saya tahu mengapa proses deployment sering terasa sulit jika tim pengembang dan tim operasional tidak berkolaborasi dari awal.

---

## 📌 Next

Melanjutkan ke tahapan implementasi teknis berikutnya sesuai roadmap:
1. Melanjutkan pemantapan **Linux Fundamentals & Networking** di Fase 1 (melalui TryHackMe Pre Security & lab VM).
2. Memasuki **Fase 2 (DevOps Foundation)**:
   - Menguasai Git & GitHub Workflow secara mendalam.
   - Menguasai pembuatan `Dockerfile` / `Containerfile` (Docker & Podman).
   - Menyusun multi-container environment menggunakan Compose.
