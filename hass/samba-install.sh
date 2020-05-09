#!/bin/bash
###############################################################
# Created by Richard Tirtadji
#
#
# Samba-Install for for Raspbian Buster
# Basic script for server
###############################################################

apt install samba -y

pass=123456

mkdir /home/krdesigns/docker
chown -R krdesigns: /home/krdesigns/docker

cat <<EOF >>/etc/samba/smb.conf
[krdesigns]
  comment = Samba for hassio
  path = /home/krdesigns
  read only = no
  browsable = yes
  writeable = yes
  guest ok = no
  create mask = 0644
  directory mask = 0755
  force user = root
EOF

echo -e "$pass\n$pass" | smbpasswd -s -a krdesigns

service smbd restart
ufw allow Samba

echo -e "Samba Installed \e[32m[DONE]\033[0m"