#!/bin/bash

## Declare all variables here
export AWS_PROFILE="jokrhat"
ecr_image="$AWS_ECR/jokrhat-blog:latest"
local=$1

# remove public/ folder
rm -rf public/

# move caddy file to /public folder
if [ "$local" = "local" ]
then
	# build local website
	hugo --config config-local.toml
	cp ./Caddyfile-local public/Caddyfile
else
	# Build website
	hugo
	cp ./Caddyfile public/
fi

# build docker image, building locally for testing
sudo docker build -t jokrhat-blog .

if [ "$local" != "local" ];then
	# login to ECR
	aws ecr get-login --no-include-email --region us-east-1 > login.sh
	sudo bash login.sh

	# remove login shell script after login
	rm login.sh

	# tag ECR for local image
	sudo docker tag jokrhat-blog $ecr_image

	# push to ecr, uncomment to push
	sudo docker push $ecr_image
fi

