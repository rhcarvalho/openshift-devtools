#!/bin/bash
set -x
oadm policy add-role-to-user view demo -n default
OPENSHIFT_REGISTRY_CONFIG=`pwd`/openshift.local.config/master/openshift-registry.kubeconfig
[[ -f $OPENSHIFT_REGISTRY_CONFIG ]] || (echo "registry config not found"; exit 1)
sudo chmod a+r $OPENSHIFT_REGISTRY_CONFIG
oadm registry --create --credentials=$OPENSHIFT_REGISTRY_CONFIG -n default

OPENSHIFT_ROUTER_CONFIG=`pwd`/openshift.local.config/master/openshift-router.kubeconfig
[[ -f $OPENSHIFT_ROUTER_CONFIG ]] || (echo "router config not found"; exit 1)
sudo chmod a+r $OPENSHIFT_ROUTER_CONFIG
oadm router --create --credentials=$OPENSHIFT_ROUTER_CONFIG -n default
