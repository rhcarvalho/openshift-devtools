#!/bin/bash
set -x
OPENSHIFT_REGISTRY_CONFIG=`pwd`/openshift.local.config/master/openshift-registry.kubeconfig
[[ -f $OPENSHIFT_REGISTRY_CONFIG ]] || (echo "registry config not found"; exit 1)
sudo chmod +r $OPENSHIFT_REGISTRY_CONFIG
oadm registry --create --credentials=$OPENSHIFT_REGISTRY_CONFIG
oadm policy add-role-to-user view demo -n default
