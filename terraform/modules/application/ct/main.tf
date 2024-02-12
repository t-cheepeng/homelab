terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

resource "proxmox_lxc" "ct_application" {
  # VM options
  target_node  = var.proxmox_host
  hostname     = var.hostname
  ostemplate   = "local:vztmpl/${var.lxc_template}"
  onboot       = true
  start        = true
  unprivileged = true
  password     = var.password

  # VM sizing
  memory = var.memory
  cores  = var.cores

  rootfs {
    storage = var.storage_pool
    size    = var.rootfs_size
  }

  network {
    name   = "eth0"
    bridge = var.nic
    ip     = var.ip
    gw     = var.gw
  }
}
