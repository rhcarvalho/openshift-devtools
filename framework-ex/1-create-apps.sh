#!/bin/bash
source "$(dirname ${BASH_SOURCE})/../common.sh"

BASE_PATH=${BASE_PATH:-/data/src/github.com/openshift}

[ -z "$PROJECTS" ] && \
declare -a PROJECTS=(django rails nodejs cakephp dancer)

function create_project() {
  local name="$1"
  local db="$2"
  [ "$db" ] && local suffix="-db" && db="-${db}"
  local project_name="${name}-ex${suffix}"
  local template=${BASE_PATH}/${name}-ex/openshift/templates/${name}${db}.json

  [ ! -f "$template" ] && return

  if oc get project ${project_name} &>/dev/null; then
    info "Project ${project_name} already exists, skipped."
    return
  fi
  info "Creating project ${project_name} ..."
  oc new-project ${project_name} --display-name="Example: ${project_name}"
  oadm policy add-role-to-user admin demo -n ${project_name}
  oc new-app "$template"
}

for name in ${PROJECTS[@]}; do
  create_project ${name}
  create_project ${name} postgresql
  create_project ${name} mysql
done

info "Done."
