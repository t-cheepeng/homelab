terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

resource "proxmox_vm_qemu" "application" {
  # VM options
  name        = "application"
  target_node = var.proxmox_host
  iso         = "local:iso/${var.os_template}"
  onboot      = true
  oncreate    = true
  qemu_os     = "other"

  # VM sizing
  memory  = var.memory
  sockets = 1
  cores   = var.cores
  cpu     = "host"

  network {
    model  = "virtio"
    bridge = var.nic
  }

  disk {
    type    = "ide"
    storage = var.storage_pool
    size    = var.size
  }
}
