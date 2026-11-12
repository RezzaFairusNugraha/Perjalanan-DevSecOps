# EX188 Practice Lab — Red Hat Certified Developer in Cloud-native Applications

Lab latihan tidak resmi untuk ujian **EX188** (hands-on, 2,5 jam). Berbasis **RHEL 10 + Podman v5**
(isi tetap berlaku untuk Podman 4.x/5.x dan OpenShift 4.x). Bukan produk resmi Red Hat.

> Catatan: nama sertifikasi saat ini adalah *Red Hat Certified Developer in Cloud-native Applications*
> (sebelumnya disebut "Specialist in Containers"). Ujian **tidak** memakai pilihan ganda: kamu
> mengerjakan task di sistem live, dinilai dari hasil akhir.

## Pemetaan Objective Resmi → Exercise

| Objective resmi | Exercise |
|---|---|
| Run containers locally (logs, events, inspect, env, expose ports, exec) | [01](exercises/01-containers.md) |
| Implement images with Podman & Containerfile (FROM, COPY, USER, WORKDIR, RUN, EXPOSE, ARG/ENV, CMD/ENTRYPOINT, VOLUME) | [02](exercises/02-containerfile.md) |
| Manage images (tags, registries, private registry security, push/pull, save/load vs export/import) | [03](exercises/03-image-management.md) |
| Container volumes, host data sharing, security & permissions (SELinux, rootless, caps) | [04](exercises/04-storage-security.md) |
| Multi-container apps (compose, dependencies, env, secrets, volumes, config, pods/kube play) | [05](exercises/05-multi-container.md) |
| Persist after reboot (*Performance Rule*): Quadlet + systemd | [06](exercises/06-quadlet-persistence.md) |
| Troubleshoot containerized apps (logs, inspect, exec, resources) | [07](exercises/07-troubleshooting.md) |
| Semua objective, gaya ujian | [mock-exam.md](mock-exam.md) |

## Persiapan

- RHEL 10 / Rocky / Alma / Fedora, **Podman ≥ 5**, `skopeo`, `buildah` (opsional), `podman-compose`
  atau `docker-compose` (untuk `podman compose`).
- Jalankan sebagai **user biasa (rootless)** — seperti di ujian.

```bash
./lab-setup.sh        # pull image, start registry lokal :5000, buat data dir
./grade-lab.sh        # menu penilaian per exercise
./lab-clean.sh        # reset total
```

## Tips Ujian (Podman 5)

- Dokumentasi resmi tersedia saat ujian: `man podman-run`, `man podman-build`, `man containers-registries.conf`,
  `man podman-systemd.unit` (Quadlet). Latih pencarian cepat dengan `man -k` / `/keyword`.
- **Performance rule**: layanan harus hidup lagi setelah reboot tanpa intervensi → Quadlet di
  `~/.config/containers/systemd/` + `loginctl enable-linger <user>`.
- `podman generate systemd` sudah **deprecated**; gunakan Quadlet. `podman generate kube`/`play kube`
  kini `podman kube generate` / `podman kube play`.
- SELinux: bind mount butuh `:Z` (privat) / `:z` (shared). Rootless tidak bisa bind port < 1024
  (kecuali `net.ipv4.ip_unprivileged_port_start`).
- Rootless v5 memakai **pasta** (bukan slirp4netns) dan **netavark**; IP container rootless di
  `.NetworkSettings.Networks.<net>.IPAddress`, bukan `.NetworkSettings.IPAddress`.
- Registry tanpa TLS: `--tls-verify=false` atau tambahkan di `registries.conf.d/*.conf` dengan `insecure = true`.
- Selalu verifikasi akhir: `podman ps -a`, `curl`, `podman logs`, lalu **reboot test** bila diminta persisten.

*Disclaimer: Red Hat dan EX188 adalah merek dagang Red Hat, Inc.*
