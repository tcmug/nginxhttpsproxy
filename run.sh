#!/bin/bash

DOMAINS=($DOMAIN)
PROXIES=($PROXY)

# For some reason the certbot call fails for multiple domains, so we loop the domains instead.
for ((i=0;i<${#DOMAINS[@]};++i)); do

    echo "Getting certificates for ${DOMAINS[i]} => ${PROXIES[i]}"

    until certbot certonly --standalone --agree-tos --email $CERTBOT_EMAIL -n -d ${DOMAINS[i]}
    do
        sleep 5
    done

    sed -e "s~\$DOMAIN~${DOMAINS[i]}~g" -e "s~\$PROXY~${PROXIES[i]}~g" /etc/nginx/conf.d/site.tmpl > /etc/nginx/conf.d/${DOMAINS[i]}.conf
done

while true
do
    nginx -g "daemon off;"
    sleep 5
done

