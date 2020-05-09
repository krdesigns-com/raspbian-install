#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# NGINX Only installer for Raspbian Buster
# Basic script for server
###############################################################
# Create user ranrinc
~/install-apps/user-install.sh

# Install NGINX
~/install-apps/nginx-install.sh

# Install Fail2Ban
~/install-apps/fail2ban-install.sh

# Install lets Encrypt
~/install-apps/certbot-install.sh

echo -e "NGINX Server installation \e[32m[DONE]\033[0m"