#!/bin/bash -e
source "$(dirname ${BASH_SOURCE})/../common.sh"

BASE_PATH=${BASE_PATH:-/data/src/github.com/openshift}

image_streams="${BASE_PATH}/origin/examples/image-streams/image-streams-centos7.json"

if [ ! -f "${image_streams}" ]; then
  echo "Image streams not found: ${image_streams}"
  exit 1
fi

info "Creating image streams ..."
oc create -f "${image_streams}" -n openshift
oadm policy add-role-to-user view demo -n openshift

info "Done."
