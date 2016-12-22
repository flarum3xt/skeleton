#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo ">> Install NodeJS 6.x"
sudo curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
sudo yum install -y nodejs npm yarn
