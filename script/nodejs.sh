#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo ">> Install NodeJS 6.x"
sudo curl --silent --location https://deb.nodesource.com/setup_6.x | sudo /bin/bash -
sudo apt-get install -y nodejs
