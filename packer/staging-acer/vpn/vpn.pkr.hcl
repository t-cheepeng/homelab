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
  output_directory = "/tmp/lxc/packer/build/alpine/3.19/amd64"

  template_parameters = [
    "--dist", "alpine",
    "--release", "3.19",
    "--arch", "amd64",
  ]
}

build {
  sources = ["source.lxc.container"]
}