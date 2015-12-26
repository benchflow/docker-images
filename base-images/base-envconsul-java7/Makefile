NAME = benchflow/base-image-envconsul-java7
# will follow the envconsul version
VERSION = dev

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) -f Dockerfile .