
.PHONY: run
run:
	dune exec webapptpl 

.PHONY: help
help:
	dune exec webapptpl -- --help

.PHONY: build
build:
	dune build

.PHONY: watch
watch:
	dune build --watch

.PHONY: clean
clean:
	dune clean

