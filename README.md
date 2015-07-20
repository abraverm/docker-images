# Puppet development environment
This is a template for development and testing Puppet modules with Docker.
This repository contains a puppet master and agent images based on Fedora.
Using Docker-Compose and tiller, developer can easily create puppet environment.
Tiller used for configuring and Docker-Compose is used for starting the environment.

## Quick-start:

    docker-compose up -d
    docker logs dockerimages_puppetnode_1
    docker logs dockerimages_puppetmaster_1
