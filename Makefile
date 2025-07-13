.PHONY: all

all:
	docker buildx build -t braucher/bedrockme:latest .
