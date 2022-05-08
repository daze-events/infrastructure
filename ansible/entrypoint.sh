#!/usr/bin/env bash

set -eo pipefail

if [[ ! -z $CI ]]; then
    set -x
fi

HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')

echo "🧾 Launching playbook"
ansible-playbook \
                -i "$HOST_IP", \
                "$@" \
                /etc/ansible/main.yml

echo "🔥 Done!"
