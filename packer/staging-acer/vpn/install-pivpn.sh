#!/bin/bash
apt-get update
apt-get dist-upgrade -y

apt-get install -y curl wireguard

curl -L https://install.pivpn.io > /tmp/install.sh

chmod +x /tmp/install.sh
/tmp/install.sh --unattended /tmp/install.conf
