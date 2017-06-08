#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

function usage {
   echo "usage: $0 [ enable | disable ]"
   exit 1

}

if [ -z $1 ]; then
   usage
fi

if [ $1 != "enable" ] && [ $1 != "disable" ]; then
   usage
fi

if [ $1 == "enable" ]; then
   echo "Enabling Access Point"

   ifdown wlan0
   cp /etc/network/interfaces.host /etc/network/interfaces
   ifup wlan0

   service dnsmasq start
   service hostapd start
else
   echo "Disabling Access Point"

   service dnsmasq stop
   service hostapd stop

   ifdown wlan0
   cp /etc/network/interfaces.client /etc/network/interfaces
   ifup wlan0
fi
