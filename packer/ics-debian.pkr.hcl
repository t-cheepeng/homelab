source "lxc" "debian" {
  type          = "lxc"
  name          = "lxc-debian"
  template_name = "./lxc-templates/debian_3.0.4.48_amd64.deb"
}

build {
  sources = ["source.lxc.debian"]
}