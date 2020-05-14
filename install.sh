#!/bin/bash
apt-get update && apt-get dist-upgrade -y && apt autoremove -y
apt-get -y install unzip
wget https://github.com/krdesigns-com/raspbian-install/archive/master.zip
unzip /root/master.zip -d /root/
result=`ls -F /root/ | grep /`
mv /root/$result/* /root/
rm -r /root/$result
chmod +x /root/*.sh
chmod +x /root/nginx-conf/*.sh
chmod +x /root/install-apps/*.sh
chmod +x /root/hass/*.sh
rm /root/master.zip
/root/main.sh
rm /root/main.sh
