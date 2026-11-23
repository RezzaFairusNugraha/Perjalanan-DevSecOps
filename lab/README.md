# 🧪 Direktori Hands-On Labs (Praktik Mandiri)

Folder `lab/` berisi seluruh kode skrip setup, skrip pengujian otomatis (*auto-grader*), skenario simulasi, dan dokumentasi praktik langsung untuk setiap fase pembelajaran DevSecOps.

---

## 📂 Struktur Direktori Lab:

```text
lab/
│
├── fase-1-linux-networking-security/
│   ├── README.md                                  # Indeks panduan seluruh lab di Fase 1
│   ├── lab-1-filesystem-permissions-links/        # Lab 1: Filesystem, I/O Redirection, chmod, ln
│   ├── lab-2-container-prep-users-grep-vim/       # Lab 2: EX188 Prep, grep, vi/vim, User SubUID, SGID/Sticky
│   ├── lab-3-systemd-processes-logs-env/          # Lab 3: Systemd enable --now, ps/kill -9, journalctl, df/free, Env Vars
│   └── lab-4-networking-ssh-dnf-firewalld/        # Lab 4: dnf/rpm, ss -tulpn, curl, SSH Keys, scp, firewalld & direct rules
│
├── fase-2-devops-foundation/
│   └── ex188-podman-exercises-01-03/              # Lab Podman Lifecycle, Custom Image UBI9, & Storage SELinux (:Z)
│
├── fase-3-cloud-iac/                              # (Upcoming: Lab AWS Terraform & Ansible)
├── fase-4-kubernetes-container-security/          # (Upcoming: Lab K8s Pods, Ingress & Trivy)
├── fase-5-devsecops-pipeline/                     # (Upcoming: Lab Secure CI/CD SAST/DAST)
└── fase-6-advanced-security-production/           # (Upcoming: Lab Production Security Hardening)
```

---

## 🛠️ Standar Format di Setiap Lab:
Setiap folder lab minimal memiliki:
1. **`README.md`**: Menjelaskan tujuan lab, prasyarat, deskripsi task/tugas secara bertahap, dan kriteria kelulusan.
2. **`setup-lab.sh`**: Skrip otomatis untuk me-reset lingkungan lab agar bersih dan siap digunakan.
3. **`grade-lab.sh`**: Skrip *auto-grader* otomatis yang memeriksa hasil pekerjaanmu dan memberikan skor `PASS / FAIL`.
4. **`SOLUTION.md`** *(Opsional/Rekomendasi)*: Kunci jawaban dan penjelasan teknis perintah yang digunakan.
