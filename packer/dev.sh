#!/usr/bin/env bash

packer build "$@" \
            -var-file vars/dev/env.pkrvars.hcl \
            -var-file vars/dev/ubuntu-focal.pkrvars.hcl \
            -var-file vars/common.pkrvars.hcl \
            builds/ubuntu-focal
