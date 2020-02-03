#!/bin/bash

sudo apt update
echo " "
echo "=================="
echo " Menginstall Nginx"
echo "=================="
sudo apt install nginx -y
echo " "
echo "=================="
echo " Menginstall MYSQL"
echo "=================="
sudo apt install mysql-server -y
echo " "
echo "============"
echo " Setup MYSQL"
echo "============"
#./mysql_setup.sh

MYSQL=`which mysql`
check="Select user,host from mysql.user;"
db_user="$1"
db_pass="$3"
db_name="$2"
sudo $MYSQL -uroot -p -e "$check" | grep -E "$db_user"
if [ $? -ne 0 ]; then
	echo " "
	echo "ANDA AKAN DIARAHKAN MEMBUAT USER DAN NAMA DATABASE"
	echo "ENTER SAJA"
	Q1="CREATE DATABASE IF NOT EXISTS $db_name;"
	Q2="GRANT ALL ON *.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass';"
	Q3="FLUSH PRIVILEGES;"
	SQL="${Q1}${Q2}${Q3}"
	sudo $MYSQL -uroot -p -e "$SQL"
	echo "Database '$db_name' dan user '$db_user' sudah dibuat dengan password-nya"
else
	echo "USERNAME SUDAH ADA"
fi


echo " "
echo "======================"
echo " Menginstall PHP-MYSQL"
echo "======================"
sudo apt install php-fpm php-mysql -y

sudo rm -rf /var/www/html/*

sudo cp -r ~/gandi-pesbuk-master/media-sosial/* /var/www/html/

#db_user=`sudo grep -E "^db_user" ~/gandi-pesbuk-master/mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2`
sudo sed -i s/devopscilsy/"$db_user"/g /var/www/html/config.php

#db_pass=`sudo grep -E "^db_pass" ~/gandi-pesbuk-master/mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2`
sudo sed -i s/1234567890/"$db_pass"/g /var/www/html/config.php

#db_name=`sudo grep -E "^db_name" ~/gandi-pesbuk-master/mysql_setup.sh | cut -d\= -f2 | cut -d\" -f2`
sudo sed -i s/dbsosmed/"$db_name"/g /var/www/html/config.php

sudo vim /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
cd /var/www/html/
echo ""
echo "==================="
echo "MASUKKAN PASS MYSQL"
echo "==================="
sudo mysql -u "$db_user" -p "$db_name" < dump.sql
echo ""
echo "---------"
echo " SELESAI "
echo "---------"

