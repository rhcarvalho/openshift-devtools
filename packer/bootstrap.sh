#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

echo "Installing and verifying base dependencies..."

# List of system packages required to install Ansible using pip.
# We could install ansible with dnf, but using pip makes it easier to use
# arbitrary Ansible versions, the latest by default.
PKGS=(
  gcc
  libffi-devel
  openssl-devel
  python-devel
  python-pip
  redhat-rpm-config
)
sudo dnf -qy install "${PKGS[@]}"

# Verify that all packages were installed properly.
# Skip python-pip because it gets upgraded later, and the installed files will
# differ from the installed RPM, what could cause this line to fail on a second
# run.
# The expansion below is intentionally unquoted, since all package names contain
# no space, and it is an error to pass an empty argument "" to `rpm -V`.
(shopt -sq extglob; rpm -V ${PKGS[@]/@(python-pip)})

# Upgrade pip to the latest version.
sudo pip install -qU pip

echo "Installing Ansible..."

sudo pip install ansible
