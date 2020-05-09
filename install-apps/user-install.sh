#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# Making default user krdesigns for Raspbian Buster
# Basic script for server
###############################################################

userdel -r pi
sudo adduser --disabled-password --shell /bin/bash --gecos "krdesigns" krdesigns

echo -e "Create User KRDesigns \e[32m[DONE]\033[0m"