#!/bin/bash
source "$(dirname ${BASH_SOURCE})/common.sh"

info "Adding view role to 'demo' user in the default namespace ..."
oadm policy add-role-to-user view demo -n default

info "Creating Docker registry ..."
OPENSHIFT_REGISTRY_CONFIG=`pwd`/openshift.local.config/master/openshift-registry.kubeconfig
[[ -f $OPENSHIFT_REGISTRY_CONFIG ]] || (echo "registry config not found"; exit 1)
sudo chmod a+r $OPENSHIFT_REGISTRY_CONFIG
oadm registry --create --credentials=$OPENSHIFT_REGISTRY_CONFIG -n default

info "Creating router ..."
OPENSHIFT_ROUTER_CONFIG=`pwd`/openshift.local.config/master/openshift-router.kubeconfig
[[ -f $OPENSHIFT_ROUTER_CONFIG ]] || (echo "router config not found"; exit 1)
sudo chmod a+r $OPENSHIFT_ROUTER_CONFIG
oadm router --create --credentials=$OPENSHIFT_ROUTER_CONFIG -n default

info "Done."
