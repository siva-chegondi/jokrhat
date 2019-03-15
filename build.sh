#!/bin/bash

## Declare all variables here
export AWS_PROFILE = "jokrhat"
ecr_image = "$AWS_ECR/jokrhat-blog:latest"

# Build website
hugo

# move caddy file to /public folder
cp ./Caddyfile /public

# login to ECR
aws ecr get-login --no-include-email --region us-east-1 > ./login.sh

chmod +x ./login.sh
bash login.sh

# remove login shell script after login
rm login.sh

# build docker image, building locally for testing
docker build -t jokrhat-blog .

# tag ECR for local image
docker tag jokrhat-blog $ecr_image

# push to ecr, uncomment to push
# docker push $ecr_image
