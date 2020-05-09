#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# Setting php www-conf for Raspbian Buster
# Basic script for server
###############################################################

version=`php -r "echo substr(PHP_VERSION, 0, 3);"`

rm /etc/php/$version/fpm/pool.d/www.conf

# Making a new parameter for FPM
cat <<EOF >/etc/php/$version/fpm/pool.d/www.conf
[krdesigns]

user = krdesigns
group = krdesigns

listen = /run/php/php$version-fpm.sock

listen.owner = www-data
listen.group = www-data
listen.mode = 0666

pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF

echo -e "FPM pool.d \e[32m[DONE]\033[0m"