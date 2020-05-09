#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# NGINX + PHP + Node installer for Raspbian Buster
# Basic script for server
###############################################################
# PHP standard 7.2 install
wget https://packages.sury.org/php/apt.gpg
apt-key add apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php7.list
apt update

apt install -y php7.2 php7.2-bcmath php7.2-bz2 php7.2-cgi php7.2-cli php7.2-common php7.2-curl php7.2-fpm php7.2-gd php7.2-intl php7.2-json php7.2-mbstring php7.2-mysql php7.2-soap php7.2-xml php7.2-zip

echo -e "PHP 7.2 installation \e[32m[DONE]\033[0m"