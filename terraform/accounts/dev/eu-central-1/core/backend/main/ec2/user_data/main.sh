#!/usr/bin/env bash

set -eo pipefail
{
    AWS_REGION="$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')"
    AWS_SHARED_ACCOUNT_ID="169567906943"
    AWS_REGISTRY_ADDRESS="${AWS_SHARED_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    AWS_REPO_NAME="infrastructure/ansible"
    AWS_IMAGE_TAG="dev"

    aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${AWS_REGISTRY_ADDRESS}"

    ssh-keygen -t rsa -b 4096 -C "daze-events" -f /tmp/daze-events -N ""

    cat /tmp/daze-events.pub > /home/ansible/.ssh/authorized_keys

    docker run --rm -v /tmp/daze-events:/etc/ansible/ssh.pem "${AWS_REGISTRY_ADDRESS}/${AWS_REPO_NAME}:${AWS_IMAGE_TAG}"

    rm -v /tmp/daze-events*
    > /home/ansible/.ssh/authorized_keys

} &>>/var/log/user-data.log
