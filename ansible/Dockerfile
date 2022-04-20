FROM python:buster

RUN apt-get update && \
    apt-get upgrade -y

# Installs core packages
RUN apt-get install -y openssh-server ansible

# Install dev packages
RUN apt-get install -y jq vim less

# Install SOPS
RUN curl -qsL "https://github.com/mozilla/sops/releases/download/v3.7.2/sops_3.7.2_amd64.deb" -o /tmp/sops.deb
RUN dpkg -i /tmp/sops.deb

# Copy playbooks over into the container
COPY . /etc/ansible/

CMD [ "/etc/ansible/entrypoint.sh" ]
