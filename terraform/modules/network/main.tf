terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

resource "proxmox_vm_qemu" "pfsense" {
  # VM options
  name        = var.name
  target_node = var.proxmox_host
  clone       = "pfsense-template"
  full_clone  = true
  onboot      = true
  vm_state    = "running"

  #   # VM sizing
  memory  = var.memory
  sockets = 1
  cores   = var.cores
  cpu     = "host"

  # WAN interface
  network {
    model   = "virtio"
    macaddr = "5E:EB:0C:B3:9F:A0"
    bridge  = var.wan_nic
  }

  # LAN virtual interface
  network {
    model   = "virtio"
    macaddr = "1E:C3:DB:8A:01:11"
    bridge  = var.lan_nic
  }

  disks {
    ide {
      ide0 {
        disk {
          storage = var.storage_pool
          size    = var.size
        }
      }
    }
  }
}
