# Homelab

This repository holds the terraform and ansible files for homelab deployments. All code related to infrastructure provisioning and IT tasks should be in this repository.

## Existing Homelab Projects

- Bare metal TrueNAS on PC running a production envrionment. Has a transmission jail and plex jail.

- Proxmox on laptop as playground

## Plans for Homelab

- Deploy Tracket to Homelab

- Migrate bare metal TrueNAS over to Proxmox on PC

- Have laptop as a secondary PVE node?

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

2. On initial deployment, there is a need to enable SSHD on pfSense and generating the PK pair for ansible control node to connect to the pfSense machine.

    1. On pfSense, navigate to System > Advanced > Secure Shell.
    2. Enable secure shell with public key only
    3. On control node, run ssh-keygen -t ed25519 and enter a passphrase.
    4. On pfSense, navigate to System > User Manager > Edit (Pencil icon)
    5. Copy the .pub file contents generated in step 3. over to the section called Authorized SSH keys in step 4.
