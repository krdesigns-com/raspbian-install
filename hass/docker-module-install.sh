#!/bin/bash
###############################################################
# Created by Richard Tirtadji
#
#
# Docker + HASS for Raspbian Buster
# Basic script for server
###############################################################

# Making Directory for docker container 
mkdir /home/krdesigns/docker/portainer
mkdir /etc/influxdb/
mkdir /home/krdesigns/docker/influxdb
mkdir /home/krdesigns/docker/grafana
mkdir /home/krdesigns/docker/motioneye
mkdir /home/krdesigns/docker/motioneye/recordings
mkdir /home/krdesigns/docker/home-assistant

# Make sure its running on the right folder
chown -R krdesigns: /home/krdesigns/docker/

# Installation portainer and watchtower
docker run --name="portainer" -d --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /home/krdesigns/docker/portainer:/data  portainer/portainer
docker run --name="watchtower" -d --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower

echo -e "Portainer and Watchtower installed \e[32m[DONE]\033[0m"

# Install influxdb
docker run --rm influxdb influxd config | sudo tee /etc/influxdb/influxdb.conf > /dev/null
docker run -d -p 8086:8086 --restart=always --net=host --name="influxdb" -v /etc/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf -v /home/krdesigns/docker/influxdb:/var/lib/influxdb influxdb -config /etc/influxdb/influxdb.conf

echo -e "InfluxDB installed \e[32m[DONE]\033[0m"

# Install grafana
docker run -d --user root --restart=always -p 3000:3000 --name="grafana" --net=host -v /home/krdesigns/docker/grafana:/var/lib/grafana grafana/grafana-arm64v8-linux

echo -e "Grafana installed \e[32m[DONE]\033[0m"

# Install motioneye
docker run -itd --restart=always --name="motioneye" --net=host -p 8765:8765 -v /etc/localtime:/etc/localtime:ro -v /home/krdesigns/docker/motioneye:/etc/motioneye -v /home/krdesigns/docker/motioneye/recordings:/var/lib/motioneye  ccrisan/motioneye:master-armhf

echo -e "MotionEye installed \e[32m[DONE]\033[0m"

# Install home-assistant
docker run -id --name="home-assistant" --restart=always -p 8123:8123 --net=host -e "TZ=Asia/Jakarta" -v /home/krdesigns/docker/home-assistant:/config -v /etc/letsencrypt/live:/certificate homeassistant/home-assistant

echo -e "Home-Assistant installed \e[32m[DONE]\033[0m"

echo -e "Docker Module installed \e[32m[DONE]\033[0m"