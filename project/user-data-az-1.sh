#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
if [ -z "$EC2AZ" ]; then
  EC2AZ=undefined
fi
echo "<center><h1>This Amazon EC2 instance is located in Availability Zone: $EC2AZ </h1></center>" > /var/www/html/index.html
