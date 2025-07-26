#!/bin/bash

# 1. Update & install Apache and AWS CLI
sudo yum update -y
sudo yum install -y httpd awscli

# 2. Start Http
sudo systemctl start httpd
sudo systemctl enable httpd

# 3. Get instance ID
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# 4. Create index.html
cat <<EOF | sudo tee /var/www/html/index.html
<html>
  <head><title>SAY THE NAME SEVENTEEN !</title></head>
  <body>
    <h1>Hello, this is SCOUPS, Seventeen Carat and General leader</h1>
    <h2>Public IP: $PUBLIC_IP</h2>
  </body>
</html>
EOF