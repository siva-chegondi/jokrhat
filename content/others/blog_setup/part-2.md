---
title: "Blog Setup - Part 2"
description: "Blog deployment using caddy on AWS"
publishDate: "2019-03-18"
date: "2019-03-18"
categories: ["blog"]
tags: ["caddy", "aws"]
---

Here we are gonna discuss about [`caddy`][caddy_url] server which by default enables `tls` using ACME protocol and [letsencrypt][letsencrypt_url]

**ACME**:

- Automated certificate Management Environment (ACME), protocol to get signed certificates automatically with out human intervention, this complies identity verification, domain validation and terms acceptance.
	- Client sends a request for proving _domain ownership_ .
	-	Letsencrypt CA responses with challenges and nonce.
	- Client encrypts nonce with private key along with challenge response data.
	- Now CA downloads nonce and verify with client (agent) public key and response with success message.
- Once verification is done, ACME client creates Certificate Signing Request (CSR) to Certificate Authority supporting ACME ( assume letsencrypt ) for certificate. Now its job of CA to generate certificate and encrypt with ACME client public key.  

Above steps explain briefly, if you want to learn in detail check out [this](https://letsencrypt.org/how-it-works). Also please do watch following video for better understanding.
<div class="utube-player">
	{{<youtube ksqTu7TX83g>}}
</div>

**Caddy**:

- [Caddy][caddy_url] is a server which supports ACME protocol
- By default, caddy enables tls from [letsencrypt][letsencrypt_url] CA

Caddy configuration is concise, for example consider the following.  

**Please use staging for non-prod, else you will face certificate rate limit issue, for more information, check out [this](https://letsencrypt.org/docs/rate-limits/)**
{{<highlight bash>}}
# domain name
jokrhat.in

# root to contents
root 	/path/to/site-contents

# plugins
gzip
log 	/path/to/log

# enable tls, default letsencrypt
tls email@address

# for staging, use letsencrypt staging url
# tls email@address {
#		ca https://acme-staging-v02.api.letsencrypt.org/directory
# }
{{</highlight>}}
See its that simple, **first line should always be your domain**

You can also use caddy for development in local system, following is example configuration to run in your local system

{{<highlight bash>}}
# domain name
localhost:8080

# root to contents
root 	/path/to/site-contents

# plugins
gzip
log 	/path/to/log

# off tls to run on port 80
tls off 
{{</highlight>}}
[caddy_url]:https://caddyserver.org
[letsencrypt_url]:https://letsencrypt.org
