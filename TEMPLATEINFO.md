# Template Information

This document describes what is stored in the templates created in proxmox.

## pfsense-template

This template starts from the base pfSense-CE-v2.6.0-AMD64 ISO image. The following is then ran on this image. Everything else is default from fresh install of the OS.

- Two network devices:
  - net0 - bridge=vmbr0
  - net1 - bridge=vmbr1
- net0 is configured to attach to WAN in pfsense.
- net1 is not configured to attach to any interface in pfsense.
- `pfctl -d` is executed in root shell. The packet filtering is disabled on the template.
- The default user is still `admin` and password is defaulted to `pfsense`.
- The initial firewall rules will only block bogon networks and not private IP addresses.
- The initial firewall rule has a anti-lockout, allowing any source:port combination to pass through to the WAN address:443 and WAN address:80
- SSH is enabled on port 22 and SSHd accepts both password and public key