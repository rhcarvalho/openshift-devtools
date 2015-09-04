#!/bin/bash

# source this file to export the variables below:
export KUBECONFIG=`pwd`/openshift.local.config/master/admin.kubeconfig
[[ -f $KUBECONFIG ]] || (echo "OpenShift config not found"; exit 1)
export CURL_CA_BUNDLE=`pwd`/openshift.local.config/master/ca.crt
[[ -f $CURL_CA_BUNDLE ]] || (echo "certificate not found"; exit 1)

(
  source "$(dirname ${BASH_SOURCE})/common.sh"
  info "Exported KUBECONFIG and CURL_CA_BUNDLE."
  sudo chmod a+rwX "$KUBECONFIG"
  info "Done."
)
