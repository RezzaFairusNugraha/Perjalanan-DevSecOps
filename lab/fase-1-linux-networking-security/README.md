# 🧪 Direktori Praktik & Hands-On Lab (Fase 1: Linux, Networking & Security)

Struktur folder di dalam direktori `lab/fase-1-linux-networking-security/` telah distandarisasi secara rapi berdasarkan modul dan tingkat kemahiran:

---

## 📂 Struktur Lab:

```text
lab/fase-1-linux-networking-security/
│
├── lab-1-filesystem-permissions-links/
│   ├── README.md               # Panduan tugas Lab 1 (Path, mkdir, chmod numerik, >, tee, ln hard/soft)
│   ├── setup-lab.sh            # Skrip otomatisasi inisialisasi lingkungan Lab 1
│   └── grade-lab.sh            # Skrip auto-grader penilaian otomatis Lab 1
│
├── lab-2-container-prep-users-grep-vim/
│   ├── README.md               # Panduan tugas Lab 2 v2 (EX188 Prep: grep regex, vi/vim, User SubUID, SGID 2770, Sticky 1777)
│   ├── SOLUTION.md             # Kunci jawaban & panduan command lengkap Lab 2
│   ├── setup-lab.sh            # Skrip reset & persiapan staging Lab 2
│   └── grade-lab.sh            # Skrip auto-grader penilaian otomatis Lab 2
│
└── README.md                   # Panduan indeks seluruh lab Fase 1
```

---

## 🚀 Cara Menjalankan Lab:

### 1. Menjalankan Lab 1 (Dasar File, Hak Akses & Links):
```bash
cd lab/fase-1-linux-networking-security/lab-1-filesystem-permissions-links
bash setup-lab.sh
# Kerjakan tugas sesuai README.md
bash grade-lab.sh
```

### 2. Menjalankan Lab 2 (Persiapan Container EX188, Users, vi/vim & Special Permissions):
```bash
cd lab/fase-1-linux-networking-security/lab-2-container-prep-users-grep-vim
sudo bash setup-lab.sh
# Kerjakan tugas sesuai README.md
sudo bash grade-lab.sh
```
