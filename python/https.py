import os

# Prompt for the domain name
domain = input("Enter the domain name: ")

# Define the Nginx configuration template
nginx_config = f"""
# Redirect all HTTP requests to HTTPS
server {{
    listen 80;
    server_name {domain}.test *.{domain}.test;
    return 301 https://$host$request_uri;
}}

# Handle HTTPS traffic
server {{
    listen 443 ssl;
    server_name {domain}.test *.{domain}.test;
    root "G:/Books-and-courses/Programming/laragon/www/{domain}.test/public";
    index index.html index.htm index.php;

    # Enable SSL
    ssl_certificate "G:/Books-and-courses/Programming/laragon/etc/ssl/laragon.crt";
    ssl_certificate_key "G:/Books-and-courses/Programming/laragon/etc/ssl/laragon.key";
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP;
    ssl_prefer_server_ciphers on;

    location / {{
        try_files $uri $uri/ /index.php$is_args$args;
        autoindex on;
    }}
    
    location ~ \\.php$ {{
        include snippets/fastcgi-php.conf;
        fastcgi_pass php_upstream;
        # fastcgi_pass unix:/run/php/php7.0-fpm.sock;
    }}

    charset utf-8;

    location = /favicon.ico {{ access_log off; log_not_found off; }}
    location = /robots.txt  {{ access_log off; log_not_found off; }}
    location ~ /\\.ht {{
        deny all;
    }}
}}
"""

# Define the file path
file_path = f"G:/Books-and-courses/Programming/laragon/etc/nginx/sites-enabled/{domain}-https.conf"

# Write the configuration to the file
with open(file_path, "w") as file:
    file.write(nginx_config)

print(f"Nginx configuration has been written to {file_path}")
