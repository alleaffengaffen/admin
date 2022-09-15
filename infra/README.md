# Infrastructure

Normally you would see some Terraform code in here, but since this is a new project and I'm not a fan of automating before even knowing how things work, this is just a placeholder for the future.

I just let you know that this admin k8s cluster uses a single master node. Here are some details about it:

| Key | Value |
| --- | ----- |
| Provider | Hetzner |
| Location | Helsinki (eu-central) |
| OS | Ubuntu 22.04 | 
| Type | CX21 | 
| Backups | true |
| Userdata | see https://wiki.technat.ch/Linux/cloud_init.html | 
| IPv4 | 65.21.253.236 |
| IPv6 | 2a01:4f9:c012:57c6::/64 |
| DNS | admin.technat.ch |
