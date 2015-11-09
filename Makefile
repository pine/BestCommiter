.PHONY: default all

default: all
all: clean install build test


.PHONY: install build test

clean:
	rm -rf .shards
	rm -rf .crystal
	rm -rf libs

install:
	crystal deps

build:
	mkdir -p bin
	crystal build --release src/best_comitter.cr -o bin/best_comitter

test:
	crystal spec
