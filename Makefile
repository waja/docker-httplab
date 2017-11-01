IMAGE_NAME := waja/httplab

build:
	docker build --rm -t $(IMAGE_NAME) .
	
run:
	@echo docker run --rm -it $(IMAGE_NAME) 
	
shell:
	docker run --rm -it --entrypoint sh $(IMAGE_NAME) -l

test: build
	@if ! [ "$$(docker run --rm -it waja/httplab --help | head -1 | cut -d' ' -f3 | cut -d':' -f1 | xargs basename)" = "httplab" ]; then exit 1; fi
