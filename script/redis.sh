#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

[[ ! -z $cf_redis_port ]]          && export cf_redis_port=3306
[[ ! -z $cf_redis_remote_access ]] && export cf_redis_remote_access=true

echo ">> Install Redis"
sudo apt-get install -y redis-server
sudo systemctl start redis-server
sudo systemctl enable redis-server

if [[ $cf_redis_remote_access == true ]]
then
  echo ">> Enable remote access Redis"
  sudo sed -i "s/^port\s*6379$/port $cf_redis_port/" /etc/redis/redis.conf
  sudo sed -i "s/^bind\s*127.0.0.1$/bind 0.0.0.0/" /etc/redis/redis.conf
  sudo ufw allow $cf_redis_port
  sudo systemctl restart redis-server
fi
