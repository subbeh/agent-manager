# --long keeps a build on a tag reading as a commit, never as that release.
# An empty prefix means this directory is a repo root, not a subdirectory whose
# describe would read the enclosing repo's tags.
VERSION := $(shell [ -z "$$(git rev-parse --show-prefix 2>/dev/null)" ] && git describe --tags --always --dirty --long 2>/dev/null || echo dev)
LDFLAGS := -ldflags "-X main.version=$(VERSION)"

.PHONY: build install

build:
	go build $(LDFLAGS) -o agent-manager$(shell go env GOEXE) .

install:
	go install $(LDFLAGS) .
