#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# Set default value
#   cf_http_port  = 80
#   cf_http_user  = www-data
#   cf_http_group = www-data

cf_http_port=${cf_http_port:-80}
cf_http_user=${cf_http_user:-www-data}
cf_http_group=${cf_http_group:-www-data}

echo ">> Install PHP7.0"
sudo apt-get install -y php-fpm php-cli php-common php-mbstring php-xml php-curl php-mcrypt php-pdo php-mysqlnd php-redis php-gd
sudo systemctl start php7.0-fpm
sudo systemctl enable php7.0-fpm

echo ">> Install Composer"
curl -sSL https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod a+x /usr/local/bin/composer

# TODO: set listen from IP of Unix Socket
echo ">> Configure and secure PHP"
PHP_FPM_CONF_PATH=/etc/php/7.0/fpm
sudo sed -i "s/^;date\.timezone\s*=.*/date.timezone=$cf_timezone/" $PHP_FPM_CONF_PATH/php.ini && \
sudo sed -i "s/^;cgi\.fix_pathinfo\s*=.*/cgi.fix_pathinfo=0/" $PHP_FPM_CONF_PATH/php.ini && \
sudo sed -i "s/^short_open_tag\s*=.*/short_open_tag=On/" $PHP_FPM_CONF_PATH/php.ini && \
sudo sed -i "s/^;daemonize\s*=.*/daemonize=no/" $PHP_FPM_CONF_PATH/php-fpm.conf && \
#sudo sed -i "s/^listen\s*=.*/listen=$cf_php_fpm_listen/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
#sudo sed -i "s/^user\s*=.*/user=$cf_http_user/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
#sudo sed -i "s/^group\s*=.*/group=$cf_http_group/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
sudo sed -i "s/^listen\.allowed_clients\s*=.*/listen.allowed_clients=127.0.0.1/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
sudo sed -i "s/^;catch_workers_output\s*=.*/catch_workers_output=yes/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
sudo sed -i "s/^php_admin_flag\[log_errors\]\s*=.*/;php_admin_flag[log_errors] =/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
sudo sed -i "s/^php_admin_value\[error_log\]\s*=.*/;php_admin_value[error_log] =/" $PHP_FPM_CONF_PATH/pool.d/www.conf && \
sudo sed -i "s/^;php_admin_value\[display_errors\]\s*=.*/php_admin_value[display_errors] = 'stderr'/" $PHP_FPM_CONF_PATH/pool.d/www.conf
sudo systemctl restart php7.0-fpm
