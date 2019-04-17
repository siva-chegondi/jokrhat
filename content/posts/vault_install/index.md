---
title: "Vault Installation - Persistant storage"
publishDate: "2019-04-07"
date: "2019-04-07"
description: "Installation of vault with persistant storage"
---

**Hashicorp Vault**, solution to store secrets, certs, access tokens and sensitive data of your application. It exposes an API by which we can access secrets from our application.To know more about Vault, check out [docs](https://vaultproject.org/docs). Mainly vault is used in application deployment where we store our secret tokens, access keys outside of application source code and outside of deploy scripts.

In this post, we are going to develop Vault docker container to run vault. Also we are storing data in persistant volumes to persist contents even when we restart containers or when we use multiple containers to serve vault service.

_Assuming we already have attached and mounted volume to our host at the path `/data`._

First lets write config file to configure listener and file storage
{{<highlight hcl>}}
listener "tcp"  {
	address="0.0.0.0:8200"
	tls_disable=1
	# tls_key_file =
	# tls_cert_file =  
	max_request_size=3355443
	max_request_duration="45s"
}

// we should mount the file on /vault path
storage "file" {
	path="/vault/file"
}
{{</highlight>}}

we are using default vault:latest image from docker hub maintaining by hashicorp.
lets build the following following docker file as `custom-vault` image.

```
	docker build -t custom-vault .
```
{{<highlight docker>}}
	FROM vault:latest
	
	// adding config file
	ADD config.hcl /vault/config
{{</highlight>}}

Now we are going to write the docker compose file to deploy this service. Here we are mounting the volume and also if notice that `vault` need capability of **IPC_LOCK** to run. command accepts the subcommands of vault to execute, if you didn't specify anything by default dev server will be running which stores all data in-memory.
{{<highlight yaml>}}
version: 3
services:
 jokrstore:
  image: custom-vault:latest
  command: server
  ports:
  - "8200:8200"
  volumes:
  - "/data/vault:/vault"
  cap_add:
  - IPC_LOCK
{{</highlight>}}

Now run the above file as following and check out the `/data/vault` folder, new folders should be created at that path.

```
	$: sudo docker-compose up -d
	$: sudo ls /data/vault
```
{{<figure class="image-holder" src="/images/vault_dir.png" alt="vault directory contents">}}
