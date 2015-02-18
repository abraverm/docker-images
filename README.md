Eclipse
=======
This is a repository for building an Docker image of Eclipse.

Features
--------

 - Running with host X server (without SSH)
 - User home directory is available
 - Network directly connected (no port mapping)
 - Fonts from host
 - Persistent plugins ( plugins are kept in user home `~/.eclipse`)
 - Persistent configurations ( configuration is kept in user home `~/.eclipse`)


Specification
-------------

 - Fedora based image (latest stable)
 - Java 1.8

Quick Start
-----------

    git clone https://github.com/abraverm/docker-images.git
    cd docker-images && git checkout eclipse
    ./eclipse

Build image
-----------

    git clone https://github.com/abraverm/docker-images.git
    cd docker-images && git checkout eclipse
    ./build
