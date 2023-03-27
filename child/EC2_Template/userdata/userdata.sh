#!/bin/bash

sudo yum update -y
sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo yum -y install httpd 
sudo yum -y install php 
sudo yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum -y install mysql-community-client --skip-broken
sudo yum -y install php-mysqlnd
sudo systemctl start httpd 
sudo systemctl enable httpd 
sudo systemctl start mysqld 
sudo systemctl enable mysqld 
if [ ! -f /var/www/html/lab-app.tgz ]; then
cd /var/www/html
wget https://aws-tc-largeobjects.s3-us-west-2.amazonaws.com/CUR-TF-200-ACACAD/studentdownload/lab-app.tgz
tar xvfz lab-app.tgz
chown apache:root /var/www/html/rds.conf.php
fi