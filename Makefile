# Plain make functions and GOFLAGS keep the recipes free of shell syntax, so
# they run under cmd.exe as well as sh, and a tag name never reaches a shell.
# .git marks this directory as a repo root, so source inside another repository
# does not read that repository's tags. --long keeps a build on a tag reading
# as a commit, never as that release.
VERSION := $(if $(wildcard .git),$(shell git describe --tags --always --dirty --long))
VERSION := $(or $(VERSION),dev)
export GOFLAGS := $(GOFLAGS) -ldflags=-X=main.version=$(VERSION)

.PHONY: build install

build:
	go build -o agent-manager$(shell go env GOEXE) .

install:
	go install .
