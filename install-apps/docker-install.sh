#!/bin/bash
###############################################################
#	Created by Richard Tirtadji
#
#
# Docker & Docker-Compose installer for Raspbian Buster
# Basic script for server
###############################################################
## Begin Docker Installation
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Making user
usermod -aG docker krdesigns

# Install Docker-Compose
apt-get install -y libffi-dev libssl-dev
apt-get install -y python3 python3-pip
pip3 install docker-compose

echo -e "Docker and Docker-Compose Installed \e[32m[DONE]\033[0m"