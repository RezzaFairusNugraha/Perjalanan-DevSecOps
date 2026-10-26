<div align="center">

# 🚀 Perjalanan DevSecOps

**Dokumentasi perjalanan belajarku dari Linux, DevOps, Cloud, hingga DevSecOps melalui catatan, lab praktik, dan proyek nyata.**

Linux · Networking · Docker · CI/CD · AWS · Terraform · Kubernetes · Cybersecurity · DevSecOps

</div>

---

## 👋 Tentang Repo Ini

Repo ini adalah jurnal belajarku selama **18 minggu**  
(**23 Okt 2026 – 26 Feb 2027**), yang dikerjakan sambil menjalani PKL.

Perjalanan ini berfokus pada membangun fondasi **Linux, Networking, DevOps, Cloud, dan Cybersecurity**, kemudian menggabungkannya menjadi kemampuan **DevSecOps**.

Semua materi di repo ini dibuat berdasarkan apa yang benar-benar kupelajari dan praktikkan sendiri.

Di sini aku mendokumentasikan:

- 📚 Materi yang dipelajari
- 💻 Lab dan eksperimen
- 🛠️ Command dan konfigurasi
- ❌ Error yang ditemukan
- 🔧 Cara troubleshooting
- 🔐 Implementasi security
- 📦 Deployment
- 🚀 Proyek nyata
- 📝 Hal-hal yang masih belum kupahami

Tujuannya bukan sekadar menyelesaikan tutorial, tetapi **memahami bagaimana aplikasi dan infrastructure dibangun, dijalankan, dideploy, dimonitor, dan diamankan.**

---

## 🙋 Tentang Saya

- 🎓 Siswa SMK yang sedang PKL di bidang fullstack
- 🐧 Memiliki sertifikat **Red Hat Container**
- 🔐 Tertarik pada cybersecurity sejak SMP
- ⚙️ Sedang membangun kemampuan di bidang DevOps
- ☁️ Tertarik pada Cloud dan Infrastructure
- 🛡️ Target jangka panjang: **DevSecOps / Security Engineering**
- 🎯 Target setelah lulus: **Junior DevOps / Cloud / DevSecOps / Security Engineer**

Perjalanan belajarku mengikuti konsep:

```text
Linux
  ↓
Networking
  ↓
DevOps
  ↓
Cloud
  ↓
Infrastructure as Code
  ↓
Kubernetes
  ↓
Security
  ↓
DevSecOps
```

---

# 🧭 Peta Belajar

| Fase | Minggu |     Tanggal     | Fokus                                  | Status |
| :--: | :----: | :-------------: | :------------------------------------- | :----: |
|  1   |  1–3   | 26 Okt – 15 Nov | Linux, Networking & Security Hardening |   ⬜   |
|  2   |  4–6   | 16 Nov – 6 Des  | DevOps Foundation                      |   ⬜   |
|  3   |  7–9   |   7 – 27 Des    | Cloud & Infrastructure as Code         |   ⬜   |
|  4   | 10–13  | 28 Des – 24 Jan | Kubernetes & Container Security        |   ⬜   |
|  5   | 14–16  | 25 Jan – 14 Feb | DevSecOps Pipeline                     |   ⬜   |
|  6   |   17   |   15 – 21 Feb   | Advanced Security & Production         |   ⬜   |
|  🏁  |   18   |   22 – 26 Feb   | Portfolio & Job Preparation            |   ⬜   |

---

# 🗺️ Detail Fase & Task

## 🐧 Fase 1 — Linux, Networking & Security Hardening

**Minggu 1–3**

### 🎯 Target

Memahami Linux sebagai environment server, networking dasar, remote access, reverse proxy, dan security hardening.

### Task

- [ ] Linux Server Fundamentals
- [ ] User, Group & Permission
- [ ] Process & Systemd
- [ ] Package Management
- [ ] Disk, Memory & Resource Monitoring
- [ ] Networking Fundamentals
- [ ] TCP/IP, Port & Protocol
- [ ] DNS & HTTP/HTTPS
- [ ] Network Troubleshooting
- [ ] SSH & SSH Key
- [ ] SSH Hardening
- [ ] Firewall
- [ ] Server Security Hardening
- [ ] Nginx Reverse Proxy
- [ ] SSL/TLS
- [ ] Nginx Troubleshooting

### 📁 Dokumentasi

```text
catatan/fase-1-linux-networking-security/
```

### 🧪 Praktik

```text
lab/fase-1/
```

### 🎯 Output Fase

Mampu menyiapkan server Linux sederhana yang:

- dapat diakses menggunakan SSH key
- memiliki firewall
- menggunakan basic security hardening
- menjalankan aplikasi melalui Nginx reverse proxy
- menggunakan HTTPS
- dapat dilakukan troubleshooting ketika terjadi masalah

---

# ⚙️ Fase 2 — DevOps Foundation

**Minggu 4–6**

### 🎯 Target

Memahami automation, version control, container, dan environment aplikasi sebagai fondasi sebelum masuk CI/CD.

### Task

- [ ] Bash Fundamentals
- [ ] Bash Scripting
- [ ] Python Dasar untuk Automation
- [ ] Git Fundamentals
- [ ] Git Branching & Workflow
- [ ] GitHub
- [ ] Docker Fundamentals
- [ ] Podman Fundamentals
- [ ] Dockerfile / Containerfile
- [ ] Image & Container
- [ ] Volume
- [ ] Network
- [ ] Environment Variables
- [ ] Docker/Podman Compose
- [ ] Multi-container Application
- [ ] Container Troubleshooting

### 📁 Dokumentasi

```text
catatan/fase-2-devops-foundation/
```

### 🧪 Praktik

```text
lab/fase-2/
```

### 🎯 Output Fase

Mampu menjalankan aplikasi menggunakan container dan membuat environment multi-container menggunakan Compose.

---

# ☁️ Fase 3 — Cloud & Infrastructure as Code

**Minggu 7–9**

### 🎯 Target

Memahami cloud infrastructure, IAM, provisioning, dan Infrastructure as Code.

### Task

- [ ] Cloud Computing Fundamentals
- [ ] AWS Fundamentals
- [ ] AWS Region & Availability Zone
- [ ] EC2
- [ ] VPC & Networking
- [ ] Security Group
- [ ] IAM
- [ ] Least Privilege
- [ ] Terraform Fundamentals
- [ ] Terraform Provider
- [ ] Resource
- [ ] Variable
- [ ] Output
- [ ] Terraform State
- [ ] Terraform Plan / Apply / Destroy
- [ ] Terraform Infrastructure
- [ ] Ansible Fundamentals
- [ ] Configuration Management

### 📁 Dokumentasi

```text
catatan/fase-3-cloud-iac/
```

### 🧪 Praktik

```text
lab/fase-3/
```

### 🎯 Output Fase

Mampu membuat dan mengelola infrastructure cloud secara reproducible menggunakan Terraform serta melakukan konfigurasi server menggunakan Ansible.

---

# ☸️ Fase 4 — Kubernetes & Container Security

**Minggu 10–13**

### 🎯 Target

Memahami container orchestration, deployment aplikasi, monitoring, dan dasar keamanan container.

### Task

- [ ] Kubernetes Fundamentals
- [ ] Pod
- [ ] Deployment
- [ ] Service
- [ ] Namespace
- [ ] ConfigMap
- [ ] Secret
- [ ] Volume
- [ ] Ingress
- [ ] Kubernetes Networking
- [ ] Application Deployment
- [ ] Kubernetes Troubleshooting
- [ ] Prometheus
- [ ] Grafana
- [ ] Metrics & Monitoring
- [ ] Container Security
- [ ] Image Vulnerability
- [ ] Trivy
- [ ] Non-root Container
- [ ] Minimal Container Image
- [ ] Container Permissions

### 📁 Dokumentasi

```text
catatan/fase-4-kubernetes-container-security/
```

### 🧪 Praktik

```text
lab/fase-4/
```

### 🎯 Output Fase

Mampu:

- menjalankan aplikasi di Kubernetes
- membuat Deployment dan Service
- menggunakan ConfigMap dan Secret
- menggunakan Ingress
- melakukan monitoring
- melakukan vulnerability scanning terhadap container image

---

# 🔐 Fase 5 — DevSecOps Pipeline

**Minggu 14–16**

### 🎯 Target

Mengintegrasikan security ke dalam proses development dan CI/CD.

### Task

- [ ] OWASP Top 10
- [ ] Application Security Fundamentals
- [ ] SAST
- [ ] Code Scanning
- [ ] SCA / Dependency Scanning
- [ ] Secret Scanning
- [ ] DAST
- [ ] OWASP ZAP
- [ ] Semgrep / CodeQL
- [ ] Trivy
- [ ] Security Gate
- [ ] Secure CI/CD
- [ ] Vulnerability Remediation
- [ ] Security Testing Automation

### 📁 Dokumentasi

```text
catatan/fase-5-devsecops-pipeline/
```

### 🧪 Praktik

```text
lab/fase-5/
```

### 🎯 Output Fase

Membuat pipeline yang menerapkan security checks sebelum aplikasi di-deploy.

```text
Developer
    ↓
Git Push
    ↓
CI
    ↓
Unit Test
    ↓
SAST
    ↓
Dependency Scan
    ↓
Secret Scan
    ↓
Build Container
    ↓
Container Scan
    ↓
DAST
    ↓
Security Gate
    ↓
Deploy
```

---

# 🛡️ Fase 6 — Advanced Security & Production

**Minggu 17**

### 🎯 Target

Menggabungkan seluruh kemampuan menjadi workflow yang mendekati environment production.

### Task

- [ ] Linux Security Review
- [ ] Network Security Review
- [ ] Cloud Security Fundamentals
- [ ] IAM Security
- [ ] Container Security Review
- [ ] Kubernetes Security Review
- [ ] Secure Configuration
- [ ] Secrets Management
- [ ] Logging
- [ ] Monitoring
- [ ] Alerting
- [ ] Vulnerability Management
- [ ] Basic Threat Modeling
- [ ] Security Automation
- [ ] Production Readiness Review

### 📁 Dokumentasi

```text
catatan/fase-6-advanced-security-production/
```

### 🧪 Praktik

```text
lab/fase-6/
```

### 🎯 Output Fase

Melakukan security review terhadap infrastructure dan application yang telah dibuat pada fase sebelumnya.

---

# 🚀 Project Portfolio

Project dibuat sebagai bukti implementasi dari setiap tahap pembelajaran.

## Project 1 — Secure Server

```text
proyek-1-secure-server/
```

Membangun server Linux yang:

- menggunakan SSH key
- menerapkan firewall
- menerapkan security hardening
- menggunakan Nginx reverse proxy
- menggunakan HTTPS
- memiliki logging dasar

---

## Project 2 — CI/CD Pipeline

```text
proyek-2-cicd-pipeline/
```

Membuat pipeline otomatis:

```text
GitHub
   ↓
GitHub Actions
   ↓
Test
   ↓
Build
   ↓
Container Registry
   ↓
Deploy
```

---

## Project 3 — IaC AWS

```text
proyek-3-iac-aws/
```

Membuat infrastructure menggunakan:

- AWS
- Terraform
- Ansible
- IAM
- Security Group
- Infrastructure as Code

Targetnya adalah membuat infrastructure yang dapat dibuat kembali tanpa konfigurasi manual dari awal.

---

## Project 4 — Kubernetes DevSecOps

```text
proyek-4-k8s-devsecops/
```

Project utama untuk portfolio.

Menggabungkan:

- Docker
- Kubernetes
- GitHub Actions
- SAST
- Dependency Scanning
- Secret Scanning
- Container Scanning
- DAST
- Security Gate
- Monitoring
- Deployment

Target pipeline:

```text
                    ┌── SAST
                    │
Git Push → CI/CD ───┼── Dependency Scan
                    │
                    ├── Secret Scan
                    │
                    ├── Container Scan
                    │
                    └── DAST
                         ↓
                   Security Gate
                         ↓
                    Kubernetes
                         ↓
                   Production
                         ↓
                 Monitoring
```

---

# 📂 Struktur Repository

```text
Perjalanan-DevSecOps/
│
├── README.md
├── .gitignore
│
├── catatan/
│   ├── fase-1-linux-networking-security/
│   ├── fase-2-devops-foundation/
│   ├── fase-3-cloud-iac/
│   ├── fase-4-kubernetes-container-security/
│   ├── fase-5-devsecops-pipeline/
│   └── fase-6-advanced-security-production/
│
├── lab/
│   ├── fase-1/
│   ├── fase-2/
│   ├── fase-3/
│   ├── fase-4/
│   ├── fase-5/
│   └── fase-6/
│
├── proyek-1-secure-server/
├── proyek-2-cicd-pipeline/
├── proyek-3-iac-aws/
└── proyek-4-k8s-devsecops/
```

### `catatan/`

Berisi **apa yang kupelajari**.

Contohnya:

```text
catatan/
└── fase-1-linux-networking-security/
    ├── linux-fundamentals.md
    ├── networking.md
    ├── ssh.md
    ├── nginx.md
    └── security-hardening.md
```

### `lab/`

Berisi **apa yang kupraktikkan**.

Contohnya:

```text
lab/
└── fase-1/
    ├── linux/
    ├── networking/
    ├── ssh/
    ├── nginx/
    └── firewall/
```

### `proyek-*`

Berisi **apa yang bisa kutunjukkan sebagai portfolio**.

Setiap project memiliki README sendiri yang menjelaskan:

```text
Problem
   ↓
Architecture
   ↓
Implementation
   ↓
Security
   ↓
Testing
   ↓
Deployment
   ↓
Result
```

---

# 📝 Format Catatan

Setiap catatan belajar menggunakan format yang konsisten:

```markdown
# Judul

## 🎯 Tujuan

## 📚 Yang Dipelajari

## 💻 Praktik

## 🧾 Perintah Penting

## ❌ Error

## 🔧 Solusi

## 🧠 Yang Saya Pahami

## ❓ Belum Paham

## 📌 Next
```

Catatan ditulis menggunakan **bahasa sendiri**, bukan menyalin dokumentasi atau tutorial.

---

# 🧪 Format Lab

Setiap lab minimal memiliki:

```text
lab/fase-x/nama-lab/
├── README.md
├── config/
├── scripts/
└── screenshots/
```

README lab menjelaskan:

- tujuan
- environment
- prerequisite
- langkah praktik
- command
- hasil
- error
- troubleshooting
- kesimpulan

---

# 📈 Cara Belajarku

1. Belajar sekitar **10–12 jam per minggu**.
2. Mengutamakan praktik daripada hanya membaca teori.
3. Setiap materi harus memiliki praktik atau lab.
4. Menulis catatan menggunakan kata-kata sendiri.
5. Mencatat error dan cara memperbaikinya.
6. Membuat commit kecil dan jelas.
7. Melakukan review setiap minggu.
8. Mengulang materi yang belum benar-benar dipahami.
9. Membuat project yang dapat dijalankan kembali.
10. Tidak memasukkan credential atau data sensitif ke repository.

---

# 🎯 Target Setelah 18 Minggu

Setelah menyelesaikan perjalanan ini, targetku adalah memiliki pemahaman praktis mengenai:

```text
Linux
Networking
SSH
Nginx
Security Hardening
Bash
Python Automation
Git
Docker / Podman
Compose
CI/CD
GitHub Actions
AWS
IAM
Terraform
Ansible
Kubernetes
Monitoring
Prometheus
Grafana
OWASP
SAST
DAST
SCA
Secret Scanning
Container Security
DevSecOps
```

---

# 💼 Target Karier

Saya tidak mengharuskan pekerjaan pertama saya memiliki title **DevSecOps Engineer**.

Setelah lulus, saya siap mempertimbangkan beberapa posisi yang relevan:

| Posisi                    | Relevansi  |
| ------------------------- | :--------: |
| Junior DevOps Engineer    | ⭐⭐⭐⭐⭐ |
| Junior DevSecOps Engineer | ⭐⭐⭐⭐⭐ |
| Junior Cloud Engineer     | ⭐⭐⭐⭐⭐ |
| Junior Security Engineer  |  ⭐⭐⭐⭐  |
| Infrastructure Engineer   |  ⭐⭐⭐⭐  |
| System Administrator      |   ⭐⭐⭐   |

Tujuan jangka panjang:

```text
Junior DevOps / Cloud / Security
              ↓
         DevSecOps
              ↓
     Security Engineering
              ↓
   Cloud / Application Security
```

---

# 🔒 Keamanan Repo

Repository ini tidak berisi:

- password
- API key
- access token
- private key
- credential
- data perusahaan
- data pribadi yang sensitif

File sensitif dikecualikan melalui `.gitignore`:

```text
.env
*.pem
*.key
*.tfstate
*.tfstate.*
```

Seluruh praktik cybersecurity dilakukan hanya pada:

- sistem milik sendiri
- environment lab
- CTF
- platform pembelajaran
- sistem yang secara eksplisit memberikan izin pengujian

---

# 📚 Sumber Belajar

- [roadmap.sh/devops](https://roadmap.sh/devops)
- Dokumentasi resmi Linux
- Dokumentasi resmi Docker
- Dokumentasi resmi Podman
- Dokumentasi resmi GitHub Actions
- Dokumentasi resmi AWS
- Dokumentasi resmi Terraform
- Dokumentasi resmi Ansible
- Dokumentasi resmi Kubernetes
- Dokumentasi resmi Prometheus
- Dokumentasi resmi Grafana
- OWASP
- PortSwigger Web Security Academy
- TryHackMe

---

# 📬 Kontak

- GitHub: [@rezzafairusnugraha](https://github.com/RezzaFairusNugraha)
- LinkedIn: [rezzafairusnugraha](https://www.linkedin.com/in/rezza-fairus-nugraha/)
- Email: rezzafairusnugraha@gmail.com
- TikTok: [@WhiteExploit](https://www.tiktok.com/@rezzafairusnugraha)

---

<div align="center">

**Belajar. Praktik. Dokumentasikan. Amankan. Buktikan lewat proyek.** ⚙️🔐

</div>
