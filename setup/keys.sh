#!/bin/sh -e
# set -x

mkdir -p /keys
openssl dhparam -out /keys/dhparam.pem 2048

# TODO: you should get these securely instead of generating
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -subj "/C=US/ST=Denial/L=Anytown/O=Evil Corp/CN=www.example.com" \
  -keyout /keys/server.key -out /keys/server.crt

SSH_KEY_PATH=~/.ssh/id_rsa
[ -f "$SSH_KEY_PATH" ] || ssh-keygen -t rsa -N "" -f $SSH_KEY_PATH
SSH_PUBLIC_KEY=$(cat "$SSH_KEY_PATH.pub")
>&2 echo "Please add this public key to all required repos you haven't already: $SSH_PUBLIC_KEY"