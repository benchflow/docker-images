REPONAME = docker-images
VERSION = dev

.PHONY: all build 

all: build

build:
	$(MAKE) -C ./base-images/base
	$(MAKE) -C ./base-images/base-dns
	$(MAKE) -C ./base-images/base-dns-envconsul
	$(MAKE) -C ./base-images/base-dns-envconsul-java7
	$(MAKE) -C ./base-images/base-dns-envconsul-java8
	$(MAKE) -C ./base-images/base-dns-java7
	$(MAKE) -C ./base-images/base-dns-java8
	$(MAKE) -C ./base-images/base-minio-client
	$(MAKE) -C ./cassandra
	$(MAKE) -C ./faban/harness
	$(MAKE) -C ./faban/agent
	$(MAKE) -C ./kafka
	$(MAKE) -C ./minio