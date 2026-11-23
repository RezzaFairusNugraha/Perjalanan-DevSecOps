# Solutions & Command Reference for Lab 4

Use this guide if you want to verify your commands or get stuck while working on **Lab 4**.

> Switch to root before running the commands:
> ```bash
> sudo -i
> ```

---

### Solution for Task 1: Package Management (`dnf` & `rpm`)
```bash
# 1. Install bind-utils (provides host, dig, nslookup)
dnf install -y bind-utils

# 2. Query installed firewalld RPM version and save to report
rpm -q firewalld > /opt/ex188-lab4/reports/rpm-firewalld.txt
```

---

### Solution for Task 2: Inspect Listening Ports (`ss`) & Test Web Endpoint (`curl`)
```bash
# 1. Find the process listening on TCP port 8091 and save output
ss -tulpn | grep 8091 > /opt/ex188-lab4/reports/port-8091.txt

# 2. Test the local HTTP microservice with curl and save response
curl -s http://127.0.0.1:8091/index.html > /opt/ex188-lab4/reports/curl-response.txt
```

---

### Solution for Task 3: Passwordless SSH Keys & Secure Copy (`scp`)
```bash
# 1. Generate Ed25519 SSH key pair without passphrase
ssh-keygen -t ed25519 -N "" -f /opt/ex188-lab4/ssh/id_ex188

# 2. Authorize the public key for root@127.0.0.1
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cat /opt/ex188-lab4/ssh/id_ex188.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# 3. Copy the staged payload using scp with the private key
scp -i /opt/ex188-lab4/ssh/id_ex188 -o StrictHostKeyChecking=no \
  /opt/ex188-lab4/staging/secret-payload.conf \
  root@127.0.0.1:/opt/ex188-lab4/deployed-payload.conf
```

---

### Solution for Task 4: Open Container Ports with `firewalld` (`firewall-cmd`)
```bash
# 1. Ensure firewalld is unmasked and running
systemctl unmask firewalld
systemctl enable --now firewalld

# 2. Permanently open TCP port 8091 and http service
firewall-cmd --add-port=8091/tcp --permanent
firewall-cmd --add-service=http --permanent

# 3. Reload firewalld to activate permanent rules
firewall-cmd --reload

# 4. Save firewall status
firewall-cmd --list-all > /opt/ex188-lab4/reports/firewall-status.txt
```

---

### Solution for Task 5: Outbound IP Blocking with `firewalld` Direct Rules
```bash
# 1. Add runtime direct rule to DROP outbound packets to 198.51.100.99
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 0 -d 198.51.100.99 -j DROP

# 2. Save active direct rules
firewall-cmd --direct --get-all-rules > /opt/ex188-lab4/reports/direct-rules.txt
```

---

### Run Auto-Grader:
```bash
sudo bash grade-lab.sh
```
Expected result: **`FINAL SCORE: 5 / 5`** 🎉
