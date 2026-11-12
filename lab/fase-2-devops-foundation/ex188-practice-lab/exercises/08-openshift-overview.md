# Exercise 08 (Optional): Kubernetes and OpenShift

This covers DO188 chapter 8. It is **not** listed in the EX188 exam objectives, so treat it as extra practice.

**Requirements:** an OpenShift cluster (OpenShift Local or the Developer Sandbox) and the `oc` command.

## Tasks

| Step | Command |
|---|---|
| Log in and create a project | `oc login ...` then `oc new-project ex188` |
| Deploy an app | `oc new-app --name web registry.access.redhat.com/ubi9/httpd-24` |
| Create a service and route | `oc expose deployment web --port 8080` then `oc expose service web` |
| Show the URL | `oc get route` |
| Read logs | `oc logs deploy/web` |
| Open a shell | `oc rsh deploy/web` |
| Forward a port | `oc port-forward deploy/web 8080:8080` |
| Inspect problems | `oc describe pod`, `oc get events` |
| Configuration | `oc create configmap`, `oc create secret generic`, `oc set env deploy/web --from=...` |
| Convert from Podman | `podman kube generate` then `oc apply -f file.yaml` |
| Clean up | `oc delete project ex188` |

## Multi-pod practice

Deploy a web app and a database. Create a `Service` for the database so the web app reaches it by name.
