# Homelab

This repository holds the terraform and ansible files for homelab deployments. All code related to infrastructure provisioning and IT tasks should be in this repository.

## Existing Homelab Projects

- Bare metal TrueNAS on PC running a production envrionment. Has a transmission jail and plex jail.

- Proxmox on laptop as playground

## Plans for Homelab

- Deploy Tracket to Homelab

## Homelab initialization for Proxmox

### Background

There are some steps that need to be done on Proxmox fresh install in order to ensure that all ansible and terraform scripts run successfully like user creations/etc... This is a one time configuration and should be pretty quick to do.

### Initialization steps for Proxmox

1. Disable the enterprise repository for updates in proxmox

2. Do a update and upgrade on a fresh install

3. Install pip with `sudo apt install pip`

4. Install proxmoxer (required for ansible to communicate with proxmox VE) with `pip install proxmoxer`

5. Under Users > Add two users: ansible-user and terraform-user

6. Under API Tokens > Add two new tokens: ansible-token and terraform-token. Copy down the secret value when shown. Ensure privilege separation is unchecked

7. Under Roles > Create a new role: PVEInfra. Allocate the privileges defined in `KB 1.`

8. Under Permissions > Add two User Permissions for path `/` and the two users created in step 5. Select their role as PVEInfra under step 7.

9. In order for ansible to connect via SSH to proxmox VE, generate a SSH key on the control node machine with `ssh-keygen -t ed25519`. Copy over the `.pub` key file contents over to proxmox VE under /root/.ssh/authorized_keys

## KB

1. Terraform with Telmate/proxmox provider, v2.9.14, requires the minimal set of permissions: "Datastore.Audit, VM.Config.CDROM, VM.Config.Network, Pool.Allocate, VM.Config.HWType, VM.Audit, Sys.Console, VM.Config.CPU, VM.Clone, Datastore.AllocateSpace, VM.PowerMgmt, VM.Migrate, VM.Config.Options, Sys.Modify, VM.Config.Disk, VM.Monitor, VM.Allocate, VM.Config.Memory, Sys.Audit, VM.Config.Cloudinit, User.Modify, Datastore.Allocate, Datastore.AllocateTemplate, Group.Allocate, Permissions.Modify, Pool.Audit, Realm.Allocate, Realm.AllocateUser, SDN.Allocate, SDN.Audit, Sys.Incoming, Sys.PowerMgmt, Sys.Syslog, VM.Backup, VM.Console, VM.Snapshot, VM.Snapshot.Rollback"

2. On initial deployment, for pfsense machine, there is a need to perform `pfctl -d` if the connection is not established by ansible. Once the firewall rules are up properly for the first time, there is no need to perform this firewall action anymore

3. To enable IOMMU (most modern MB and CPU have it), go to BIOS and enable the VT-d option or IOMMU option. This is separate from Virutalization technology options present in some MB. Once enabled, use a text editor to edit `/etc/default/grub` and add in to the line `GRUB_CMDLINE_LINUX_DEFAULT="quiet"` the option `intel_iommu=on`. This is if you are using GRUB bootloader. If using systemd bootloader, check the [link](https://pve.proxmox.com/pve-docs/pve-admin-guide.html#sysboot_proxmox_boot_tool) to find out which file to edit to add the option in. To verify if IOMMU is enabled run `dmesg | grep -e DMAR -e IOMMU` in proxmox and there should be a line `DMAR: IOMMU enabled`. To verify interrupt mapping (necessary to run PCI passthroughs), run `dmesg | grep 'remapping'` and there should be a line `DMAR-IR: ENabled IRQ remapping in x2apic mode`. To check the IOMMU groupings, run `pvesh get /nodes/{node_name}/hardware/pci --pci-class-blacklist ""` replacing `node_name` with proxmox's node name and the output displays the IOMMU group each device is in.

4. For TrueNAS VMs, the BIOS to be used is OVMF. Otherwise, during installation, there is a need to install for BIOS instead of UEFI. If using OVMF, there needs to be a manual addition of a EFI disk in a storage pool. When creating the disk, uncheck the option `pre-enroll-keys`. This disabled secure boot which is a windows specific option. It should not be enabled for trusted TrueNAS ISOs.

5. Adding a PCI passthrough requires going to the `Hardware` section of the VM. Click on `Add` and `PCI device`. Select the PCI device to passthrough and check the `Full Functionality` if required. Ensure IOMMU is enabled as KB.3.

6. For laptop environments with a lid, in order to keep the lid from making the laptop go to sleep, run `cat /proc/acpi/wakeup` to find the path of the lid switch. In the output, there will be a line starting with `LID0`. Take note of the path that says `platform:PNP0C0D:00`. Run the command `echo 'PNP0C0D:00' | sudo tee /sys/bus/acpi/drivers/button/unbind`, replacing the echo with the appropriate path to unbind the lid switch.

## TODO 

1. Add more firewall rules to allow only manjaroPC and Phone to enter internal subnet

2. Retry packer build for pfsense

3. Use packer to create piVPN container with LXC builder

4. Where to best place the static routes? In the home router or on VPN container? 

5. Draw out network diagram for applications