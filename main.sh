#!/bin/bash
###############################################################
#	  Created by Richard Tirtadji
#   Main installer for Raspbian Buster
# 	Basic script for server
###############################################################

# Setup time for my timezone
timedatectl set-timezone 'Asia/Jakarta'

# Ubuntu Update
apt-get update && apt-get dist-upgrade -y && apt autoremove -y
apt-get install -y git figlet lolcat debconf-utils curl wget gnupg2 ca-certificates lsb-release apt-transport-https

SSH_ROOT=~/.ssh

[ ! -d "$SSH_ROOT" ] && mkdir -p "$SSH_ROOT"
chmod 700 $SSH_ROOT 
cat <<EOF >$SSH_ROOT/authorized_keys
# Authorization created especially for KRDesigns.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDi/BE8HT1FtP0KlgV5ioV2vGOdfft4PXjdEp13mns6coY0QpxwXuo6kzBmVWRzdWXAJD1WoNFa23UifmBqKJxeE62W6wtd4leMF8LVgkc5vlxwFlPHCYnsaxvtEPrhWfO/fJmg+OAjnkc8DqaYl3NHJs9rz+LVQZmwg4FyWHU02Ydm3om4ZG5RIjxcm2bRaqfkY1r6H6fEY06gJGKTO/s0y/+181nofsYGD3GiWS+kfr4sMQkcNDYMdY4sDG/BSPPzBQL+9+bS6/tRJrr5pJRWr717Q1sXPjA/fk6ZNSq3MKPE6gD4RDsQE9/sT0wZy0gl5O/Cf7dguH01fuakxdKZFTfJyR/pat1Uxu54BgAGXIrpv0q3XXTyu1BSvb6UpGHXxN8iEgsLxSaOhqZGW/KoAiv/MV9rrUGsA8oZBtBEBsk0b41dmcK6cXsnPv4R8buQI9I8qoj8JTpUF/sptleixSSHy+tdGB9Z66yorjLpCWkvZB6gHJ4WwM/rvoUrqtTFiikW/wHG8rSl32gsT0Tou5d4mQGgTzSrwQm8MtnknpvRZFkFzQuy8Zz906o5ZTBp/HBp6sg+dQqGlCg/LGRuzrzIYvudUWu8mPfsQptWhVGGauW17LdSh44N49fYY9sw5yDgbk/YqOQtLfgllIVmKFegF4YY9Xxbzmwqdv5nKw== rtirtadji@Richards-MacBook-Pro.local
EOF

chmod 600 $SSH_ROOT/authorized_keys

sed -i 's/#\?\(PermitRootLogin\s*\).*$/\1 yes/' /etc/ssh/sshd_config
sed -i 's/#\?\(PermitEmptyPasswords\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(PasswordAuthentication\s*\).*$/\1 no/' /etc/ssh/sshd_config
sed -i 's/#\?\(Banner\s*\).*$/\1 \/etc\/issue.net/' /etc/ssh/sshd_config

echo "KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256" >> /etc/ssh/sshd_config
echo "MACs umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512" >> /etc/ssh/sshd_config

MOTD_ROOT=/root/motd

# Making MOTD
BANNER_F1=(/etc/update-motd.d/00*)
BANNER_F2=(/etc/update-motd.d/10*)
BANNER_F3=(/etc/update-motd.d/50*)
BANNER_F4=(/etc/update-motd.d/80*)

if [[ -f ${BANNER_F1[0]} ]]
then
  rm $BANNER_F1
fi

if [[ -f ${BANNER_F2[0]} ]]
then
  rm $BANNER_F2
fi

if [[ -f ${BANNER_F3[0]} ]]
then
  rm $BANNER_F3
fi

if [[ -f ${BANNER_F4[0]} ]]
then
  rm $BANNER_F4
fi

# Moving file MOTD
#cp /root/10-display-hostname /root/11-sysinfo /root/12-diskspace /root/13-service /root/14-fail2ban /etc/update-motd.d/
cp $MOTD_ROOT/* /etc/update-motd.d/ 
chmod +x /etc/update-motd.d/*

# Making a new banner
cat <<EOF >/etc/issue.net
###############################################################
#  Welcome to $HOSTNAME                 
#                                                             
#  All connections are monitored and recorded          
#                                                             
#  Disconnect IMMEDIATELY if you are not an authorized user!  
###############################################################
EOF

service ssh restart

rm -r $MOTD_ROOT
