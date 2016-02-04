NAME = benchflow/base-images
VERSION = dev

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) -f Dockerfile .

test:
	docker run -ti --rm $(NAME):$(VERSION)