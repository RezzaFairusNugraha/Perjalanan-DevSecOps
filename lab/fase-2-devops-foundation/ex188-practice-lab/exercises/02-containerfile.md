# Exercise 02 — Containerfile

**Objective:** base image, add content, USER/WORKDIR/RUN, EXPOSE, ARG/ENV, CMD/ENTRYPOINT, VOLUME.

## Tasks

1. Buat direktori `~/exam-work/webapp` berisi `app.py`:
   ```python
   import os, http.server, socketserver
   PORT = int(os.environ.get("APP_PORT", "8080"))
   class H(http.server.SimpleHTTPRequestHandler):
       def do_GET(self):
           self.send_response(200); self.end_headers()
           self.wfile.write(f"Hello from {os.environ.get('APP_MSG','default')}\n".encode())
   socketserver.TCPServer(("", PORT), H).serve_forever()
   ```
2. Tulis `Containerfile`:
   - `FROM registry.access.redhat.com/ubi9/ubi-minimal:latest`
   - `LABEL maintainer="student@example.com"`
   - `ARG APP_VERSION=1.0` dan `ENV APP_MSG="EX188" APP_PORT=8080`
   - `RUN microdnf install -y python3 && microdnf clean all`
   - `WORKDIR /app`, `COPY app.py .`
   - `VOLUME /data`
   - `EXPOSE 8080`
   - `USER 1001`
   - `ENTRYPOINT ["python3"]` dan `CMD ["app.py"]`
3. Build: `podman build -t localhost:5000/webapp:v1 --build-arg APP_VERSION=1.1 .`
4. Jalankan: `podman run -d --name web1 -p 8081:8080 localhost:5000/webapp:v1`; `curl 127.0.0.1:8081`.
5. Override ENV runtime: `-e APP_MSG=Override`; override CMD (`... app.py` vs `-c 'print(1)'`)
   dan ENTRYPOINT (`--entrypoint /bin/sh`).
6. Buktikan user non-root: `podman exec web1 id` → `uid=1001`. Cek `podman image inspect` untuk
   `User`, `WorkingDir`, `ExposedPorts`, `Entrypoint`, `Cmd`, `Volumes`.
7. Lihat layer: `podman history localhost:5000/webapp:v1`.
8. Multi-stage (bonus): stage `builder` menyalin file, stage akhir `ubi9/ubi-minimal`
   dengan `COPY --from=builder`.
9. Perbedaan **ARG vs ENV**: ARG hanya saat build; ENV ikut ke runtime. Verifikasi dengan `podman run --rm IMAGE env`.

## Verifikasi
`podman run --rm localhost:5000/webapp:v1 id -u` → `1001`; `curl` menampilkan `Hello from EX188`.
