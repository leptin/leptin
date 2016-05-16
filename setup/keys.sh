mkdir -p /keys
openssl dhparam -out /keys/dhparam.pem 2048
# TODO: you should get these securely instead of generating
openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
  -subj "/C=US/ST=Denial/L=Anytown/O=Evil Corp/CN=www.example.com" \
  -keyout /keys/server.key -out /keys/server.crt