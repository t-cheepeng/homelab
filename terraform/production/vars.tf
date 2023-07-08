#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_host" {
  default = "pve"
}

#Specify which template name you'd like to use
variable "generic_linux_os_debian_template" {
  default = "debian-11-standard_11.7-1_amd64.tar.zst"
}
variable "ics_dhcp_template" {
  default = "debian_11_dhcp.tar.gz"
}
variable "dnsmasq_template" {
  default = "debian_11_dnsmasq.tar.gz"
}
variable "geneirc_linux_os_debian_vm_template" {
  default = "debian-12.0.0-amd64-netinst.iso"
}
variable "pfsense_template" {
  default = "pfsense-template"
}
variable "truenas_template" {
  default = "TrueNAS-13.0-U5.1.iso"
}

#Establish which nic you would like to utilize
variable "internal_nic_name" {
  default = "vmbr1"
}
variable "external_nic_name" {
  default = "vmbr0"
}

# Storage pool variables
variable "storage_pool" {
  default = "vm-storage"
}

#Provide the url of the host you would like the API to communicate on.
#It is safe to default to setting this as the URL for what you used
#as your `proxmox_host`, although they can be different
variable "api_url" {
  default = "https://pve.localdomain:8006/api2/json"
}
#Blank var for use by terraform.tfvars
variable "token_secret" {
}
#Blank var for use by terraform.tfvars
variable "token_id" {
}
#Blank var for use by terraform.tfvars
variable "ssh_public_keys" {

}