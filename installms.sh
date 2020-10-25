#!/bin/bash

apt-get update
apt-get install -y curl nginx git unzip p7zip-full
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
apt-get install -y nodejs
npm install pm2 -g
cat > /etc/nginx/sites-available/your-domain.com <<EOF
server {
    listen 80;
    listen [::]:80;
    index index.html;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:7000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF
sudo rm /etc/nginx/sites-enabled/default
sudo ln -sf /etc/nginx/sites-available/your-domain.com /etc/nginx/sites-enabled/your-domain.com
sudo nginx -t
sudo systemctl restart nginx
sudo mkdir -p /home/web001
cd /home/web001
wget https://raw.githubusercontent.com/Dv-Server/jjfhuiewhfjeki/master/master.zip
7z  x  -pWzLqZ9Rz4RU master.zip
npm install
sudo apt install -y mongodb && mongo --eval 'db.runCommand({ connectionStatus: 1 })' && sudo systemctl restart mongodb && sudo systemctl enable mongodb
pm2 start --name Master node -- index
cd /root
#etc.
