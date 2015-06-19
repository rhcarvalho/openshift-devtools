#!/bin/bash
source "$(dirname ${BASH_SOURCE})/common.sh"

info "sudo openshift start --public-master=localhost $@"
sudo /data/src/github.com/openshift/origin/_output/local/go/bin/openshift start --public-master=localhost "$@"
