FROM nginx:1.13

RUN apt-get update\
    && apt-get install certbot procps -y\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/cache/nginx/proxy

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/site.tmpl /etc/nginx/conf.d/site.tmpl

COPY run.sh /run.sh
COPY certbot-renew.sh /etc/cron.d/certbot-renew.sh

CMD ["/run.sh"]

VOLUME /etc/letsencrypt

ENV CERTBOT_EMAIL="your-email@example.com"
ENV DOMAIN="example.com subdomain.example.com"
ENV PROXY="http://127.0.0.1 http://127.0.0.2"

EXPOSE 443
