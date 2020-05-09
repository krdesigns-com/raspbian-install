#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# Composer installer for Raspbian Buster
# Basic script for server
###############################################################
# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

echo -e "Installing Composer \e[32m[DONE]\033[0m"