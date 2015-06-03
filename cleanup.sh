#!/bin/bash
set -x
docker ps | awk 'index($NF,"k8s_")==1 { print $1 }' | xargs -l -r docker stop
findmnt -lo TARGET | grep openshift.local.volumes | xargs -r sudo umount
rm -rf openshift.local.*
