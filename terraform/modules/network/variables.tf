variable "proxmox_host" {
  type = string
}

variable "wan_nic" {
  type = string
}

variable "lan_nic" {
  type = string
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 1024
}

variable "storage_pool" {
  type    = string
  default = "local-lvm"
}

variable "size" {
  type    = number
  default = 50
}

variable "name" {
  type    = string
  default = "pfsense"
}