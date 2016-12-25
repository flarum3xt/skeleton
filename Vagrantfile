# -*- mode: ruby -*-
# vi: set ft=ruby :

my = {
  :cf_box_version           => "20161214.0.1"      ,
  :cf_hostname              => "flarum.dev"        ,
  :cf_timezone              => "UTC"               ,
  :cf_private_ip            => "10.10.10.10"       ,
  :cf_private_key_path      => "~/.ssh/id_rsa"     ,
  :cf_public_key_path       => "~/.ssh/id_rsa.pub" ,
  :cf_app_source_path       => "."                 ,

  # configuration for nginx or httpd service
  :cf_http_port             => 80                  ,
  :cf_http_user             => "www-data"          ,
  :cf_http_group            => "www-data"          ,

  # configuration for basic authentication
  :cf_basic_auth_enabled    => true                ,
  :cf_basic_auth_user       => "dev"               ,
  :cf_basic_auth_password   => "devpass"           ,

  # configuration for php-fpm service
  :cf_php_fpm_listen        => "/run/php/php7.0-fpm.sock",

  # configuration for mysqld service
  :cf_mariadb_root_password => "rootpass"          ,
  :cf_mariadb_port          => 3306                ,
  :cf_mariadb_remote_access => true                ,

  # configuration for redis-server service
  :cf_redis_port            => 6379                ,
  :cf_redis_remote_access   => true                ,

  # configuration for forwarded_port
  :cf_host_port_ssh         => 50022               ,
  :cf_host_port_http        => 50080               ,
  :cf_host_port_mariadb     => 53306               ,
  :cf_host_port_redis       => 56379               ,
};

recipes = [
  "common.sh",
  "nginx.sh",
  "mariadb.sh",
  "redis.sh",
  "php70.sh",
  "nodejs.sh",
  "cleanup.sh",
  "flarum.sh",
];

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  # Setting box version
  if my[:cf_box_version] then
    config.vm.box_version = my[:cf_box_version]
    config.vm.box_check_update = false
  else
    config.vm.box_check_update = true
  end

  # Setting forwarded port
  if my[:cf_host_port_ssh] then
    config.vm.network "forwarded_port", guest: 22, host: my[:cf_host_port_ssh], id: "ssh"
  end
  if my[:cf_host_port_http] then
    config.vm.network "forwarded_port", guest: my[:cf_http_port], host: my[:cf_host_port_http], id: "http"
  end
  if my[:cf_host_port_mariadb] then
    config.vm.network "forwarded_port", guest: my[:cf_mariadb_port], host: my[:cf_host_port_mariadb], id: "mariadb", disabled: !my[:cf_mariadb_remote_access]
  end
  if my[:cf_host_port_ssh] then
    config.vm.network "forwarded_port", guest: my[:cf_redis_port], host: my[:cf_host_port_redis], id: "redis", disabled: !my[:cf_redis_remote_access]
  end

  # Setting private ip
  if my[:cf_private_ip] then
    config.vm.network "private_network", ip: my[:cf_private_ip]
  end

  # Setting public ip
  if my[:cf_public_ip] then
    config.vm.network "public_network", ip: my[:cf_public_ip]
  end

  # Setting shared folders
  config.vm.synced_folder ".", "/vagrant", id: "core"
  config.vm.synced_folder my[:cf_app_source_path], "/app/source", id: "source", group: my[:cf_http_group], mount_options: ["dmode=775,fmode=775"]

  if my[:cf_private_key_path] && my[:cf_public_key_path] then
    # Using existed private key and do not generate a key
    config.ssh.insert_key = false
    config.ssh.private_key_path = [my[:cf_private_key_path], "~/.vagrant.d/insecure_private_key"]
    # Copy public key to VM
    config.vm.provision "file", source: my[:cf_public_key_path], destination: "~/.ssh/authorized_keys"
  end

  # Provision scripts
  recipes.each do |script|
    config.vm.provision :shell, :path => "./script/" + script, :privileged => false, :env => my, :name => script
  end

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    vb.name = my[:cf_hostname]

    # Customize the amount of memory on the VM:
    vb.cpus = 1
    vb.memory = "512"

    # Auto update vbguest if plugin "vagrant-vbguest" is installed
    if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.auto_update = true
    end
  end
end
