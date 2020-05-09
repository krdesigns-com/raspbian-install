#!/bin/bash
###############################################################
#   Created by Richard Tirtadji
#
#
#   NGINX-PHP conf for Raspbian Buster
# 	Basic script for server
###############################################################

ROOTDIR=$1
HOST=$2
DOMAIN=$3

while [[ $ROOTDIR = "" ]]; do
  read -p "Write the root directory eg. /home/krdesigns/project: " ROOTDIR
done

read -p "Is this your main domain e.g. www (y/n): " MAIN

if [ "$MAIN" != "${MAIN#[Yy]}" ] ;then

  HOST=www

  while [[ $DOMAIN = "" ]]; do
    read -p "Write the 1st level domain name without starting dot (.), eg. krdesigns.com: " DOMAIN
  done

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/$DOMAIN
server {
  listen 80;

  server_name $DOMAIN $HOST.$DOMAIN; 

  location / {
    return 301 https://$HOST.$DOMAIN\$request_uri;
  }
}
EOF

# Making a NGINX.conf
cat <<EOF >/etc/nginx/sites-available/ssl-$DOMAIN
server {
  listen 443 ssl http2;

  server_name $HOST.$DOMAIN; 
  root $ROOTDIR; 
  #include /etc/phpmyadmin/nginx.conf;

  # SSL
  ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/$DOMAIN/chain.pem;

  # security
  include custom-snippets/security.conf;

  # logging
  access_log /var/log/nginx/$DOMAIN-access.log; 
  error_log /var/log/nginx/$DOMAIN-error.log;

  # index.php
  index index.php;

  # index.php fallback
  location / {
	  try_files \$uri \$uri/ /index.php?\$query_string;
  }

  # handle .php
  location ~ \.php$ {
	  include custom-snippets/fastcgi.conf;
  }
}

# subdomains redirect
  server {
  listen 443 ssl http2;

  server_name $DOMAIN;

  # SSL
  ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;
  ssl_trusted_certificate /etc/letsencrypt/live/$DOMAIN/chain.pem;

  return 301 https://$HOST.$DOMAIN\$request_uri; 
}
EOF

certbot certonly --no-eff-email -m rtirtadji@gmail.com --agree-tos --no-redirect --nginx -d $DOMAIN -d $HOST.$DOMAIN

# create link for nginx
ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN
ln -s /etc/nginx/sites-available/ssl-$DOMAIN /etc/nginx/sites-enabled/ssl-$DOMAIN

else

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
  #include /etc/phpmyadmin/nginx.conf;

	# SSL
  ssl_certificate /etc/letsencrypt/live/$HOST.$DOMAIN/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/$HOST.$DOMAIN/privkey.pem;
	ssl_trusted_certificate /etc/letsencrypt/live/$HOST.$DOMAIN/chain.pem;

	# security
	include custom-snippets/security.conf;

	# logging
  access_log /var/log/nginx/$HOST.$DOMAIN-access.log; 
  error_log /var/log/nginx/$HOST.$DOMAIN-error.log;

	# index.php
	index index.php;

	# index.php fallback
	location / {
		try_files \$uri \$uri/ /index.php?\$query_string;
	}

	# handle .php
	location ~ \.php$ {
		include custom-snippets/fastcgi.conf;
	}
}
EOF

certbot certonly --no-eff-email -m rtirtadji@gmail.com --agree-tos --no-redirect --nginx -d $HOST.$DOMAIN

# create link for nginx
ln -s /etc/nginx/sites-available/$HOST.$DOMAIN /etc/nginx/sites-enabled/$HOST.$DOMAIN
ln -s /etc/nginx/sites-available/ssl-$HOST.$DOMAIN /etc/nginx/sites-enabled/ssl-$HOST.$DOMAIN

fi

service nginx restart

echo -e "NGINX PHP Setup \e[32m[DONE]\033[0m"
