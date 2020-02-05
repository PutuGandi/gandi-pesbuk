#!/bin/bash

sudo apt update
sudo apt install unzip
sudo apt install vim
sudo sudo wget https://github.com/PutuGandi/gandi-pesbuk/archive/master.zip
unzip master.zip
sudo apt install nginx -y
sudo apt install mysql-server -y
MYSQL=`which mysql`
mysql_user="root"
mysql_pass="password"
db_user="putu"
db_pass="lubakgen"
db_name="dbWeb"
Q1="CREATE DATABASE IF NOT EXISTS $db_name;"
Q2="GRANT ALL ON *.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"
sudo $MYSQL -u$mysql_user -p$mysql_pass -e "$SQL"
sudo apt install php-fpm php-mysql -y
sudo rm -rf /var/www/html/*
sudo cp -r ~/gandi-pesbuk-master/media-sosial/* /var/www/html/
sudo sed -i s/devopscilsy/"$db_user"/g /var/www/html/config.php
sudo sed -i s/1234567890/"$db_pass"/g /var/www/html/config.php
sudo sed -i s/dbsosmed/"$db_name"/g /var/www/html/config.php
sudo unlink /etc/nginx/sites-enabled/default
sudo cp -r ~/gandi-pesbuk-master/default /etc/nginx/sites-available/
cd /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/default default
sudo nginx -t
sudo systemctl reload nginx
cd /var/www/html/
sudo mysql -u$db_user -p$db_pass $db_name < dump.sql

