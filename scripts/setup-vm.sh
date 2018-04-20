#!/bin/bash

function install_docker_ee {
    docker_ee_subscription_id=${DOCKER_EE_SUBSCRIPTION_ID:-""}
    docker_ee_channel=${DOCKER_EE_CHANNEL:-"test-2.0"}

    echo "deb [arch=amd64] https://storebits.docker.com/ee/ubuntu/${docker_ee_subscription_id}/ubuntu $(lsb_release -cs) ${docker_ee_channel}" \
        | sudo tee /etc/apt/sources.list.d/docker-ee.list

    curl -fsSL "https://storebits.docker.com/ee/ubuntu/${docker_ee_subscription_id}/ubuntu/gpg" \
        | sudo apt-key add -

    sudo apt-get update
    sudo apt-get install -y docker-ee
    sudo adduser ubuntu docker
}

function ucp_manager {
    sudo docker container run --rm -it --name ucp \
        -v /var/run/docker.sock:/var/run/docker.sock \
        docker/ucp:3.0.0-beta3 \
            install \
            --host-address "$(curl http://instance-data/latest/meta-data/local-ipv4)" \
            --admin-password "${UCP_ADMIN_PASSWORD}" \
            --san "${UCP_HOSTNAMES}" \
            --license "$(cat /tmp/docker_subscription.lic)"
}

case $1 in
    "ucpmanager")
        install_docker_ee
        ucp_manager
        ;;
    "ucpnode")
        install_docker_ee
        ;;
esac

