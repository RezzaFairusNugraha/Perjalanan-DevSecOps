# Exercise 03 — Manage Images & Registries

**Objective:** tags, many registries, private registry security, push/pull, backup image vs container.

## Tasks

1. Cari image: `podman search --limit 5 ubi9`; `skopeo inspect docker://registry.access.redhat.com/ubi9/ubi`;
   `skopeo list-tags docker://quay.io/libpod/alpine`.
2. Lihat daftar registry yang dipakai: `podman info --format '{{.Registries}}'` dan baca
   `/etc/containers/registries.conf` (`unqualified-search-registries`, `[[registry]]`, `insecure`).
3. Tag & push image `webapp:v1` (dari Exercise 02) ke registry lokal:
   `podman tag ...:v1 localhost:5000/webapp:latest` lalu `podman push --tls-verify=false` kedua tag.
4. Hapus image lokal, `podman pull` kembali dari registry; konfirmasi `podman images --digests`.
5. **Private registry**: jalankan registry kedua `secure-registry` di port 5001 dengan htpasswd auth
   (`htpasswd -Bbn student redhat > ~/ex188-data/auth/htpasswd`, env `REGISTRY_AUTH=htpasswd`,
   `REGISTRY_AUTH_HTPASSWD_REALM`, `REGISTRY_AUTH_HTPASSWD_PATH`).
   - `podman login --tls-verify=false localhost:5001 -u student -p redhat`
   - Lihat credential di `${XDG_RUNTIME_DIR}/containers/auth.json`; `podman logout`.
   - Jadikan insecure permanen lewat `/etc/containers/registries.conf.d/99-lab.conf`
     (butuh root: `sudo`).
6. `skopeo copy --dest-tls-verify=false docker://quay.io/libpod/alpine:latest docker://localhost:5000/alpine:copy`.
7. **Backup image (layers + metadata)**: `podman save -o /tmp/webapp.tar localhost:5000/webapp:v1`,
   `podman rmi`, `podman load -i /tmp/webapp.tar`. Format lain: `--format oci-archive`.
8. **Backup state container**: `podman export -o /tmp/web1-fs.tar web1`,
   `podman import /tmp/web1-fs.tar localhost:5000/webapp-imported:v1`. Jelaskan: export hanya filesystem
   (tanpa layer, ENV, CMD, USER) kecuali `--change 'CMD ...'`. Alternatif: `podman commit`.
9. Bandingkan hasil `podman history` & `podman image inspect` antara image `save/load` dan `import`.
10. Hapus: `podman rmi`, `podman image prune -a`, `podman image tree`.

## Verifikasi
`skopeo list-tags --tls-verify=false docker://localhost:5000/webapp` → `v1`, `latest`.
