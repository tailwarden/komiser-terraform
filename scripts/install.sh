#!/bin/bash

sudo yum update
sudo yum install -y docker
sudo usermod -aG docker ec2-user
sudo systemctl enable docker
sudo systemctl start docker

sudo curl -L https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose