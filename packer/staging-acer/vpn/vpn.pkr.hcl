variable "size" {
  type    = string
  default = null
}
variable "pfsense_iso" {
  type    = string
  default = null
}
variable "wan_nic" {
  type    = string
  default = null
}
variable "lan_nic" {
  type    = string
  default = null
}
variable "node" {
  type    = string
  default = null
}
variable "username" {
  type    = string
  default = null
}
variable "token" {
  type    = string
  default = null
}
variable "proxmox_url" {
  type    = string
  default = null
}
variable "wan" {
  type    = string
  default = null
}
variable "lan" {
  type    = string
  default = null
}
variable "wan_mac" {
  type    = string
  default = null
}
variable "wan_ip" {
  type    = string
  default = null
}
variable "control_node_ip" {
  type    = string
  default = null
}

packer {
  required_plugins {
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "proxmox-iso" "pfsense-template" {
  insecure_skip_tls_verify = true
  iso_file                 = "local:iso/${var.pfsense_iso}"
  boot_wait                = "35s"
  boot_command = [
    "<enter><wait2s>",                                        # Hit accept
    "<enter><wait2s>",                                        # Install
    "<enter><wait2s>",                                        # Auto ZFS
    "<enter><wait2s>",                                        # Proceed with installation
    "<enter><wait2s>",                                        # Disk type selection
    "<spacebar><wait>",                                       # Select disk
    "<enter><wait>",                                          # Confirm disk
    "<left><wait>",                                           # Confirm again
    "<enter><wait30s>",                                       # Hit Install
    "<enter><wait1m>",                                        # Hit reboot
    "n<enter><wait>",                                         # No VLAN setup
    "${var.wan}<enter><wait2s>",                              # WAN interface setup
    "${var.lan}<enter><wait2s>",                              # LAN interface setup
    "y<enter><wait1m30s>",                                    # Proceed
    "14<enter><wait>y<enter>",                                # Enable sshd
    "2<enter><wait>2<enter><wait>",                           # Delete LAN IP
    "n<enter><wait><enter><wait>n<enter><wait><enter><wait>", # No IPv6
    "y<enter><wait5s><enter>",                                # Revert to HTTP webconfigurator
    "8<enter><wait>",                                         # Shell
    "easyrule pass wan any ${var.control_node_ip} ${var.wan_ip} any<enter><wait5s>",
    "pfctl -d<enter><wait>", # Disable fire wall
    "<enter><wait>"
  ]

  network_adapters {
    bridge      = var.wan_nic
    model       = "virtio"
    mac_address = var.wan_mac
  }
  network_adapters {
    bridge = var.lan_nic
    model  = "virtio"
  }
  disks {
    disk_size    = var.size
    storage_pool = "local-lvm"
    type         = "ide"
  }

  node                 = var.node
  username             = var.username
  token                = var.token
  proxmox_url          = var.proxmox_url
  unmount_iso          = true
  template_name        = "pfsense-template"
  template_description = "pfsense"
  ssh_username         = "admin"
  ssh_password         = "pfsense"
  ssh_host             = var.wan_ip
  qemu_agent           = false
}

build {
  sources = ["source.proxmox-iso.pfsense-template"]

  provisioner "ansible" {
    galaxy_file   = "./requirements.yml"
    playbook_file = "./setup_pfsense.yml"
    # Required on SSH >= 9.0 as default is sftp which is not supported yet
    extra_arguments = ["--scp-extra-args", "'-O'", "--vault-password-file=pwd_file"]
  }
}