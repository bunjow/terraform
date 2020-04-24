#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install mysql client
apt-get update
apt-get -y install mysql-client

#mysql -u root -h <aws_db_instance.mariadb.endpoint> -p <RDS_PASSWORD>
