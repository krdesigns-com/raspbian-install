#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# SwapFile installer for Raspbian Buster
# Basic script for server
###############################################################
df -h
dd if=/dev/zero of=/swapfile bs=1M count=1024
mkswap /swapfile
chmod 600 /swapfile
swapon /swapfile
echo 'echo "/swapfile  none  swap  defaults  0  0" >> /etc/fstab' | sudo sh

echo -e "Creating SWAP File \e[32m[DONE]\033[0m"