#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# NGINX + PHP + Node installer for Raspbian Buster
# Basic script for server
###############################################################
CODE='lsb_release -sc'

~/install-apps/checking.sh

# Create user ranrinc
~/install-apps/user-install.sh

# Install NGINX
~/install-apps/nginx-install.sh

~/install-apps/php-install.sh

version=`php -r "echo substr(PHP_VERSION, 0, 3);"`

# Install Fail2Ban
~/install-apps/fail2ban-install.sh

# Install lets Encrypt
~/install-apps/certbot-install.sh

# Setup php.ini
~/install-apps/php-ini-install.sh

# Setup www.conf
~/install-apps/www-conf-install.sh

service nginx restart
service php$version-fpm restart

# Install Composer
~/install-apps/composer-install.sh

echo -e "NGINX PHP Node.js installation \e[32m[DONE]\033[0m"