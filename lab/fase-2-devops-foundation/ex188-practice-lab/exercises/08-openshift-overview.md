# Exercise 08 (Opsional) — Orchestration dengan Kubernetes/OpenShift

> DO188 bab 8. **Tidak** termasuk objective ujian EX188 yang tercantum; latih sebagai pelengkap.
> Butuh cluster (OpenShift Local/`crc`, Developer Sandbox) dan `oc`.

1. `oc login`, `oc new-project ex188`.
2. Deploy: `oc new-app --name web registry.access.redhat.com/ubi9/httpd-24` (atau `oc create deployment`).
3. Ekspos: `oc expose deployment web --port 8080`, `oc expose service web`, `oc get route`.
4. Debug: `oc logs deploy/web`, `oc describe pod`, `oc rsh deploy/web`, `oc port-forward deploy/web 8080:8080`.
5. Config: `oc create configmap`, `oc create secret generic`, `oc set env deploy/web --from=...`.
6. Multi-pod: aplikasi web + database (`Service` untuk DNS), `oc get events`.
7. Dari Podman ke Kubernetes: `podman kube generate` → `oc apply -f`.
8. Cleanup: `oc delete project ex188`.
