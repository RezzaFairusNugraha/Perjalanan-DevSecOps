# Exercise 06: Persistence After Reboot (Quadlet)

**Objective:** configuration must survive a reboot without manual action.

**Time:** 20 minutes

## Background

The official objectives only say that configuration must persist after reboot. They do not name systemd.
The reliable way is a **Quadlet** file, which systemd turns into a service.

| Method | Survives reboot (rootless)? |
|---|---|
| `--restart=always` only | **No**, unless `podman-restart.service` is enabled and lingering is on |
| `podman generate systemd` | Works, but **deprecated** |
| **Quadlet `.container` file** | **Yes** (recommended) |

Volumes, networks, and secrets already persist on their own.
Syntax reference: `man podman-systemd.unit`.

## Task 1: Enable lingering

Without lingering, a user's services stop at logout and do not start at boot.

```bash
loginctl enable-linger $USER
loginctl show-user $USER -p Linger      # Linger=yes
```

## Task 2: Create the Quadlet file

Create the folder and file `~/.config/containers/systemd/auto-web.container`:

```bash
mkdir -p ~/.config/containers/systemd
cat > ~/.config/containers/systemd/auto-web.container <<'EOF'
[Unit]
Description=Auto web
After=network-online.target

[Container]
ContainerName=auto-web
Image=registry.access.redhat.com/ubi9/httpd-24
PublishPort=8082:8080
Volume=%h/ex188-data/html:/var/www/html:ro,Z
Environment=EXAM=ex188

[Service]
Restart=always

[Install]
WantedBy=default.target
EOF
```

## Task 3: Start the service

```bash
systemctl --user daemon-reload
systemctl --user start auto-web.service
```

Quadlet services are generated, so you do not run `enable`. The `[Install]` section makes them start at boot.

If the unit does not appear, check for syntax errors:

```bash
/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun
```

## Task 4: Verify

```bash
systemctl --user status auto-web
podman ps
curl http://127.0.0.1:8082
journalctl --user -u auto-web
systemctl --user restart auto-web
```

## Task 5: Other Quadlet types (read about them)

| File | Creates |
|---|---|
| `.container` | A container |
| `.volume` | A named volume |
| `.network` | A network |
| `.pod` | A pod |
| `.kube` | A Kubernetes YAML deployment |

## Task 6 (bonus): Auto-update

Add `AutoUpdate=registry` under `[Container]`, then:

```bash
systemctl --user enable --now podman-auto-update.timer
```

## Check your work

Reboot the machine. After login (or even without login), `curl http://127.0.0.1:8082` still works.
