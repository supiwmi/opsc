#!/bin/bash

# Step 1 — Installing Docker

sudo apt update

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update

apt-cache policy docker-ce

sudo apt install -y docker-ce

# sudo systemctl status docker

sudo systemctl enable docker

# Step 2 — Using the Docker Command
##### docker [option] [command] [arguments]

docker
docker info

# Step 3 — Working with Docker Images
docker run hello-world
