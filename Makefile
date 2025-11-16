.PHONY: all run

IMAGE := docker.io/braucher/bedrockme:latest
ECR_IMAGE := 621353950768.dkr.ecr.us-east-1.amazonaws.com/braucher/bedrockme:20251116-1

build:
	docker buildx build --tag $(IMAGE) --tag $(ECR_IMAGE) .

run: build
	docker run --init --rm -it --env MODE=print $(IMAGE)

lambda: build
	docker run --init --rm -it \
    -v ~/.aws-lambda-rie:/aws-lambda -p 9000:8080 \
    --entrypoint /aws-lambda/aws-lambda-rie \
    $(IMAGE) \
    /usr/local/bin/npx aws-lambda-ric index.handler

lambda-local:
	curl -XPOST -d'{}' http://localhost:9000/2015-03-31/functions/function/invocations
	@echo

lambda-aws:
	curl -XPOST -d'{}' https://tq4z3szpyn5rdnhnip4cgbloya0pykok.lambda-url.us-east-1.on.aws/
	@echo
