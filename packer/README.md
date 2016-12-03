# Creating development VM images

**NOTE: this is an unfinished experiment.**

[Packer](https://www.packer.io) is a tool for creating machine and container
images for multiple platforms from a single source configuration.

This directory contains a Packer template and supporting files to build a
personal development virtual machine.

Build a new box starting from an official Fedora image with:

```
# vagrant box add fedora/25-cloud-base

export PACKER_SOURCE_PATH=~/.vagrant.d/boxes/fedora-VAGRANTSLASH-25-cloud-base/20161122/virtualbox/box.ovf
export PACKER_VAGRANTFILE_TEMPLATE=~/.vagrant.d/boxes/fedora-VAGRANTSLASH-25-cloud-base/20161122/virtualbox/Vagrantfile

packer build packer.json
```

While working on the image, it can be useful to iterate on the output of a
previous build without redoing everything from scratch. This can be done by
setting `source_path` to point to the output `.ovf` from the first build above:

```
mv -vbT output-virtualbox-ovf{,-old}
packer build \
  -var source_path=$(find $(pwd)/output-virtualbox-ovf-old -name '*.ovf') \
  packer.json
```


# TODO

- Actually install and configure the VM through Ansible.
- Setup [Guest Additions](https://www.packer.io/docs/builders/virtualbox-ovf.html#guest_additions_mode).
- Add [Atlas post-processor](https://www.packer.io/docs/post-processors/atlas.html).
