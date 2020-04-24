#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done


# install docker
curl https://get.docker.com | bash

# make sure docker  is started
service docker  restart
