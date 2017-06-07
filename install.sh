#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Installing Required Packages"
# Install required packages
apt-get update
apt-get install hostapd dnsmasq

echo "Installing Config files"
# Interfaces file for 'hotspot mode'
# TODO: Config address for wlan0
cp "`dirname $0`/config/interfaces.host" /etc/network/interfaces/interfaces.host

# Interfaces file for client mode
cp "`dirname $0`/config/interfaces.client" /etc/network/interfaces/interfaces.client

# Static config file for dnsmasq
cp "`dirname $0`/config/dnsmasq.conf" /etc/dnsmasq.conf

# Edit hostapd file to point to the conf file
sed -i 's/#DAEMON_CONF=""/DAEMON_CONF=\/etc\/hostapd\/hostapd\.conf/g' /etc/default/hostapd

# hostapd conf file
# TODO: Config stuff (ssid, pass, wpa type)
cp "`dirname $0`/config/hostapd.conf" /etc/hostapd/hostapd.conf

# Edit dhcpcd so wlan0 gets managed by /etc/network/interfaces
echo "denyinterfaces wlan0" >> /etc/dhcpcd.conf
