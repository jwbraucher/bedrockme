.PHONY: all run

TAG := 20251201-1
IMAGE := docker.io/braucher/bedrockme
ECR_IMAGE := 621353950768.dkr.ecr.us-east-1.amazonaws.com/braucher/bedrockme

build:
	docker buildx build --tag $(IMAGE):latest --tag $(IMAGE):$(TAG) --tag $(ECR_IMAGE):$(TAG) .

run: build
	docker run --init --rm -it $(IMAGE):$(TAG)

push: build
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 621353950768.dkr.ecr.us-east-1.amazonaws.com
	docker push $(ECR_IMAGE):$(TAG)
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):latest

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
