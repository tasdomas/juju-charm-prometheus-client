
GOPATH=/tmp/juju-charm-prometheus-client
BIN=files/random
INTERFACE_PATH=interfaces
LAYER_PATH=layers

.PHONY: all
all: $(BIN)
	charm build -s trusty

$(BIN): $(GOPATH)
	GOBIN=$(realpath ./files/) GOPATH=$(GOPATH) go get github.com/prometheus/client_golang/examples/random

$(GOPATH):
	mkdir $(GOPATH)

