#!/bin/bash

MYSQL=`which mysql`
check="Select user,host from mysql.user;"
db_user="jopan"
db_pass="123"
db_name="Devops"
sudo $MYSQL -u root -p -e "$check" | grep -E "$db_user"
if [ $? -ne 0 ]; then
	echo ""
	echo "ANDA AKAN DIARAHKAN MEMBUAT USER DAN NAMA DATABASE"
	echo " ENTER SAJA "
	Q1="CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_pass';"
	Q2="GRANT ALL ON *.* TO '$db_user'@'localhost';"
	Q3="FLUSH PRIVILEGES;"
	SQL="${Q1}${Q2}${Q3}"
	sudo $MYSQL -u root -p -e "$SQL"
	K1="CREATE DATABASE $db_name"
	SQL2="${K1}"
	sudo $MYSQL -u $db_user -p -e "$SQL2"
	echo "Database '$db_name' dan user '$db_user' sudah dibuat dengan password-nya"
else
	echo "USERNAME SUDAH ADA"
fi

