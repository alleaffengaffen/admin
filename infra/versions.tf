terraform {
  cloud {
    organization = "alleaffengaffen"

    workspaces {
      name = "admin"
    }
  }
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}
