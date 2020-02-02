#!/bin/bash

sudo apt update
sudo apt install unzip
sudo apt install nginx
sudo apt install mysql-server
./mysql_setup.sh
sudo apt install php-fpm php-mysql
sudo wget https://github.com/PutuGandi/gandi-pesbuk/archive/master.zip
unzip master.zip
sudo rm -rf /var/www/html/*
sudo cp gandi-pesbuk-master/media-sosial/* /var/www/html/
db_user=sudo grep -E "^db_user" mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2
sudo sed -i s/jopan/$db_user/g config.php 

