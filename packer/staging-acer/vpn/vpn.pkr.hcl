packer {
  required_plugins {
    lxc = {
      source  = "github.com/hashicorp/lxc"
      version = "~> 1"
    }
  }
}

source "lxc" "container" {
  config_file      = "/etc/lxc/default.conf"
  template_name    = "download"
  output_directory = "/tmp/lxc/packer/build/debian/bookworm/amd64"

  template_parameters = [
    "--dist", "debian",
    "--release", "bookworm",
    "--arch", "amd64",
  ]
}

build {
  sources = ["source.lxc.container"]

  provisioner "file" {
    source = "./install.conf"
    destination = "/tmp/install.conf"
  }

  provisioner "shell" {
    remote_folder = "/tmp"
    script = "./install-pivpn.sh"
  }
}