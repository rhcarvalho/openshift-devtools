#!/bin/bash
BASE_PATH=${BASE_PATH:-/data/src/github.com/openshift}

declare -a projects=(django rails nodejs cakephp dancer)

function create_project() {
  local name="$1"
  local db="$2"
  [ "$db" ] && local suffix="-db" && db="-${db}"
  local project_name="${name}-ex${suffix}"
  local template=${BASE_PATH}/${name}-ex/openshift/templates/${name}${db}.json

  [ ! -f "$template" ] && return

  if oc get project ${project_name} &>/dev/null; then
    echo "Project ${project_name} already exists, skipped."
    return
  fi
  echo "Creating project ${project_name} ..."
  oc new-project ${project_name} --display-name="Example: ${project_name}"
  oadm policy add-role-to-user admin demo -n ${project_name}
  oc process -f "$template" | oc create -f -
}

function create_image_streams() {
  local image_streams="${BASE_PATH}/origin/examples/image-streams/image-streams-centos7.json"

  if [ ! -f "${image_streams}" ]; then
    echo "Image streams not found: ${image_streams}"
    exit 1
  fi
  oc create -f "${image_streams}" -n openshift || exit 1
  oadm policy add-role-to-user view demo -n openshift
}

[ -z "${SKIP_IMAGE_STREAMS}" ] && create_image_streams

for name in ${projects[@]}; do
  create_project ${name}
  create_project ${name} postgresql
  create_project ${name} mysql
done
