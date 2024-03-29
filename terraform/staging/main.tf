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

module "pfsense" {
  source = "../modules/network"
  wan_nic = var.wan_nic
  lan_nic = var.lan_nic
  proxmox_host = var.proxmox_host
}

module "application" {
  source = "../modules/application"
  proxmox_host = var.proxmox_host
  nic = var.lan_nic
  os_template = var.debian_iso
  size = "50G"
}