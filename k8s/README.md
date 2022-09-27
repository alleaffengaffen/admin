# K8s Setup

Because we don't automate, this is just a placeholder with some config files that were used to install the different tools on the management cluster.

## Cluster Bootstrap

Basically we used [this guide](https://wiki.technat.ch/Kubernetes/k8s_kubeadm.html) to bootstrap our cluster.

The cilium [values](cilium-values.yaml) used can be found in this directory.

## Cluster API

The base capi Was installed regurarly as so:

```bash
clusterctl init
```

### Infrastructure Providers

#### AWS

This [quickstart](https://cluster-api-aws.sigs.k8s.io/getting-started.html) shows what to set to initialize the AWS provider.

Some notes:
- separate IAM user used
- Home region: eu-west-2 (unsure if you could change this when you specify it in the aws provider initialization)

The yubikey was added as SSH key to the dashboard of eu-west-2 manually.

## Cert-Manager

Comes with CAPI, only the issuers were installed after on.

See [here](https://github.com/Infomaniak/cert-manager-webhook-infomaniak) for what is required to use Infomaniak DNS-01 challenge to get let's encrypt certificates.

## Argo CD

Installed using the community Helm chart, see the [argocd-values.yaml](./argocd-values.yaml) for the details.

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm upgrade -i argocd argo/argo-cd -n argocd -f argocd-values.yaml
```

The Argo CD instance can be rechached at [https://admin.alleaffengaffen.ch:30443](https://admin.alleaffengaffen.ch:30443).

To access the instance using port 80/443 I did a little trick on the NodePort service:

```yaml
spec:
  externalIPs:
  - 1.2.3.4
```

This creates the necessary 'iptables' rule to forward traffic comming on this IP to the coresponding pods in the overlay network. Of course for this the IP has to be assigned to a node and traffic will only flow over this node... But for single node usage it's perfectly fine.

## Next steps

With that provisioned, you got a decent management cluster ready to use for bootstraping other clusters. See the [clusters](https://github.com/alleaffengaffen/clusters) repo for details on how I'm bootstraping multiple clusters using GitOps.
