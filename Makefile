ifndef JUJU_REPOSITORY
	$(error JUJU_REPOSITORY is undefined)
endif

GOPATH=/tmp/juju-charm-prometheus-client
BIN=files/random
INTERFACE_PATH=$(shell pwd)/interfaces
LAYER_PATH=$(shell pwd)/layers

.PHONY: all
all: $(BIN)
	LAYER_PATH=$(LAYER_PATH) INTERFACE_PATH=$(INTERFACE_PATH) charm build -s trusty

$(BIN): $(GOPATH)
	GOBIN=$(realpath ./files/) GOPATH=$(GOPATH) go get github.com/prometheus/client_golang/examples/random

$(GOPATH):
	mkdir $(GOPATH)

clean:
	$(RM) -r $(JUJU_REPOSITORY)/trusty/prometheus

