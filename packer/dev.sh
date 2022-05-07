#!/usr/bin/env bash

# You can provide additional packer-related arguments by
# appending them at the end of the script.
# Example:
#
# ./dev.sh -var=create_ami=false -debug -var=ansible_debug=true

packer init .

packer build "$@" \
            -var-file vars/dev/env.pkrvars.hcl \
            -var-file vars/dev/ubuntu-focal.pkrvars.hcl \
            -var-file vars/common.pkrvars.hcl \
            builds/ubuntu-focal
