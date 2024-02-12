variable "proxmox_host" {
  type = string
}

variable "hostname" {
  type = string
}

variable "lxc_template" {
  type = string
}

variable "password" {
  type = string
}

variable "memory" {
  type = number
  default = 256
}

variable "cores" {
  type = number
  default = 1
}

variable "storage_pool" {
  type = string
  default = "local-lvm"
}

variable "rootfs_size" {
  type = string
  default = "4G"
}

variable "nic" {
  type = string
}

variable "ip" {
  type = string
  default = "dhcp"
}