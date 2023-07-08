terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  # References our vars.tf file to plug in the api_url 
  pm_api_url = var.api_url
  # References our secrets.tfvars file to plug in our token_id
  pm_api_token_id = var.token_id
  # References our secrets.tfvars to plug in our tokehttps://192.168.1.253:8006/#n_secret 
  pm_api_token_secret = var.token_secret
  # Default to `true` unless you have TLS working within your pve setup 
  pm_tls_insecure = true
}

# TrueNAS VM for storage
resource "proxmox_vm_qemu" "truenas" {
  name        = "truenas"
  target_node = var.proxmox_host
  iso         = "local:iso/${var.truenas_template}"
  bios        = "ovmf"
  memory      = "10240"
  sockets     = 1
  cores       = 2
  onboot      = true
  oncreate    = true
  qemu_os     = "other"

  network {
    model   = "virtio"
    macaddr = "EE:74:A5:44:25:E5"
    bridge  = var.external_nic_name
  }

  disk {
    type    = "virtio"
    storage = var.storage_pool
    size    = "64G"
  }
}