#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# MySQL installer for Raspbian Buster
# Basic script for server
###############################################################
~/install/checking.sh

MYSQLPASSWORD="$(openssl rand -base64 14)"

apt-get install -y mysql-server # Or MySQL: sudo apt-get install mysql-server

# Making the password container
cat <<EOF >~/.mysql_root_password.cnf
[client]
password=$MYSQLPASSWORD
EOF

# Securing mysql unattended
mysql_secure_installation --defaults-extra-file=~/.mysql_root_password.cnf --use-default

# Removing the password
rm ~/.mysql_root_password.cnf

mysql -u root -p$MYSQLPASSWORD -e "use mysql; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQLPASSWORD';FLUSH PRIVILEGES;"

cat <<EOF >~/.mysqlrootpass
$MYSQLPASSWORD
EOF

service mysql restart

echo -e "Your mySQL root password is \e[32m $MYSQLPASSWORD \033[0m"
echo -e "mySQL installation \e[32m[DONE]\033[0m"
