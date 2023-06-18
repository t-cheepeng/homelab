#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_host" {
    default = "pve"
}
#Specify which template name you'd like to use
variable "template_name" {
    default = "debian-11-standard_11.7-1_amd64.tar.zst"
}
#Establish which nic you would like to utilize
variable "internal_nic_name" {
    default = "vmbr1"
}
variable "external_nic_name" {
  default = "vmbr0"
}
#Provide the url of the host you would like the API to communicate on.
#It is safe to default to setting this as the URL for what you used
#as your `proxmox_host`, although they can be different
variable "api_url" {
    default = "https://pve:8006/api2/json"
}
#Blank var for use by terraform.tfvars
variable "token_secret" {
}
#Blank var for use by terraform.tfvars
variable "token_id" {
}