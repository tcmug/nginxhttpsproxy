FROM nginx:1.13

RUN apt-get update\
    && apt-get install certbot -y\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/cache/nginx/proxy

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/site.tmpl /etc/nginx/conf.d/site.tmpl

COPY run.sh /run.sh
COPY renew.sh /etc/cron.daily/run.sh

CMD ["/run.sh"]

VOLUME /etc/letsencrypt

ENV CERTBOT_EMAIL="your-email@example.com"
ENV DOMAIN="example.com subdomain.example.com"
ENV PROXY="http://127.0.0.1 http://127.0.0.2"

EXPOSE 443
