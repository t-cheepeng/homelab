# Network and VM Information

This document stores all the hardcoded VM information like MAC address, statically assigned IP addresses, etc..., and router information for home networks to be used throughout terraform and ansible.

## Singtel Router DHCP Reservation

The router's DHCP server IP pool is currently from 192.168.1.1 - 192.168.1.240

The router's IP address is 192.168.1.254

|MAC|IP|Device|
|---|---|---|
|5E:EB:0C:B3:9F:A0|192.168.1.248|Laptop Proxmox Staging pfsense
|74:56:3C:4B:BE:67|192.168.1.249|Control Node Desktop|
|D0:17:C2:D1:0E:E5|192.168.1.250|Production Proxmox|
|FE:EC:26:B0:94:BC|192.168.1.251|Laptop Proxmox Staging PiVPN LXC|
|EE:74:A5:44:25:E5|192.168.1.252|Baremetal TrueNAS External MAC|
|00:E0:4C:5E:F0:DF|192.168.1.253|Laptop Proxmox Staging|
|   |   |   |


## Pfsense VM

- MAC Address for WAN interface: 5E:EB:0C:B3:9F:A0

- MAC Address for LAN interface: 1E:C3:DB:8A:01:11