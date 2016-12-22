#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

[[ ! -z $cf_hostname ]] && export cf_hostname="flarum.dev"
[[ ! -z $cf_timezone ]] && export cf_timezone="UTC"

echo ">> Setting server's hostname"
sudo hostnamectl set-hostname $cf_hostname

echo ">> Setting server's timezone"
sudo timedatectl set-timezone $cf_timezone

if [[ -f /vagrant/script/chmodr.sh ]]
then
  echo ">> Install 'chmodr' command"
  sudo cp -f /vagrant/script/chmodr.sh /usr/bin/chmodr && \
  sudo chmod a+x /usr/bin/chmodr
fi

echo ">> Enable firewall"
sudo ufw allow proto tcp from any to any port 22
sudo ufw --force enable

echo ">> Install common packages"
sudo apt-get update -y
sudo apt-get install -y git curl wget tree nmap unzip
