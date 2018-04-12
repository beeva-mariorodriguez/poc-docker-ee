#!/bin/bash
docker_ee_subscription_id=${DOCKER_EE_SUBSCRIPTION_ID:-""}
docker_ee_channel=${DOCKER_EE_CHANNEL:-"test-2.0"}

echo "deb [arch=amd64] https://storebits.docker.com/ee/ubuntu/${docker_ee_subscription_id}/ubuntu $(lsb_release -cs) ${docker_ee_channel}" | sudo tee /etc/apt/sources.list.d/docker-ee.list

curl -fsSL "https://storebits.docker.com/ee/ubuntu/${docker_ee_subscription_id}/ubuntu/gpg" | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y docker-ee
sudo adduser ubuntu docker

