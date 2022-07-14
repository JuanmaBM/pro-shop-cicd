# PRO-SHOP-CIC Workshop

This repository is made with the purpose to training CICD and GitOps aproach with Tekton and ArgoCD under OpenShift 4 cluster, but you can use it with Kubernetes vanilla too.

There are two associated repositories, [production-api](https://github.com/JuanmaBM/product-api/) repository for application source code, and [production-api-k8s](https://github.com/JuanmaBM/product-api-k8s) which contains descriptors for prodution-api Kubernetes components.

## Requirements

- OpenShift 4 cluster *
- Openshift cli *
- kubeseal cli
- quay.io account

\* You can use Kubernetes without problems, but you need change 'oc' command for 'kubectl' into setup script and change event listener route for ingress controller.

## Getting start

1. Fork [production-api](https://github.com/JuanmaBM/product-api/) and [production-api-k8s](https://github.com/JuanmaBM/product-api-k8s)
2. In product-api repository, build image and push to your quay repository (you must be logged in quay.io): 
```
podman login quay.io
podman build . -f src/main/docker/Dockerfile.jvm -t quay.io/<your_user>/product-api:1.0
podman push quay.io/<your_user>/product-api:1.0
```
3. Change production-api repository url for your forked repository in gitops/application/application-pro-shop-main.yaml (line 13) 
4. In cicd/trigger/trigger-template.yaml, change production-api repository url (line 24) and production-api-k8s url (line 36) for your forked repositories
5. In the same file, image-url param (line 30) for your product-api image url in your quay.io account
6. Execute setup script (you must be logged on Openshift with a user who has cluster admin permissions)
7. Get Github event listener url. Execute the command and copy the output
```
oc get route el-github-listener -o template --template='{{"http://"}}{{.spec.host}}'
```
8. Create a webhook in your product-api repository: https://github.com/<your_user>/product-api/settings/hooks/new (Use the previous url to setting 'Payload URL in webhook)
9. Enjoy!