FROM golang:1.12.0-alpine3.9 as helper

# add git support
RUN apk update && apk add --no-cache git

# clone caddy server and builds
RUN go get -u github.com/mholt/caddy && \
		go get -u github.com/caddyserver/builds

# now build it
RUN go run $GOPATH/src/github.com/mholt/caddy/caddy/build.go -goos=linux -goarch=amd64

FROM alpine:latest

# get caddy binary
COPY --from=helper $GOPATH/bin/caddy /usr/bin/caddy

# get build of site
COPY ./public/* /var/www/jokrhat

EXPOSE 443
ENTRYPOINT ["/var/www/jokrhat"]
CMD ["caddy"]

