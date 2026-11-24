# Catatan Belajar Linux di Udemy & Lab Praktik — 23 November 2026: Networking, SSH Keys, `ss`, `curl`, `scp`, `dnf`/`rpm`, `firewalld` & SSL/TLS

## 🎯 Tujuan

Mendokumentasikan penyelesaian materi **Module 7 (Bagian 4 Wajib EX188)** pada kursus Linux Fundamentals di **Udemy** (video No. 147, 153–157, 160, 164, dan 187) beserta eksperimen *troubleshooting* langsung di VM Rocky Linux / AlmaLinux dan Ubuntu Server:
- **No. 147:** Konektivitas internet dan DNS di Linux VM.
- **No. 153, 154, 155:** **SSH, SSH Hardening & SSH-Keys** (`ssh-keygen`, `authorized_keys`, login tanpa password).
- **No. 156:** **`ss` command (`ss -tulpn`)** untuk mengaudit port TCP/UDP yang sedang terbuka dan mendeteksi konflik port.
- **No. 157:** **`curl` & `ping`** untuk menguji endpoint HTTP/HTTPS dan konektivitas jaringan.
- **No. 160:** **`scp` (Secure Copy Protocol)** untuk menyalin file antar server melalui jalur terenkripsi SSH.
- **No. 164:** **Package Management (`rpm`, `yum` / `dnf`)** untuk menginstal paket (`bind-utils`, `httpd`) dan digunakan di dalam `Containerfile`.
- **No. 187:** **Firewall (`firewalld` vs `iptables`/`nftables`)** untuk membuka port container (`--add-port`, `--add-service`) maupun memblokir trafik keluar (`--direct --add-rule`).

---

## 📚 Rangkuman Materi & Perintah Penting

### 1. Inspeksi Port & Troubleshooting Koneksi (`ss`, `curl`, `ping`, `host`)
- **`ss -tulpn`:** Perintah wajib untuk melihat port mana saja yang sedang *listening* beserta nama proses dan PID-nya:
  ```bash
  # Melihat semua port TCP/UDP yang sedang aktif
  ss -tulpn

  # Mencari siapa yang memakai port 80 atau 8080
  ss -tulpn | grep :80
  ```
- **`curl` & `ping`:**
  ```bash
  # Menguji web server atau container lokal
  curl http://localhost:8080
  curl -I https://example.com        # Hanya mengambil HTTP Header
  curl -k https://localhost          # Mengabaikan validasi SSL self-signed
  ```
- **DNS Lookup (`bind-utils` di RHEL/Rocky):**
  Perintah `host`, `dig`, dan `nslookup` tersedia di dalam paket **`bind-utils`**:
  ```bash
  dnf install -y bind-utils
  host -t a wpucourse.id
  dig wpucourse.id
  ```

### 2. SSH, Passwordless SSH-Keys & `scp`
- **Membuat SSH Key Pair:**
  ```bash
  ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
  ```
- **Mengirim Public Key ke Server Target:**
  ```bash
  ssh-copy-id user@ip-server
  # Permission wajib: ~/.ssh (700) dan ~/.ssh/authorized_keys (600)
  ```
- **Menyalin File Antar Server dengan `scp`:**
  ```bash
  # Menyalin file lokal ke server remote
  scp -i ~/.ssh/id_ed25519 config.conf user@ip-server:/opt/app/

  # Menyalin folder secara rekursif (-r) dengan port custom (-P)
  scp -P 2222 -r ./folder user@127.0.0.1:/tmp/
  ```

### 3. Package Management (`dnf` / `yum` & `rpm`)
Digunakan baik di host RHEL/Rocky maupun di dalam instruksi `RUN dnf install -y ...` pada `Containerfile` UBI9:
```bash
# Mencari paket mana yang menyediakan command tertentu (contoh: host)
dnf provides */host

# Install & update paket
dnf install -y bind-utils httpd
dnf update -y

# Mengecek versi paket RPM yang terinstal
rpm -q firewalld
rpm -qa | grep podman
```

### 4. Firewall di Linux Modern (`firewalld` vs `iptables`)
- Di RHEL 8/9/10, Rocky Linux, dan AlmaLinux, standar resmi firewall adalah **`firewalld` (`firewall-cmd`)** yang berjalan di atas mesin kernel **`nftables`** (sedangkan paket `iptables-nft` hanya disediakan untuk kompatibilitas command lama).
- **Perintah Utama `firewall-cmd`:**
  ```bash
  # Membuka kunci jika service firewalld terkena mask
  systemctl unmask firewalld
  systemctl enable --now firewalld

  # Melihat aturan zone aktif
  firewall-cmd --list-all

  # Membuka port container (misal 8080/tcp) dan service http secara permanen
  firewall-cmd --add-port=8080/tcp --permanent
  firewall-cmd --add-service=http --permanent
  firewall-cmd --reload
  ```
- **Memblokir IP Tujuan Tertentu (Outbound Traffic Filtering via `--direct`):**
  ```bash
  # Membuang (DROP) semua paket keluar menuju IP tertentu
  firewall-cmd --direct --add-rule ipv4 filter OUTPUT 0 -d 104.21.4.181 -j DROP

  # Melihat aturan direct yang sedang aktif
  firewall-cmd --direct --get-all-rules
  ```

---

## 🔧 Catatan Troubleshooting Nyata Hari Ini

1. **`bash: /etc/sysconfig/iptables: Permission denied` saat pakai `sudo` dan `>`:**
   - **Penyebab:** Redirection `>` dieksekusi oleh shell user biasa jika berada di luar tanda kutip `sudo sh -c "..."`.
   - **Solusi:** Masukkan `>` ke dalam tanda kutip: `sudo sh -c "iptables-save > /etc/sysconfig/iptables"` atau gunakan `sudo tee`.
2. **`Failed to start firewalld.service: Unit firewalld.service is masked`:**
   - **Penyebab:** Unit `firewalld` dikunci ke `/dev/null` (*masked*) agar tidak bentrok saat `iptables` diuji.
   - **Solusi:** Jalankan `sudo systemctl unmask firewalld` lalu `sudo systemctl enable --now firewalld`.
3. **Perbedaan Apache di RHEL (`httpd`) vs Ubuntu (`apache2`) & Error `(98)Address already in use`:**
   - Di RHEL/Rocky paketnya bernama **`httpd`**, sedangkan di Ubuntu bernama **`apache2`**.
   - Ketika `apache2` gagal start dengan error `(98)Address already in use: make_sock: could not bind to address [::]:80`, artinya Port 80 sudah dipakai service lain (seperti `nginx`), yang langsung terdeteksi dengan `ss -tulpn | grep :80`.
4. **Simulasi Lokal SSL/TLS (HTTPS Port 443) & `curl: (60) SSL: no alternative certificate subject name matches`:**
   - Berhasil membuat sertifikat SSL *self-signed* lengkap dengan ekstensi **SAN (`subjectAltName=DNS:wpucourse.id`)** menggunakan `openssl req -x509` dan mendaftarkannya ke Trusted CA sistem (`update-ca-certificates`) sehingga `curl https://...` berjalan mulus tanpa error verifikasi SSL.
5. **SSH Key `-i` Error (`Load key "/root/.ssh/authorized_keys": invalid format`) & Strict Permissions (`chmod 600`):**
   - **Penyebab:** Memasukkan `/root/.ssh/authorized_keys` (Public Key / Gembok) ke opsi `-i` pada `scp`/`ssh`, padahal `-i` wajib diisi **Private Key** (Kunci, misalnya `/opt/ex188-capstone/id_capstone` tanpa `.pub`).
   - **Aturan Permission Wajib SSH:** Folder `~/.ssh` (`chmod 700`), Private Key (`chmod 600`), dan `~/.ssh/authorized_keys` (`chmod 600`).

---

## 🧪 Hands-On Lab 4 & Lab 5 (Grand Capstone)

- **Lab 4 (Networking, SSH, `scp`, `dnf`/`rpm`, `firewalld`):** [`lab/fase-1-linux-networking-security/lab-4-networking-ssh-dnf-firewalld/`](../../../lab/fase-1-linux-networking-security/lab-4-networking-ssh-dnf-firewalld/README.md)
- **Lab 5 (Grand Capstone EX188 — Sections 1–5 All-in-One):** [`lab/fase-1-linux-networking-security/lab-5-grand-capstone-ex188-all-in-one/`](../../../lab/fase-1-linux-networking-security/lab-5-grand-capstone-ex188-all-in-one/README.md)
  - **Hasil Sementara:** **PASSED 4 / 5** (Seluruh **Bagian 1, 2, 3, dan 4** berhasil lulus auto-grader!).
  - **Sisa Target:** Menyelesaikan **Bagian 5** (Udemy No. 191 `podman` & No. 281 `SELinux`) untuk menyempurnakan skor menjadi **5 / 5**.
