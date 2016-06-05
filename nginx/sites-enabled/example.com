server {
    server_name www.example.com;
    root /var/www/html;

    include https;
    include php;
}

server {
    listen 80;
    server_name www.example.com;
    return 301 https://$host$request_uri;
}