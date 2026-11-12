# 💼 Roadmap Karier DevSecOps

Roadmap ini disusun dari target di README: **Junior DevOps / Cloud / DevSecOps**, dengan tujuan jangka panjang **Security Engineering**.

> Urutan sertifikasi dan perkiraan waktu di bawah adalah **saran**, bukan aturan. Sesuaikan dengan kondisi dan biaya. Cek syarat dan harga terbaru di situs resmi masing-masing penyelenggara.

## Gambaran besar

```text
Sekarang            EX188 + DevOps Foundation
   ↓
Feb 2027            Lulus SMK, portofolio siap, mulai melamar
   ↓
2027                Junior DevOps / Cloud / SysAdmin
   ↓
2027–2028           Kubernetes + Cloud + sertifikasi lanjutan
   ↓
2028–2029           DevSecOps Engineer
   ↓
2029+               Security Engineering / Cloud & Application Security
```

## Tahap 1: Fondasi (sekarang – Feb 2027)

**Fokus:** menyelesaikan 18 minggu di README dan lulus EX188.

| Target | Bukti |
|---|---|
| Lulus **EX188** | Sertifikat Red Hat |
| Selesai Fase 1–6 | Catatan dan lab di repo |
| 4 proyek portofolio | `proyek-1` sampai `proyek-4` |
| Aktif di TryHackMe | Learning path Pre Security dan DevSecOps |

**Catatan penting untuk persiapan EX188:**
- VM Anda memakai **Rocky Linux 9**. Itu biasanya membawa Podman 4.x, bukan Podman 5. Cek dengan `podman --version`.
- Ujian V5 memakai RHEL 10 dan Podman 5. Perbedaan yang paling terasa: `podman compose`, Quadlet, dan jaringan rootless (`pasta`).
- Kalau memungkinkan, siapkan VM RHEL 10 atau distro dengan Podman 5 untuk latihan terakhir sebelum ujian.

## Tahap 2: Pekerjaan pertama (Feb – Agu 2027)

**Posisi yang dibidik:**

| Posisi | Alasan |
|---|---|
| Junior DevOps Engineer | Paling cocok dengan proyek Anda |
| Junior Cloud / Infrastructure Engineer | Cocok dengan fase Cloud dan IaC |
| System Administrator | Pintu masuk umum, banyak lowongan |
| Junior Security Engineer | Cocok dengan latar TryHackMe |

**Yang dikerjakan:**
1. Rapikan GitHub: README tiap proyek berisi masalah, arsitektur, hasil, dan screenshot.
2. Siapkan CV satu halaman. Tulis proyek dan sertifikat (EX188, Dicoding), bukan hanya daftar alat.
3. Lamar magang atau posisi junior. Manfaatkan relasi dari tempat PKL.
4. Siapkan jawaban untuk pertanyaan wawancara umum: Linux, jaringan, Git, Docker/Podman, CI/CD, dan dasar keamanan.

## Tahap 3: Pendalaman (2027)

Pilih urutan berikut, satu sertifikasi pada satu waktu.

| Urutan | Sertifikasi | Manfaat |
|---|---|---|
| 1 | **RHCSA (EX200)** | Fondasi Linux, sering dicari untuk peran infrastruktur |
| 2 | **CKA** (Kubernetes Administrator) | Bukti kemampuan Kubernetes secara praktik |
| 3 | **AWS Solutions Architect Associate** atau Cloud Practitioner dulu | Bukti kemampuan cloud |
| Opsional | **CKAD** | Lebih ke sisi developer di Kubernetes |

Sertifikasi Red Hat dan Kubernetes sama-sama berbasis praktik, jadi lab di repo ini cocok sebagai latihan.

## Tahap 4: Spesialisasi DevSecOps (2028)

| Bidang | Sertifikasi atau keterampilan |
|---|---|
| Keamanan Kubernetes | **CKS** (butuh CKA aktif) |
| Keamanan cloud | AWS Security Specialty |
| Dasar keamanan | CompTIA Security+ |
| Keamanan aplikasi | OWASP, SAST, DAST, SCA, secret scanning (sudah ada di Fase 5) |
| Praktik | Kontribusi ke proyek open source, atau bug bounty yang legal dan berizin |

## Tahap 5: Jalur jangka panjang (2029+)

Pilih salah satu arah setelah punya pengalaman kerja:

| Arah | Fokus |
|---|---|
| **Cloud / Application Security** | Review keamanan, threat modeling, secure SDLC |
| **Platform / SRE** | Keandalan, observability, otomasi skala besar |
| **Security Engineering** | Membangun alat dan pipeline keamanan |
| **Architect** | Desain sistem aman. Sertifikasi Red Hat lanjutan (RHCA) bisa jadi tujuan |

## Peta keterampilan

```text
Linux ─ Networking ─ Git ─ Bash/Python
              ↓
     Container (Podman/Docker) ─ CI/CD
              ↓
      Cloud (AWS) ─ IaC (Terraform/Ansible)
              ↓
          Kubernetes
              ↓
   Security: SAST/DAST/SCA/Container scan
              ↓
       DevSecOps / Security Engineering
```

## Kebiasaan yang menentukan

1. **Praktik lebih penting dari sertifikat.** Sertifikat membuka pintu, proyek membuktikan kemampuan.
2. **Dokumentasikan error dan solusinya.** Itu yang ditanyakan saat wawancara.
3. **Konsisten:** 10–12 jam per minggu lebih baik daripada belajar maraton sesekali.
4. **Satu sertifikasi pada satu waktu.** Jangan menumpuk jadwal ujian.
5. **Bangun jejaring:** komunitas lokal, LinkedIn, dan konten edukasi Anda (@WhiteExploit) menjadi nilai tambah.
6. **Jaga etika:** latihan keamanan hanya di sistem milik sendiri, lab, CTF, atau yang berizin.

## Checklist bulanan

- [ ] Satu catatan dan satu lab baru di repo
- [ ] Satu commit kecil per hari belajar
- [ ] Review mingguan: apa yang belum paham
- [ ] Perbarui README proyek dan CV
- [ ] Cek lowongan: catat keterampilan yang paling sering diminta, lalu sesuaikan rencana belajar
