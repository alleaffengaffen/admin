locals {
  user_data = templatefile("${path.module}/cloud_init.yaml", {
    ansible_user     = var.ansible_user
    ansible_ssh_port = var.ansible_ssh_port
    ansible_ssh_key  = var.ansible_ssh_key
  })
}

resource "hcloud_ssh_key" "ansible_key" {
  name       = "Terraform Ansible Key"
  public_key = var.ansible_ssh_key
}

resource "hcloud_server" "admin" {
  name        = var.server_name
  server_type = var.server_type
  location    = var.server_location
  image       = var.server_image
  user_data   = local.user_data
  ssh_keys    = [hcloud_ssh_key.ansible_key.id] # Add the ansible ssh-key as key for root to prevent mails with root passwords
  backups     = var.server_backups
  labels = {
    "created-by"    = "terraform"
    "configured-by" = "ansible"
    "k8s-admin" = "true"
  }
}

resource "hcloud_firewall" "admin" {
  name = var.server_name
  apply_to {
    label_selector = "k8s-admin"
  }
  rule {
    // Ping
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    // Kube-api
    direction = "in"
    protocol  = "tcp"
    port = "6443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    // SSH
    direction = "in"
    protocol  = "tcp"
    port = var.ansible_ssh_port
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    // ETCD
    direction = "in"
    protocol  = "tcp"
    port = "2379-2380"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // Kubelet
  rule {
    direction = "in"
    protocol  = "tcp"
    port = "10250"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // kube-scheduler
  # rule {
  #   direction = "in"
  #   protocol  = "tcp"
  #   port = "10259"
  #   source_ips = [
  #     join("", [hcloud_server.admin.ipv4_address, "/32"])
  #   ]
  # }
  // kube-controller-manager
  # rule {
  #   direction = "in"
  #   protocol  = "tcp"
  #   port = "10257"
  #   source_ips = [
  #     join("", [hcloud_server.admin.ipv4_address, "/32"])
  #   ]
  # }
  // cilium health checks
  rule {
    direction = "in"
    protocol  = "tcp"
    port = "4240"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // cilium VXLAN overlay mode
  rule {
    direction = "in"
    protocol  = "udp"
    port = "8472"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // cilium wireguard pod-to-pod traffic
  rule {
    direction = "in"
    protocol  = "udp"
    port = "51871"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // argocd ui
  rule {
    direction = "in"
    protocol  = "tcp"
    port = "80"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // argocd ui
  rule {
    direction = "in"
    protocol  = "tcp"
    port = "443"
    source_ips = [
      join("", [hcloud_server.admin.ipv4_address, "/32"])
    ]
  }
  // nodeport services
  # rule {
  #   direction = "in"
  #   protocol  = "tcp"
  #   port = "30000-32786"
  #   source_ips = [
  #   join("", [hcloud_server.admin.ipv4_address, "/32"])
  #   ]
  # }
}