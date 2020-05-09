#!/bin/bash
###############################################################
#	  Created by Richard Tirtadji
#
#
#   NGINX-Proxy conf for Raspbian Buster
# 	Basic script for server
###############################################################

ROOTDIR=$1
HOST=$2
DOMAIN=$3
IP=$4
PORT=$5

while [[ $ROOTDIR = "" ]]; do
  read -p "Write the root directory eg. /home/krdesigns/public: " ROOTDIR
done

while [[ $HOST = "" ]]; do
  read -p "Write the host name, eg. krproject: " HOST
done

while [[ $DOMAIN = "" ]]; do
  read -p "Write the 1st level domain name without starting dot (.), eg. krdesigns.com: " DOMAIN
done

while [[ $IP = "" ]]; do
  read -p "Write the local-ip for that specific machine, eg. 127.0.0.1: " IP
done

while [[ $PORT = "" ]]; do
  read -p "Write the PORT for that specific application, eg. 3000: " PORT
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

	# reverse proxy
	location / {
	  proxy_pass http://$IP:$PORT;
		include custom-snippets/proxy.conf;
	}
}
EOF

certbot certonly --no-eff-email -m rtirtadji@gmail.com --agree-tos --no-redirect --nginx -d $HOST.$DOMAIN

# create link for nginx
ln -s /etc/nginx/sites-available/$HOST.$DOMAIN /etc/nginx/sites-enabled/$HOST.$DOMAIN
ln -s /etc/nginx/sites-available/ssl-$HOST.$DOMAIN /etc/nginx/sites-enabled/ssl-$HOST.$DOMAIN

service nginx restart

echo -e "NGINX Express Setup \e[32m[DONE]\033[0m"
