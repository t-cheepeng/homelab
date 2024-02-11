## pfSense Packer

This packer build will install a pfSense router. The following is the configuration made on this build

1. No VLAN, IPv6
2. WAN interface with MAC 5E:EB:0C:B3:9F:A0 and IP from DHCP
3. LAN interface set but has no IP on it
4. HTTP access for WebConfigurator
5. SSHD is enabled with default user and password from pfSense
