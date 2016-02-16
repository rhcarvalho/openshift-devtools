#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

function info() {
  echo -e "\e[00;34m$@\e[00m"
}
