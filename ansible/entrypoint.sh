#!/usr/bin/env bash

set -eo pipefail

if [[ ! -z $CI ]]; then
    set -x
fi

ANSIBLE_DIR="/etc/ansible"

if [[ -z $CI ]]; then

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

HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')

echo "🧾 Launching playbook"
ansible-playbook \
                --private-key ${ANSIBLE_DIR}/ssh.pem \
                -i "$HOST_IP", \
                "$@" \
                ${ANSIBLE_DIR}/main.yml

echo "🔥 Done!"
