OS   := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)

ifeq ($(OS),linux)
	CRFLAGS := --link-flags "-static -L/opt/crystal/embedded/lib"
endif

ifeq ($(OS),darwin)
	CRFLAGS := --link-flags "-L."
endif

.PHONY: default all

default: all
all: clean install build test


.PHONY: clean install build test

clean:
	rm -rf .shards
	rm -rf .crystal
	rm -rf libs

install:
	crystal deps

build:
	mkdir -p bin
	crystal build --release src/best_commiter.cr -o bin/best_commiter

release:
	if [ "$(OS)" = "darwin" ] ; then \
		cp /usr/local/lib/libyaml.a . ;\
		chmod 644 libyaml.a ;\
		export LIBRARY_PATH= ;\
	fi
	crystal build --release -o bin/best_commiter src/best_commiter.cr $(CRFLAGS)
	tar zcvf best_commiter_$(OS)_$(ARCH).tar.gz bin/best_commiter

test:
	crystal spec
