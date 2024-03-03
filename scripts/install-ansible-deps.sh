#!/bin/bash
ansible-galaxy collection install pfsensible.core
packer plugins install github.com/hashicorp/proxmox
packer plugins install github.com/hashicorp/lxc
service lxc-net stop
service lxc-net start