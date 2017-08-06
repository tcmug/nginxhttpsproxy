# nginxhttpsproxy

## What is it?
This is a [Docker image](https://hub.docker.com/r/tcmug/nginxhttpsproxy/) based on the [official nginx image](https://hub.docker.com/_/nginx/). This image is automated to fetch a free SSL certificate ([Let's Encrypt](https://letsencrypt.org/) / [Certbot](https://certbot.eff.org/)) for the given domain(s) and to work as a proxy for the given urls. Note that there is NO AUTO RENEWAL configured yet, instead renewing can be done by simply recreating the container.

## Usage
### Single domain
```docker run -p 443:443 -p 80:80 --env DOMAIN=example.com --env PROXY=https://www.google.com --env CERTBOT_EMAIL=youremail@example.com tcmug/nginxhttpsproxy```
### Multiple domains
```docker run -p 443:443 -p 80:80 --env DOMAIN="example.com inbox.example.com" --env PROXY="https://www.google.com https://inbox.google.com" --env CERTBOT_EMAIL=youremail@example.com tcmug/nginxhttpsproxy```
### Self signed certificate for testing
```docker run -p 443:443 -p 80:80 --env DOMAIN="example.com inbox.example.com" --env PROXY="https://www.google.com https://inbox.google.com" --env MODE=test --env CERTBOT_EMAIL=youremail@example.com tcmug/nginxhttpsproxy```
### Storing certificates to the host machine
```docker run -p 443:443 -p 80:80 --env DOMAIN="example.com inbox.example.com" --env PROXY="https://www.google.com https://inbox.google.com" -v /home/username/certs:/etc/letsencrypt --env CERTBOT_EMAIL=youremail@example.com tcmug/nginxhttpsproxy```

## Environment variables

### CERTBOT_EMAIL
Certbot email address for important account notifications.
#### Example
```ENV DOMAIN=youremail@example.com```
### MODE
Set to test for testing. This makes certbot issue a self signed certificate.
#### Example
```ENV MODE=test```
### DOMAIN
The domain or domains you own and which is configured to the IP of the machine you're running docker on.
#### Example
```ENV DOMAIN=example.com google.example.com```
### PROXY
The host or hosts you wish to proxy, URL. Define one for each DOMAIN (1:1).
#### Example
```ENV PROXY=http://11.22.33.44 https://www.google.com```
