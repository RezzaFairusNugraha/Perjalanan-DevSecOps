# Kunci Jawaban & Panduan Solusi Lab 2 (v2)

Gunakan panduan ini jika kamu ingin mencocokkan hasil kerjamu atau butuh referensi command saat mentok.

> Masuk ke mode root terlebih dahulu:
> ```bash
> sudo -i
> ```

---

### Solusi Task 1: Staging Storage & File Operations
```bash
# 1. Buat folder data dan conf
mkdir -p /opt/container-lab/app/data
mkdir -p /opt/container-lab/app/conf

# 2. Pindahkan app.conf
mv /tmp/staging-ex188/app.conf /opt/container-lab/app/conf/app.conf

# 3. Salin template default.env menjadi .env
cp /tmp/staging-ex188/default.env /opt/container-lab/app/conf/.env

# 4. Hapus folder staging lama
rm -rf /tmp/staging-ex188
```

---

### Solusi Task 2: Log Extraction & Analysis
```bash
# 1. Cari CRITICAL atau FATAL
grep -E "CRITICAL|FATAL" /opt/container-lab/logs/podman-service.log > /opt/container-lab/logs/alerts.txt

# 2. Cari semua baris dengan REMOTE_ADDR=
grep "REMOTE_ADDR=" /opt/container-lab/logs/podman-service.log > /opt/container-lab/logs/connections.txt

# 3. Ambil 5 baris terakhir
tail -n 5 /opt/container-lab/logs/podman-service.log > /opt/container-lab/logs/recent.txt
```

---

### Solusi Task 3: Bikin Custom `Containerfile` via `vi` / `vim`
1. Buka file:
   ```bash
   vi /opt/container-lab/Containerfile
   ```
2. Tekan `i` lalu isi persis:
   ```dockerfile
   FROM registry.access.redhat.com/ubi9/ubi-minimal:latest
   LABEL maintainer="student@ex188.lab"
   WORKDIR /app
   USER 1001
   EXPOSE 8080
   CMD ["python3", "-m", "http.server", "8080"]
   ```
3. Tekan `Esc` lalu ketik `:wq` dan tekan `Enter`.

---

### Solusi Task 4: Manajemen User & SubUID
```bash
# 1. Buat grup engineers
groupadd engineers

# 2. Buat user apprunner dengan UID 1024 dan grup engineers
useradd -u 1024 -G engineers apprunner

# 3. Simpan output id
id apprunner > /opt/container-lab/logs/apprunner-info.txt
```

---

### Solusi Task 5: Izin Khusus Keamanan (SGID & Sticky Bit)
```bash
# 1. Buat direktori
mkdir -p /opt/container-lab/shared-workspace
mkdir -p /opt/container-lab/public-drop

# 2. Ubah grup shared-workspace ke engineers
chown :engineers /opt/container-lab/shared-workspace

# 3. Pasang SGID (2770)
chmod 2770 /opt/container-lab/shared-workspace

# 4. Pasang Sticky Bit (1777)
chmod 1777 /opt/container-lab/public-drop
```

---

### Tes Penilaian:
```bash
bash grade-lab.sh
```
Target: **`FINAL SCORE: 5 / 5`** 🎉
