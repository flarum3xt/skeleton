#!/bin/bash

echo ">> Configure NGINX vhost"
sudo rm -f /etc/nginx/sites-enabled/default
sudo cp -f /vagrant/script/nginx_vhost.conf /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

echo ">> Create database"
mysql -u root -p$cf_mariadb_root_password -e "CREATE DATABASE IF NOT EXISTS homestead;"
mysql -u root -p$cf_mariadb_root_password -e "GRANT ALL ON homestead.* TO 'homestead'@'%' IDENTIFIED BY 'secret';"
mysql -u root -p$cf_mariadb_root_password -e "GRANT ALL ON homestead.* TO 'homestead'@'localhost' IDENTIFIED BY 'secret';"

echo ">> Setup application"
cd /app/source
composer install -vvv --no-progress --no-suggest --no-scripts
composer run-script post-root-package-install
composer run-script post-create-project-cmd
composer run-script post-install-cmd
php artisan cache:clear
php artisan config:clear
php artisan migrate --force --seed