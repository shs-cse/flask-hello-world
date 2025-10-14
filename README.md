This repo deployes a hello world flask web application (with SSL/TLS certificate) on a ubuntu system. 

# SSL/TLS Certificate Requirement
Before we start, if you are planing to get a certificate (for https communication), you will need a domain name. If you don't want to purchase one, you may use services like [duckdns](https://www.duckdns.org).

# Main Tools Used
- `nginx` web server
- `uv` for python package management
    - `flask` for web app creation
    - `gunicorn` as python WSGI (web server gateway interface)
    - `certbot` for SSL/TLS certificate management

# Main Guide
We will mainly follow [this medium article](https://medium.com/@kawsarlog/from-flask-to-live-deploying-your-app-with-nginx-gunicorn-ssl-and-custom-domain-1e8b57709fc0). But we will be using `uv` for python management and everything other than `nginx` will be installed at project level.


# Step 0: Clone Repo
- Create a folder (say `flask-hello-world`) and git clone this repo
```sh
mkdir flask-hello-world && cd "$_" && git clone https://github.com/shs-cse/flask-hello-world .
```


# Setp 1: Install Nginx
```sh
sudo apt install nginx -y
```
# Step 2: Configure Nginx
- Create a new Nginx configuration file for your Flask application:
    ```sh
    sudo nano /etc/nginx/sites-enabled/flask_app
    ```
- Get your `domain name read
