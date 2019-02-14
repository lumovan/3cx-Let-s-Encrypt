#!/usr/bin/env bash

curl https://get.acme.sh | sh

echo "Enter Cloudflare API Key: "
read apikey
export CF_Key="$apikey"

echo "Enter Cloudflare Mail: "
read cfmail
export CF_Email="$cfmail"

host=$(cat /etc/nginx/sites-enabled/3cxpbx | grep -m1 -Poe 'server_name \K[^; ]+')

/root/.acme.sh/acme.sh --issue -d $host --dns dns_cf

/root/.acme.sh/acme.sh --install-cert -d $host --cert-file /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$host-crt.pem --key-file /var/lib/3cxpbx/Bin/nginx/conf/Instance1/$host-key.pem --reloadcmd "service nginx force-reload ; service 3CXPhoneSystem01 stop ; service 3CXPhoneSystem01 start"
