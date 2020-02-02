#!/bin/bash

sudo apt update
#sudo apt install unzip
sudo apt install nginx
sudo apt install mysql-server
./mysql_setup.sh
sudo apt install php-fpm php-mysql
#sudo wget https://github.com/PutuGandi/gandi-pesbuk/archive/master.zip
#unzip master.zip
sudo rm -rf /var/www/html/*
sudo cp -r gandi-pesbuk-master/media-sosial/* /var/www/html/

db_user=`sudo grep -E "^db_user" mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2`
sudo sed -i s/devopscilsy/$db_user/g /var/www/html/config.php

db_pass=`sudo grep -E "^db_pass" mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2`
sudo sed -i s/1234567890/$db_pass/g /var/www/html/config.php

db_name=`sudo grep -E "^db_name" mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2`
sudo sed -i s/dbsosmed/$db_name/g /var/www/html/config.php

#sudo cat default > /etc/nginx/sites-enabled/default
sudo vim /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
cd /var/www/html/
echo ""
echo "==================="
echo "MASUKKAN PASS MYSQL"
echo "==================="
sudo mysql -u $db_user -p $db_name < dump.sql
echo ""
echo "---------"
echo " SELESAI "
echo "---------"

