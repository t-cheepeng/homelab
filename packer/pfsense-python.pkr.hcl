variable "proxmox_api_url" {
  type    = string
  default = "https://pve:8006/api2/json"
}

variable "proxmox_node" {
  default = "pve"
}

variable "pfsense_image" {
  default = "pfSense-CE-2.6.0-RELEASE-amd64.iso"
}

variable "token_id" {
  type = string
}

variable "token_secret" {
  type = string
}

variable "ssh_username" {

}
variable "ssh_password" {

}

source "proxmox-iso" "pfsense-python" {
  boot_command = ["<wait1m><enter><wait5><enter><wait5><enter><wait5><enter><wait5><enter><wait5><enter><wait5><spacebar><enter><wait5><left><enter><wait5><wait1.5m><enter><wait5><enter><wait5>"]
  proxmox_url              = var.proxmox_api_url
  username                 = var.token_id
  token                    = var.token_secret
  node                     = var.proxmox_node
  iso_file                 = "local:iso/${var.pfsense_image}"
  iso_storage_pool         = "local:iso"
  insecure_skip_tls_verify = true
  ssh_username             = var.ssh_username
  ssh_password             = var.ssh_password

  memory   = 1024
  cores    = 2
  cpu_type = "host"

  disks {
    disk_size    = "5G"
    storage_pool = "local-lvm"
  }

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  unmount_iso          = true
  template_name        = "pfsense-python-latest"
  template_description = "Pfsense latest build with python 3.X installed, generated on ${timestamp()}"
}

build {
  sources = ["source.proxmox-iso.pfsense-python"]
}