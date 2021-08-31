#!/bin/bash

#services:
#  pihole:
#    container_name: pihole
#    image: pihole/pihole:latest
#    ports:
#      - '53:53/tcp'
#      - '53:53/udp'
#      - '67:67/udp'
#      - '8088:80/tcp'
#      - '4438:443/tcp'
#    environment:
#      TZ: 'America/Denver'
#      DNS1: 8.8.8.8
#      DNS2: 1.1.1.1
#    volumes:
#       - "etc_pihole:/etc/pihole/"
#       - "etc_dnsmasq_d:/etc/dnsmasq.d/"
#    deploy:
#      resources:
#        limits:
#          cpus: '4.0'
#          memory: 512M
#    dns:
#      - 127.0.0.1
#      - 1.1.1.1
#      - 8.8.8.8
#      - 9.9.9.9
#    cap_add:
#      - NET_ADMIN
#    tty: true
#    stdin_open: true
#    logging:
#        options:
#            max-size: 1g
#    restart: unless-stopped

#volumes:
#  etc_pihole:
#    external: true
#  etc_dnsmasq_d:
#    external: true


docker run \
--name=pihole \
-e TZ=America/Denver \
-e WEBPASSWORD=sisko@7660$boo \
-e SERVERIP=10.0.0.196 \
-v etc_pihole:/etc/pihole \
-v etc_dnsmasq_d:/etc/dnsmasq.d \
-p 8088:80 \
-p 53:53/tcp \
-p 53:53/udp \
--restart=unless-stopped \
pihole/pihole:latest