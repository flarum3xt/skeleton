#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Set default value
#   cf_redis_port          = 6379
#   cf_redis_remote_access = false

cf_redis_port=${cf_redis_port:-6379}
cf_redis_remote_access=${cf_redis_remote_access:-false}

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
