#!/bin/bash

# ask user for domain name
echo -n "Please enter your domain name (e.g. abc.duckdns.org): "
read domain
echo "Hello, $domain!"

# install and configure nginx
sudo apt install nginx -y
echo "server {
    listen 80;
    server_name $domain;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}" > "/etc/nginx/sites-enabled/flask_app"
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t
sudo nginx -s reload

# install uv for python management
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc

# install flask, gunicorn, certbot
uv add flask gunicorn certbot certbot-nginx

# activate the venv environment so that 
# we don't have to write `uv run` before every command
source .venv/bin/activate

# run the flask web app in daemon background
gunicorn --workers=3 --bind 0.0.0.0:8000 app:app --daemon

# request for certification
certbot --nginx