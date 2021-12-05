FROM alpine:latest

# install caddy
RUN apk update && apk add --no-cache caddy

# get build of site
RUN mkdir -p /var/www/jokrhat && \
		mkdir -p /var/log

# copy site contents
COPY public/ /var/www/jokrhat/

# expose ssl port
EXPOSE 80

ENV CADDYPATH="/home/caddy"

# RUN caddy server
WORKDIR /var/www/jokrhat
CMD ["caddy", "run"]

