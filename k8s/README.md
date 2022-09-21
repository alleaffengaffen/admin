# K8s Setup

Basically we used [this guide](https://wiki.technat.ch/Kubernetes/k8s_kubeadm.html) to bootstrap our cluster.

Here are only specific things listed that differ from the guide:
- cilium values can be found in this directory.

## Cluster API

Was installed regurarly as so:

```bash
clusterctl init
```

### Infrastructure Providers

#### AWS

IAM roles installed using `clusterawsadm` and the provider using the CLI.

## Cert-Manager

Comes with CAPI, only the issuers were installed after on.

See [here](https://github.com/Infomaniak/cert-manager-webhook-infomaniak) for what is required to use Infomaniak DNS-01 challenge.

## Argo CD

Installed using the community Helm chart, see the [argocd-values.yaml](./argocd-values.yaml) for the details.

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm upgrade -i argocd argo/argo-cd -n argocd -f argocd-values.yaml
```

The Argo CD instance can be rechached at [https://admin.alleaffengaffen.ch:30443](https://admin.alleaffengaffen.ch:30443).

## Clusters

Apply the `clusters.yaml` manifest in the `argocd` namespace to configure the cluster of clusters app.
