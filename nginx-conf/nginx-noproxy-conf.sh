#!/bin/bash
###############################################################
#	  Created by Richard Tirtadji
#
#
#   NGINX-NoProxy nginx.conf for Raspbian Buster
# 	Basic script for server
###############################################################

ROOTDIR=$1
HOST=$2
DOMAIN=$3

while [[ $ROOTDIR = "" ]]; do
  read -p "Write the root directory eg. /home/krdesigns/project: " ROOTDIR
done

while [[ $HOST = "" ]]; do
  read -p "Write the host name, eg. krproject: " HOST
done

while [[ $DOMAIN = "" ]]; do
  read -p "Write the 1st level domain name without starting dot (.), eg. krdesigns.com: " DOMAIN
done

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/$HOST.$DOMAIN
server {
	listen 80;

	server_name $HOST.$DOMAIN; 

	location / {
      return 301 https://\$host\$request_uri;
	}
}
EOF

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/ssl-$HOST.$DOMAIN
server {
	listen 443 ssl http2;

  server_name $HOST.$DOMAIN; 
  root $ROOTDIR; 

  access_log /var/log/nginx/$HOST.$DOMAIN-access.log; 
  error_log /var/log/nginx/$HOST.$DOMAIN-error.log;

	# SSL
  ssl_certificate /etc/letsencrypt/live/$HOST.$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$HOST.$DOMAIN/privkey.pem;
	ssl_trusted_certificate /etc/letsencrypt/live/$HOST.$DOMAIN/chain.pem;

	# security
	include custom-snippets/security.conf;

	# index.html fallback
	location / {
		try_files \$uri \$uri/ /index.html;
	}
}
EOF

certbot certonly --no-eff-email -m rtirtadji@gmail.com --agree-tos --no-redirect --nginx -d $HOST.$DOMAIN

# create link for nginx
ln -s /etc/nginx/sites-available/$HOST.$DOMAIN /etc/nginx/sites-enabled/$HOST.$DOMAIN
ln -s /etc/nginx/sites-available/ssl-$HOST.$DOMAIN /etc/nginx/sites-enabled/ssl-$HOST.$DOMAIN

service nginx restart

echo -e "NGINX React Setup \e[32m[DONE]\033[0m"
