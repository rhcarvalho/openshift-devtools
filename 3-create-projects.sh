#!/bin/bash
set -x
oc new-project demo --display-name="OpenShift Demo Project" --description="This is a demo project"
oadm policy add-role-to-user admin demo -n demo
declare -a projects=({django,rails,nodejs,cakephp,dancer}-ex)
for name in ${projects[@]}; do
  oc new-project $name
  oadm policy add-role-to-user admin demo -n $name
done
oc project demo
