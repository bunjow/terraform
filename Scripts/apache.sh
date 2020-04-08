#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install apache
apt-get update
apt-get -y install apache2

# make sure nginx is started
service apache2 restart
