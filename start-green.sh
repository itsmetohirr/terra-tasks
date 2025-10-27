#!/bin/bash

# Update packages
yum update -y

# Install Apache HTTP server
yum install -y httpd

# Enable and start web server
systemctl enable httpd
systemctl start httpd

# Create a simple HTML page based on environment
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Green Environment</title>
<style>
    body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
    h1 { color: #2E86C1; }
</style>
</head>
<body>
<h1>Green Environment</h1>
<p>This server is part of the Green deployment!</p>
</body>
</html>
EOF
