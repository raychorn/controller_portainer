#!/bin/bash

# pihole -a -p

RESOLV=/etc/resolv.conf

#sudo systemctl disable systemd-resolved.service
#sudo systemctl stop systemd-resolved.service

if [ -f $RESOLV ]; then
    echo "Found $RESOLV"
    #rm -f $RESOLV
else
    cp ./etc_resolv.conf /etc/resolv.conf
fi

sudo service network-manager restart

docker-compose up -d
