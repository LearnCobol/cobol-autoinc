#!/usr/bin/env bash

if curl -s -m 10 https://www.google.com/ > /dev/null ; then
    echo "Running 'apt-get update'. May take a while..."
    apt-get update

    # Dev tools
    sudo apt-get install -y git
    sudo apt-get install -y apache2
    sudo a2enmod userdir rewrite cgi
    sudo service apache2 restart

    # Useful utils
    #sudo apt-get install -y htop
else
    echo "Download test failed. Are you on Visigoth?"
    echo "You should probably delete this image and start over."
    exit 1
fi
