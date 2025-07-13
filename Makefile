.PHONY: all

all:
	docker buildx build \
  --tag docker.io/braucher/bedrockme:latest \
  --tag docker.io/braucher/bedrockme:0.0.1 \
  .
