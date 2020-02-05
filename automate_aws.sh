#!/bin/bash

sudo apt install nginx -y
sudo apt install php-fpm php-mysql -y
sudo rm -rf /var/www/html/*
sudo cp -r ~/gandi-pesbuk-master/media-sosial/* /var/www/html/
sudo sed -i s/localhost/$1/g /var/www/html/config.php
sudo sed -i s/devopscilsy/$2/g /var/www/html/config.php
sudo sed -i s/1234567890/$3/g /var/www/html/config.php
sudo sed -i s/dbsosmed/$4/g /var/www/html/config.php
crontab schedule
sudo unlink /etc/nginx/sites-enabled/default
sudo cp -r ~/gandi-pesbuk-master/default /etc/nginx/sites-available/
cd /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/default default
sudo nginx -t
sudo systemctl reload nginx
cd /var/www/html/
sudo mysql -h $1 -u$2 -p$3 $4 < dump.sql


