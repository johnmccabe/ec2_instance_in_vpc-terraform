#!/bin/sh
apt -y update
apt -y install nginx
rm -rf /var/www/html/index.html
echo "<html><head><title>Installed by Terraform</title></head><body><h1>INSTALLED BY TERRAFORM</h1></body></html>" > /var/www/html/index.html