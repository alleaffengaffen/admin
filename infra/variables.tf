#----------------
# Environment Vars
#----------------
variable "ansible_user" {
  type        = string
  description = "Username for the ansible user"
  default     = "ci"
}

variable "ansible_ssh_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+YUh/F0QGjQgWKXgE1o7E+TAvdy4OgWosQ3OCaYrC0 service_ansible"
  description = "SSH public key to inject into Cloud server for ansible user"
}

variable "ansible_ssh_port" {
  type        = number
  default     = 59245
  description = "SSH port for Cloud server"
}

#----------------
# Server Vars
#----------------
variable "server_name" {
  type        = string
  default     = "cucumber"
  description = "Name for the cloud server"
}

variable "server_image" {
  type        = string
  default     = "ubuntu-22.04"
  description = "Image to use for the Cloud server"
}

variable "server_type" {
  type        = string
  default     = "cx21"
  description = "Server type to use for the Cloud server"
}

variable "server_location" {
  type        = string
  default     = "hel1"
  description = "Location where your Cloud server should be located"
}

variable "server_backups" {
  type        = bool
  description = "Enable server backups if needed"
  default     = false
}
