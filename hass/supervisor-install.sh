#!/bin/bash
###############################################################
# Created by Richard Tirtadji
#
#
# HASS-Supervisor for for Raspbian Buster
# Basic script for server
###############################################################

apt-get install apparmor-utils avahi-daemon dbus jq network-manager socat -y

curl -sL https://raw.githubusercontent.com/krdesigns-com/supervised-installer/master/installer.sh | bash -s -- -m raspberrypi4