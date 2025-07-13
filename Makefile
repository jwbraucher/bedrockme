.PHONY: all

all:
	docker buildx build -t jwbraucher/bedrockme:latest .
