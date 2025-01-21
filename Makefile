
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
	echo "todo release target"

.PHONY: deploy
deploy: release
	echo "todo deploy target"
	#cp ./webapptpl.service /etc/systemd/system/
	#systemctl daemon-reload
	#systemctl restart webapptpl



