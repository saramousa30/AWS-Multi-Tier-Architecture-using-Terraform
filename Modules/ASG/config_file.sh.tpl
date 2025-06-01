#!/bin/bash

# Install necessary packages: Nginx and MySQL client
sudo apt update -y
sudo apt install -y nginx
sudo apt install -y nginx mysql-client

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Create env file with DB credentials
cat > /home/ubuntu/db_env.sh <<EOF
export DB_HOST="${DB_HOST}"
export DB_USER="${DB_USER}"
export DB_PASS="${DB_PASS}"
export DB_NAME="${DB_NAME}"
EOF

# Set permissions and load env vars globally
chmod 644 /home/ubuntu/db_env.sh
echo "source /home/ubuntu/db_env.sh" | sudo tee -a /etc/profile

# Create a web page that includes DB info (omit sensitive details)
echo "<html><body><h1>Welcome to my Website..</h1>By: Sara Mousa</br>Hostname: $(hostname -f)</br>DB Host: \${DB_HOST}</br>DB Name: \${DB_NAME}</body></html>" | sudo tee /var/www/html/index.html

# Restart Nginx
sudo systemctl restart nginx

