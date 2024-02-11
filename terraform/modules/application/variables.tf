variable "proxmox_host" {
  type = string
}

variable "os_template" {
  type = string
}

variable "memory" {
  type = number
  default = 1024
}

variable "cores" {
  type = number
  default = 1
}

variable "nic" {
  type = string
}

variable "storage_pool" {
  type = string
  default = "local-lvm"
}

variable "size" {
  type = string
  default = "100G"
}