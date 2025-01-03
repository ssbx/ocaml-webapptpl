
.PHONY: run
run: build
	open _build/default/app/index.html

.PHONY: build
build:
	dune build @app
