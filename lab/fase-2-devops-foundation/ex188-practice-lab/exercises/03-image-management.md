# Exercise 03: Images and Registries

**Objectives:** use many registries, tags, push and pull, private registry security, back up an image vs a container.

**Time:** 35 minutes. Requires the `webapp:v1` image from Exercise 02.

## Task 1: Search and inspect remote images

```bash
podman search --limit 5 ubi9
skopeo inspect docker://registry.access.redhat.com/ubi9/ubi
skopeo list-tags docker://quay.io/libpod/alpine
```

## Task 2: Know your registry configuration

```bash
podman info --format '{{.Registries}}'
cat /etc/containers/registries.conf
ls /etc/containers/registries.conf.d/
```

Look for `unqualified-search-registries` and `[[registry]]` blocks with `insecure`.

> Tip: always use the full image name (`registry/namespace/image:tag`) to avoid ambiguity.

## Task 3: Tag and push

```bash
podman tag localhost:5000/webapp:v1 localhost:5000/webapp:latest
podman push --tls-verify=false localhost:5000/webapp:v1
podman push --tls-verify=false localhost:5000/webapp:latest
skopeo list-tags --tls-verify=false docker://localhost:5000/webapp
```

**Expected:** the tag list contains `v1` and `latest`.

## Task 4: Remove and pull again

```bash
podman rmi localhost:5000/webapp:v1 localhost:5000/webapp:latest
podman pull --tls-verify=false localhost:5000/webapp:v1
podman images --digests
```

## Task 5: Private registry with authentication

Start a second registry on port 5001 that requires a password.

```bash
mkdir -p ~/ex188-data/auth
podman run --rm docker.io/library/httpd:2 htpasswd -Bbn student redhat > ~/ex188-data/auth/htpasswd
podman run -d --name secure-registry -p 5001:5000 \
  -v ~/ex188-data/auth:/auth:Z \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM=Registry \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  docker.io/library/registry:2
```

Log in, push, and look at the stored credentials:

```bash
podman login --tls-verify=false localhost:5001 -u student -p redhat
podman tag localhost:5000/webapp:v1 localhost:5001/webapp:v1
podman push --tls-verify=false localhost:5001/webapp:v1
cat ${XDG_RUNTIME_DIR}/containers/auth.json
podman logout localhost:5001
```

Make the registry insecure permanently (needs root):

```bash
sudo tee /etc/containers/registries.conf.d/99-lab.conf <<'EOF'
[[registry]]
location = "localhost:5001"
insecure = true
EOF
```

## Task 6: Copy between registries with skopeo

```bash
skopeo copy --dest-tls-verify=false \
  docker://quay.io/libpod/alpine:latest docker://localhost:5000/alpine:copy
```

## Task 7: Back up an image (layers and metadata)

```bash
podman save -o /tmp/webapp.tar localhost:5000/webapp:v1
podman rmi localhost:5000/webapp:v1
podman load -i /tmp/webapp.tar
```

Use `--format oci-archive` for the OCI format.

## Task 8: Back up a container (filesystem only)

```bash
podman export -o /tmp/web1-fs.tar web1
podman import /tmp/web1-fs.tar localhost:5000/webapp-imported:v1
```

## Task 9: Compare the two backups

| | `save` / `load` | `export` / `import` |
|---|---|---|
| Works on | Images | Containers |
| Keeps layers | Yes | No (flattened to one layer) |
| Keeps metadata (ENV, CMD, USER, ports) | Yes | No |
| Keeps tags | Yes | No (you name it on import) |

To keep metadata on import: `podman import --change 'CMD ["python3","app.py"]' ...`.
To capture a container as an image with layers: `podman commit web1 localhost:5000/webapp:snapshot`.

```bash
podman history localhost:5000/webapp:v1
podman history localhost:5000/webapp-imported:v1
```

## Task 10: Clean up images

```bash
podman rmi localhost:5000/webapp-imported:v1
podman image prune -a -f
```

## Check your work

```bash
skopeo list-tags --tls-verify=false docker://localhost:5000/webapp
ls -lh /tmp/webapp.tar /tmp/web1-fs.tar
```

## Find it in the man pages

No internet in the exam. Practice finding each item.

| Need | Command | Search for |
|---|---|---|
| Registry settings | `man containers-registries.conf` | `/insecure` |
| Login and auth file | `man podman-login` | `/auth.json` |
| Save formats | `man podman-save` | `/--format` |
| Import with changes | `man podman-import` | `/--change` |
| Copy between registries | `man skopeo-copy` | `/--dest-tls-verify` |
