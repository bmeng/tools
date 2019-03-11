#!/bin/bash

NEW_IMAGE=$1

if [[ -z $NEW_IMAGE ]]; then
  echo "Please provide a newer image for caddy!"
  echo "Usage: $0 NEW_IMAGE"
  exit 1
fi


docker stop caddy

docker rm -f caddy

docker run -d -p 443:443 -v /etc/caddy/Caddyfile:/etc/Caddyfile -v /var/www/caddy:/var/www/caddy -v /var/www/pullrss:/var/www/pullrss -v /etc/caddy/certs:/etc/caddycerts -v /var/log/caddy:/var/log --name caddy $NEW_IMAGE
