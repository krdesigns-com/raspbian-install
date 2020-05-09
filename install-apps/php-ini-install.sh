#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# php.ini setup installer for Raspbian Buster
# Basic script for server
###############################################################

version=`php -r "echo substr(PHP_VERSION, 0, 3);"`

# Edit fpm/php.ini
sed -i "/^;date.timezone =.*$/s/^;//g" /etc/php/$version/fpm/php.ini
sed -i "s,^date.timezone =.*$,date.timezone = Asia/Jakarta," /etc/php/$version/fpm/php.ini

sed -i "/^;cgi.fix_pathinfo =.*$/s/^;//g" /etc/php/$version/fpm/php.ini
sed -i "s,^cgi.fix_pathinfo =.*$,cgi.fix_pathinfo = 0," /etc/php/$version/fpm/php.ini

sed -i "/^;phar.readonly =.*$/s/^;//g" /etc/php/$version/fpm/php.ini
sed -i "s,^phar.readonly =.*$,phar.readonly = Off," /etc/php/$version/fpm/php.ini

# Edit cli/php.ini
sed -i "/^;date.timezone =.*$/s/^;//g" /etc/php/$version/cli/php.ini
sed -i "s,^date.timezone =.*$,date.timezone = Asia/Jakarta," /etc/php/$version/cli/php.ini

sed -i "/^;cgi.fix_pathinfo =.*$/s/^;//g" /etc/php/$version/cli/php.ini
sed -i "s,^cgi.fix_pathinfo =.*$,cgi.fix_pathinfo = 0," /etc/php/$version/cli/php.ini

sed -i "/^;phar.readonly =.*$/s/^;//g" /etc/php/$version/cli/php.ini
sed -i "s,^phar.readonly =.*$,phar.readonly = Off," /etc/php/$version/cli/php.ini

# Edit cgi/php.ini
sed -i "/^;date.timezone =.*$/s/^;//g" /etc/php/$version/cgi/php.ini
sed -i "s,^date.timezone =.*$,date.timezone = Asia/Jakarta," /etc/php/$version/cgi/php.ini

sed -i "/^;cgi.fix_pathinfo =.*$/s/^;//g" /etc/php/$version/cgi/php.ini
sed -i "s,^cgi.fix_pathinfo =.*$,cgi.fix_pathinfo = 0," /etc/php/$version/cgi/php.ini

sed -i "/^;phar.readonly =.*$/s/^;//g" /etc/php/$version/cgi/php.ini
sed -i "s,^phar.readonly =.*$,phar.readonly = Off," /etc/php/$version/cgi/php.ini


echo -e "Setup php.ini for cli,fpm and cgi setup \e[32m[DONE]\033[0m"