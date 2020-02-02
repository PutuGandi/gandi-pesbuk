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
sudo sed -i s/gandi/$db_user/g config.php

db_pass=sudo grep -E "^db_pass" mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2
sudo sed -i s/123/$db_pass/g config.php

db_name=sudo grep -E "^db_name" mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2
sudo sed -i s/dbpesbuk/$db_user/g config.php

sudo cat default > /etc/nginx/sites-enabled/default
cd /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
echo ""
echo "==================="
echo "MASUKKAN PASS MYSQL"
echo "==================+"
sudo mysql -u $db_user -p $db_pass < dump.sql
echo ""
echo "---------"
echo " SELESAI "
echo "---------"

