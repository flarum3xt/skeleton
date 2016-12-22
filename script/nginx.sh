#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

[[ ! -z $cf_http_port ]]  && export cf_http_port=80
[[ ! -z $cf_http_user ]]  && export cf_http_user="www-data"
[[ ! -z $cf_http_group ]] && export cf_http_group="www-data"

echo ">> Install NGINX"
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo ufw allow $cf_http_port
