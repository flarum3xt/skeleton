#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Set default value
#   cf_http_port  = 80
#   cf_http_user  = www-data
#   cf_http_group = www-data

cf_http_port=${cf_http_port:-80}
cf_http_user=${cf_http_user:-www-data}
cf_http_group=${cf_http_group:-www-data}

echo ">> Install NGINX"
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo ufw allow $cf_http_port
