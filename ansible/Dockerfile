FROM python:buster

RUN apt-get update && \
    apt-get upgrade -y

# Installs core packages
RUN apt-get install -y openssh-server ansible && \
    apt-get install -y --no-install-recommends apt-utils

# Install dev packages
RUN apt-get install -y jq vim less

# Install aws-cli
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip -qq "/tmp/awscliv2.zip" -d "/tmp" && \
    /tmp/aws/install && \
    rm -rf "/tmp/aws*"

# Install SOPS
RUN curl -qsL "https://github.com/mozilla/sops/releases/download/v3.7.2/sops_3.7.2_amd64.deb" -o /tmp/sops.deb
RUN dpkg -i /tmp/sops.deb

# Copy playbooks over into the container
COPY . /etc/ansible/

ENTRYPOINT [ "/etc/ansible/entrypoint.sh" ]
