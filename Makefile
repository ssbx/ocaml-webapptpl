
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

.PHONY: release
release:
	echo "release todo"

.PHONY: deploy
deploy: release
	echo "deploy todo"
	#cp ./webapptpl.service /etc/systemd/system/
	#systemctl daemon-reload
	#systemctl restart webapptpl



