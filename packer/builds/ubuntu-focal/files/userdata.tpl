#!/usr/bin/env bash

set -euxo pipefail

ANSIBLE_USER="${ ansible_ssh_user }"
DEFAULT_USER="ubuntu"

{
    # Create user $${ANSIBLE_USER}
    useradd \
    --create-home \
    --comment "Ansible User used by Packer" \
    --system \
    --shell "/usr/bin/bash" \
    $${ANSIBLE_USER}

    # Create .ssh folder in $${ANSIBLE_USER}'s home
    mkdir -vp "/home/$${ANSIBLE_USER}/.ssh/"

    # Move SSH Authorized Keys file from $${DEFAULT_USER}'s home to $${ANSIBLE_USER}'s home
    mv -v "/home/$${DEFAULT_USER}/.ssh/authorized_keys" "/home/$${ANSIBLE_USER}/.ssh/"

    # Make $${ANSIBLE_USER} owner of the .ssh directory
    chown -vR "$${ANSIBLE_USER}:$${ANSIBLE_USER}" "/home/$${ANSIBLE_USER}/.ssh"

    # Make $${ANSIBLE_USER} a sudoer
    echo "$${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/$${ANSIBLE_USER}"

    # Delete user $${DEFAULT_USER} and remove files
    userdel -r "$${DEFAULT_USER}"
    rm -rf "/home/$${DEFAULT_USER:-ubuntu}"

} &>> /var/log/userdata.log
