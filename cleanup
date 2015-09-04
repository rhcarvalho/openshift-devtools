#!/bin/bash
source "$(dirname ${BASH_SOURCE})/common.sh"

info "Stopping Docker containers ..."
docker ps | awk 'index($NF,"k8s_")==1 { print $1 }' | xargs -l -r docker stop

info "Unmounting volumes ..."
findmnt -lo TARGET | grep openshift.local.volumes | xargs -r sudo umount

info "Removing files ..."
sudo rm -vrf openshift.local.*

info "Done."
