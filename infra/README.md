# Infrastructure

The infrastructure for my management / admin cluster is created using terraform. In this directory you can find the root module that's used to deploy the server.

As you can see it's just a single server, but we don't need more for a management cluster.

I'm using [this workflows](https://learn.hashicorp.com/tutorials/terraform/github-actions) to run Terraform while using TF cloud for state. This allows me to integrate Terraform with Ansible be echoing the information for ansible as terraform output.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.35.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.admin](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_server.admin](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_ssh_key.ansible_key](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_ssh_key"></a> [ansible\_ssh\_key](#input\_ansible\_ssh\_key) | SSH public key to inject into Cloud server for ansible user | `string` | `"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+YUh/F0QGjQgWKXgE1o7E+TAvdy4OgWosQ3OCaYrC0 service_ansible"` | no |
| <a name="input_ansible_ssh_port"></a> [ansible\_ssh\_port](#input\_ansible\_ssh\_port) | SSH port for Cloud server | `number` | `59245` | no |
| <a name="input_ansible_user"></a> [ansible\_user](#input\_ansible\_user) | Username for the ansible user | `string` | `"ci"` | no |
| <a name="input_server_backups"></a> [server\_backups](#input\_server\_backups) | Enable server backups if needed | `bool` | `false` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | Image to use for the Cloud server | `string` | `"ubuntu-22.04"` | no |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | Location where your Cloud server should be located | `string` | `"hel1"` | no |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | Name for the cloud server | `string` | `"cucumber"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | Server type to use for the Cloud server | `string` | `"cx21"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ansible_ssh_key"></a> [ansible\_ssh\_key](#output\_ansible\_ssh\_key) | Public SSH key for ansible user |
| <a name="output_ansible_ssh_port"></a> [ansible\_ssh\_port](#output\_ansible\_ssh\_port) | SSH port for Cloud server |
| <a name="output_ansible_user"></a> [ansible\_user](#output\_ansible\_user) | User for ansible to configure the system |
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | IPv4 address of Cloud server |
| <a name="output_ipv6_address"></a> [ipv6\_address](#output\_ipv6\_address) | IPv6 address of Cloud server |
| <a name="output_ipv6_network"></a> [ipv6\_network](#output\_ipv6\_network) | IPv6 net of Cloud server |
<!-- END_TF_DOCS -->
