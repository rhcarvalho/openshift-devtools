#!/bin/bash
source "$(dirname ${BASH_SOURCE})/common.sh"

info "Creating project 'demo' ..."
oc new-project demo --display-name="OpenShift Demo Project" --description="This is a demo project"
oadm policy add-role-to-user admin demo -n demo

info "Done."
