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
  # References our secrets.tfvars to plug in our token_secret 
  pm_api_token_secret = var.token_secret
  # Default to `true` unless you have TLS working within your pve setup 
  pm_tls_insecure = true
}

resource "proxmox_lxc" "test-lxc" {
  hostname     = "test-lxc"
  target_node  = var.proxmox_host
  ostemplate   = "local:vztmpl/${var.template_name}"
  unprivileged = true
  password     = "password"
  cores        = 1
  memory       = 512

  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = var.internal_nic_name
    ip     = "dhcp"
  }
}

resource "proxmox_vm_qemu" "pfSense" {
  
}