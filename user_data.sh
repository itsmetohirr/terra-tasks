#!/bin/bash
# ============================================================
# Startup script for EC2 launched by cmtr-o84gfl9h-template
# ============================================================

# Update system packages
yum update -y

# Install utilities and web server
yum install -y aws-cli httpd jq

# Enable and start the web server
systemctl enable httpd
systemctl start httpd

# ============================================================
# Retrieve instance metadata using IMDSv2 (token-based method)
# ============================================================

# Get a session token (valid for 6 hours)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Get the Instance ID and Private IP using the token
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/instance-id)

PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  -s http://169.254.169.254/latest/meta-data/local-ipv4)

# ============================================================
# Create the custom HTML page with instance information
# ============================================================
cat <<EOF > /var/www/html/index.html
<html>
  <head><title>EC2 Instance Info</title></head>
  <body style="font-family: Arial; text-align: center; margin-top: 50px;">
    <h1>This message was generated on instance</h1>
    <h2>$INSTANCE_ID</h2>
    <p>with the following private IP:</p>
    <h3>$PRIVATE_IP</h3>
  </body>
</html>
EOF

# ============================================================
# Restart Apache to ensure the new page is served
# ============================================================
systemctl restart httpd
