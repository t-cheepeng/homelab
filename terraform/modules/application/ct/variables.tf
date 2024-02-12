variable "proxmox_host" {
  type = string
}

variable "hostname" {
  type = string
}

variable "lxc_template" {
  type = string
}

variable "memory" {
  type = number
  default = 512
}

variable "password" {
  type = string
}

variable "cores" {
  type = number
  default = 1
}

variable "nic" {
  type = string
}

variable "ip" {
  type = string
  default = "dhcp"
}

variable "gw" {
  type = string
}

variable "storage_pool" {
  type = string
  default = "local-lvm"
}

variable "rootfs_size" {
  type = string
  default = "8G"
}