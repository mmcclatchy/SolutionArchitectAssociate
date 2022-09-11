#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<center><h1>This Amazon EC2 instance is App Group B</h1></center>" > /var/www/html/index.html
