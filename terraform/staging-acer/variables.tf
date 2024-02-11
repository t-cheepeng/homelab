#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_host" {
  default = "pve-staging-acer"
}

#Specify which template name you'd like to use
variable "pfsense_template" {
  default = "pfSenseCE_2.7.2_amd64.iso"
}
variable "debian_iso" {
  default = "debian_12.4.0_amd64.iso"
}

#Establish which nic you would like to utilize
variable "wan_nic" {
  default = "vmbr0"
}
variable "lan_nic" {
  default = "vmbr1"
}

# Storage pool variables
variable "storage_pool" {
  default = "local-lvm"
}

#Provide the url of the host you would like the API to communicate on.
#It is safe to default to setting this as the URL for what you used
#as your `proxmox_host`, although they can be different
variable "api_url" {
  default = "https://homelab-acer:8006/api2/json"
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