.PHONY: all run

IMAGE := docker.io/braucher/bedrockme:latest

build:
	docker buildx build --tag $(IMAGE) .

run: build
	docker run --init --rm -it $(IMAGE)

lambda:
	docker run --init --rm -it \
    -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
    --entrypoint /aws-lambda/aws-lambda-rie \
    $(IMAGE) \
    /usr/local/bin/npx aws-lambda-ric index.handler
