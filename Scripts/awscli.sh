#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install mysql client
apt-get update
apt-get -y install python-pip
pip install awscli
