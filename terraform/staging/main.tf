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

# Router/Firewall to internal subnets
resource "proxmox_vm_qemu" "pfsense" {
  # VM options
  name        = "pfsense"
  target_node = var.proxmox_host
  clone       = var.pfsense_template
  onboot      = true
  oncreate    = true
  full_clone  = true

  # VM sizing
  memory  = 1024
  sockets = 1
  cores   = 2
  cpu     = "host"

  # WAN interface
  network {
    model   = "virtio"
    macaddr = "5E:EB:0C:B3:9F:A0"
    bridge  = var.external_nic_name
  }

  # LAN virtual interface
  network {
    model   = "virtio"
    macaddr = "1E:C3:DB:8A:01:11"
    bridge  = var.internal_nic_name
  }
}

# DNS/DHCP container
resource "proxmox_lxc" "internal-dns-dhcp" {
  # LXC options
  target_node     = var.proxmox_host
  hostname        = "internal-dns-dhcp"
  ostemplate      = "local:vztmpl/${var.dnsmasq_template}"
  password        = "password"
  unprivileged    = true
  onboot          = true
  start           = true
  ssh_public_keys = var.ssh_public_keys
  features {
    nesting = true
  }

  # LXC sizing
  cores  = 1
  memory = 512
  rootfs {
    storage = var.storage_pool
    size    = "8G"
  }

  # LAN virtual interface
  network {
    name   = "eth0"
    bridge = var.internal_nic_name
    ip     = "192.168.2.1/24"
    gw = "192.168.2.254"
  }
}

# Application server running docker
resource "proxmox_vm_qemu" "docker" {
  name        = "application-server"
  target_node = var.proxmox_host
  iso         = "local:iso/${var.geneirc_linux_os_debian_vm_template}"
  memory      = "4096"
  sockets     = 1
  cores       = 4
  onboot      = true
  qemu_os     = "other"

  network {
    model  = "virtio"
    bridge = var.internal_nic_name
  }

  disk {
    type    = "ide"
    storage = "local-lvm"
    size    = "100G"
  }
}