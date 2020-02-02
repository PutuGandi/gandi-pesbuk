#!/bin/bash

MYSQL=`which mysql`
check="Select user,host from mysql.user;"
db_user="jopan"
db_pass="123"
db_name="Devops"
sudo $MYSQL -uroot -p -e "$check" | grep -E "$db_user"
if [ $? -ne 0 ]; then
	echo "ANDA AKAN DIARAHKAN MEMBUAT USER DAN NAMA DATABASE"
	Q1="CREATE DATABASE IF NOT EXISTS $db_name;"
	Q2="GRANT ALL ON *.* TO '$db_user'@'localhost' IDENTIFIED BY '$db_pass';"
	Q3="FLUSH PRIVILEGES;"
	SQL="${Q1}${Q2}${Q3}"
	sudo $MYSQL -uroot -p -e "$SQL"
	echo "Database '$db_name' dan user '$db_user' sudah dibuat dengan password-nya"
else
	echo "USERNAME SUDAH ADA"
fi

