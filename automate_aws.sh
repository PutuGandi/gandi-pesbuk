#!/bin/bash

sudo apt update
unzip master.zip
sudo apt install nginx -y
sudo apt install php-fpm php-mysql -y
sudo rm -rf /var/www/html/*
apt-get install awscli
sudo apt-get install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure
make
sudo make install
cd
echo AKIAVFKGS24IU2MZN5JO:RRw61VpHNcpgA1u593OAOge8RYqUPr9gQiUzC9qj > /home/ubuntu/.passwd-s3fs
sudo chmod 600 /home/ubuntu/.passwd-s3fs
sudo s3fs sp2bucket /var/www/html -o passwd_file=/home/ubuntu/.passwd-s3fs
sudo cp -r ~/gandi-pesbuk-master/media-sosial/* /var/www/html/
sudo sed -i s/localhost/$1/g /var/www/html/config.php
sudo sed -i s/devopscilsy/$2/g /var/www/html/config.php
sudo sed -i s/1234567890/$3/g /var/www/html/config.php
sudo sed -i s/dbsosmed/$4/g /var/www/html/config.php
sudo unlink /etc/nginx/sites-enabled/default
sudo cp -r ~/gandi-pesbuk-master/default /etc/nginx/sites-available/
cd /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/default default
sudo nginx -t
sudo systemctl reload nginx
cd /var/www/html/
sudo mysql -h $1 -u$2 -p$3 $4 < dump.sql
