#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

[[ ! -z $cf_mariadb_root_password ]] && export cf_mariadb_root_password="rootpass"
[[ ! -z $cf_mariadb_port ]]          && export cf_mariadb_port=3306
[[ ! -z $cf_mariadb_remote_access ]] && export cf_mariadb_remote_access=true

# install mariadb
echo ">> Install MariaDB"
sudo apt-get install -y mariadb-server mariadb-client
sudo systemctl start mysql
sudo systemctl enable mysql

# allow remote access (required to access from our private network host. Note that this is completely insecure if used in any other way)
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$cf_mariadb_root_password' WITH GRANT OPTION;"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$cf_mariadb_root_password' WITH GRANT OPTION;"
mysql -u root -p$cf_mariadb_root_password -e "DROP DATABASE IF EXISTS test;"
mysql -u root -p$cf_mariadb_root_password -e "FLUSH PRIVILEGES;"
# Fix MariaDB login issue when it says - Access denied for user 'root'@'localhost'
mysql -u root -p$cf_mariadb_root_password -D mysql -e "UPDATE user SET plugin='' WHERE user='root'; FLUSH PRIVILEGES;"

if [[ $cf_mariadb_remote_access == true ]]
then
  echo ">> Enable remote access MariaDB"
  sudo sed -i "s/^port\s*=.*/port=$cf_mariadb_port/" /etc/mysql/mariadb.conf.d/50-server.cnf
  sudo sed -i "s/^bind\-address\s*=.*/bind-address=0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
  sudo ufw allow $cf_mariadb_port
  sudo systemctl restart mysql
fi
