#!/usr/bin/env bash

set -euo pipefail

ANSIBLE_DIR="/etc/ansible"

if [[ ! -z $CI ]]; then

    # Decrypt file with KMS key
    sops -d -i ${ANSIBLE_DIR}/ssh.json
    echo "🔐 Decrypted secret"

    # Extract key from json file
    jq -r .ssh_private_key ${ANSIBLE_DIR}/ssh.json | base64 -d > /tmp/ssh.temp
    # Rename temp file
    mv /tmp/ssh.temp ${ANSIBLE_DIR}/ssh.pem
    # Correct permissions on SSH key
    chmod 600 ${ANSIBLE_DIR}/ssh.pem
    echo "🔑 SSH key created at ${ANSIBLE_DIR}/ssh.pem"

fi

echo "🧾 Launching playbook"
ansible-playbook \
                --private-key ${ANSIBLE_DIR}/ssh.pem \
                "$@" \
                ${ANSIBLE_DIR}/playbooks/install_postgresql.yml

echo "🔥 Done!"
