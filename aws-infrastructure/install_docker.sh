#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    Software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-cache madison docker-ce
sudo apt install docker.io
sudo apt install docker-compose

#This helps avoid typing sudo in the future
sudo usermod -a -G docker ubuntu