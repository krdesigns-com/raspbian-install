#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# NGINX + NODE installer for Raspbian Buster
# Basic script for server
###############################################################
~/install-apps/checking.sh

# Create user ranrinc
~/install-apps/user-install.sh

# Install NGINX
~/install-apps/nginx-install.sh

# Install Fail2Ban
~/install-apps/fail2ban-install.sh

# Install lets Encrypt
~/install-apps/certbot-install.sh

# Install node and NPM
apt install -y nodejs npm

service nginx restart

echo -e "NGINX Node.js installation \e[32m[DONE]\033[0m"