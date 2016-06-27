#!/bin/sh -e
# set -x

CAROOT=/keys
mkdir -p ${CAROOT}/ca.db.certs   # Signed certificates storage
touch ${CAROOT}/ca.db.index      # Index of signed certificates
echo 01 > ${CAROOT}/ca.db.serial # Next (sequential) serial number

# Configuration
cat>${CAROOT}/ca.conf<<'EOF'
[ ca ]
default_ca = ca_default

[ ca_default ]
dir = REPLACE_LATER
certs = $dir
new_certs_dir = $dir/ca.db.certs
database = $dir/ca.db.index
serial = $dir/ca.db.serial
RANDFILE = $dir/ca.db.rand
certificate = $dir/ca.crt
private_key = $dir/ca.key
default_days = 365
default_crl_days = 30
default_md = md5
preserve = no
policy = generic_policy
[ generic_policy ]
countryName = optional
stateOrProvinceName = optional
localityName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied
emailAddress = optional
EOF

sed -i "s|REPLACE_LATER|${CAROOT}|" ${CAROOT}/ca.conf

cd ${CAROOT}

openssl dhparam -out dhparam.pem 2048

# TODO: you should get these securely instead of generating
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=Denial/L=Anytown/O=Evil Corp/CN=www.example.com" 
openssl ca -batch -config ${CAROOT}/ca.conf -selfsign -keyfile server.key \
  -in server.csr -out server.crt -md sha512 \
  -startdate 00000101000000Z -enddate 99991231235959Z

SSH_KEY_PATH=~/.ssh/id_rsa
[ -f "$SSH_KEY_PATH" ] || ssh-keygen -t rsa -N "" -f $SSH_KEY_PATH
SSH_PUBLIC_KEY=$(cat "$SSH_KEY_PATH.pub")
>&2 echo "Please add this deploy key to all required repos you haven't already: $SSH_PUBLIC_KEY"