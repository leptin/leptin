server {
    server_name example.com;
    root /var/www/html;

    include https;
    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;

    include php;
}

server {
    listen 80;
    server_name example.com;
    return 301 https://$host$request_uri;
}