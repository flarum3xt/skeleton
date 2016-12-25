#!/bin/bash

# Set default value
cf_mariadb_root_password=${cf_mariadb_root_password:-rootpass}

echo ">> Configure NGINX vhost"
sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -ns /app/source/config/vhost-nginx.conf /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

echo ">> Create database"
mysql -u root -p$cf_mariadb_root_password -e "CREATE DATABASE IF NOT EXISTS flarum;"
mysql -u root -p$cf_mariadb_root_password -e "GRANT ALL ON flarum.* TO 'flarum'@'%' IDENTIFIED BY 'flarum';"
mysql -u root -p$cf_mariadb_root_password -e "GRANT ALL ON flarum.* TO 'flarum'@'localhost' IDENTIFIED BY 'flarum';"

echo ">> Setup application"
cd /app/source/
composer install -vvv --no-progress --no-suggest --no-scripts --prefer-dist
composer run-script post-root-package-install
composer dump-autoload
php flarum install --defaults