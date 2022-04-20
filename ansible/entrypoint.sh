#!/usr/bin/env bash

set -euxo pipefail

sops -d -i -k "arn:aws:kms:eu-central-1:844769057455:key/562b6fbf-4e47-418f-8478-4648eb26c565" /etc/ansible/ssh.json
echo "Decrypted secret"

jq -r .ssh_private_key /etc/ansible/ssh.json | base64 -d > /tmp/ssh_key.temp && mv /tmp/ssh_key.temp /etc/ansible/ssh.pem
echo "SSH key created at /etc/ansible/ssh.pem"

echo "Launching playbook"
ansible-playbook --private-key /etc/ansible/ssh.pem /etc/ansible/playbooks/install_postgresql.yml
echo "Done!"
