# EX188 Practice Lab

An unofficial, hands-on practice lab for the Red Hat **EX188** exam (Podman, containers, images, Compose).

> Not affiliated with Red Hat. "Red Hat" and "EX188" are trademarks of Red Hat, Inc.

## About the exam

| | |
|---|---|
| **EX188K / V4** | Red Hat Certified Specialist in Containers |
| **EX188V5K / V5** | Red Hat Certified Developer in Cloud-native Applications (RHEL 10, Podman 5) |
| **Format** | Hands-on tasks on a live system, 2.5 hours, no multiple choice |
| **Key rule** | Configuration must **persist after reboot** without manual action |
| **Applications** | You may get pre-written apps. You do not change their code, but you may need the supplied docs to deploy them |

This lab covers the objectives of **both** versions.

## Exercises

| # | Topic | Exam objective |
|---|---|---|
| [01](exercises/01-containers.md) | Run containers | Run containers, logs, events, inspect, environment, expose ports |
| [02](exercises/02-containerfile.md) | Containerfile | FROM, RUN, ADD vs COPY, WORKDIR, USER, CMD vs ENTRYPOINT, EXPOSE, ENV, ARG, security |
| [03](exercises/03-image-management.md) | Images and registries | Tags, push/pull, private registries, save/load vs export/import |
| [04](exercises/04-storage-security.md) | Volumes and security | Volumes, bind mounts, SELinux, rootless, permissions, databases |
| [05](exercises/05-multi-container.md) | Multi-container apps | Compose, dependencies, env vars, secrets, volumes, config, pods |
| [06](exercises/06-quadlet-persistence.md) | Persistence after reboot | Quadlet and systemd |
| [07](exercises/07-troubleshooting.md) | Troubleshooting | Logs, inspect, exec, remote debugging |
| [08](exercises/08-openshift-overview.md) | OpenShift (optional) | DO188 chapter 8, not in the exam objectives |
| [Mock exam](mock-exam.md) | Full practice exam | All objectives, 2.5 hours |

### DO188 course mapping

| DO188 chapter | Exercise |
|---|---|
| 2. Podman Basics | 01 |
| 3. Container Images | 03 |
| 4. Custom Container Images (incl. rootless) | 02, 04 |
| 5. Persisting Data | 04 |
| 6. Troubleshooting Containers | 07 |
| 7. Multi-container Applications with Compose | 05 |
| 8. Orchestration with OpenShift and Kubernetes | 08 |
| 9. Comprehensive Review | Mock exam |

## Getting started

**Requirements**

- RHEL 10, Rocky, Alma, or Fedora
- Podman 5 or newer, plus `skopeo`
- `podman-compose` or `docker-compose` (needed for `podman compose`)
- A normal user account. Work **rootless**, as in the exam

**Commands**

```bash
chmod +x *.sh solutions/*.sh
./lab-setup.sh        # pull images, start local registry on :5000, create data folders
./grade-lab.sh        # grading menu (or: ./grade-lab.sh 03, ./grade-lab.sh all)
./lab-clean.sh        # reset everything
```

For Exercise 07, run `./break-lab.sh` first. It creates the broken containers you need to fix.

## Exam tips (Podman 5)

**Look things up fast.** The product docs are available in the exam. Practice with `man podman-run`,
`man podman-build`, `man containers-registries.conf`, and `man podman-systemd.unit`.

**Persistence.** Use Quadlet files in `~/.config/containers/systemd/` and run `loginctl enable-linger <user>`.
`podman generate systemd` is deprecated.

**Renamed commands.** Use `podman kube play` and `podman kube generate`.
The old `play kube` and `generate kube` forms are deprecated.

**SELinux.** Add `:Z` (private) or `:z` (shared) to bind mounts. Most storage failures come from this.

**Ports.** Rootless users cannot bind ports below 1024.

**Networking.** Rootless Podman 5 uses `pasta` and `netavark`. Read the container IP from
`.NetworkSettings.Networks.<network>.IPAddress`.

**Registries without TLS.** Use `--tls-verify=false`, or set `insecure = true` in
`/etc/containers/registries.conf.d/`.

**Finish with checks.** Run `podman ps -a`, `curl`, and `podman logs`. Reboot the machine if a task asks for persistence.
