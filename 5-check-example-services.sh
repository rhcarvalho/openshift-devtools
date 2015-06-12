#!/bin/bash
set -o pipefail

BASE_PATH=${BASE_PATH:-/data/src/github.com/openshift}

declare -a projects=(django rails nodejs cakephp dancer)

function test_project() {
  local name="$1"
  local db="$2"
  [ "$db" ] && local suffix="-db" && db="-${db}"
  local project_name="${name}-ex${suffix}"

  local service_ip=$(oc get service ${name}-frontend -t '{{ .spec.portalIP }}' -n "${project_name}" 2>/dev/null)

  [ -z "${service_ip}" ] && return 1

  echo -n "${project_name} (${service_ip}): "
  (curl -sI -m 1 ${service_ip}:8080 | head -1) || echo "FAIL"
  return 0
}

for name in ${projects[@]}; do
  test_project ${name}
  test_project ${name} postgresql || test_project ${name} mysql
done
