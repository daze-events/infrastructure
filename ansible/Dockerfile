FROM python:alpine

RUN apk --no-cache --quiet add \
    # Install system packages
    openssh-client \
    jq \
    wget \
    # Install system packages reqired for Ansible compilation
    gcc \
    musl-dev \
    libffi-dev \
    bash && \
    # Install pip packages
    pip install --no-cache-dir --quiet --upgrade pip && \
    pip install --no-cache-dir --quiet ansible awscli && \
    pip cache purge && \
    # Install SOPS package
    wget -qO /usr/bin/sops https://github.com/mozilla/sops/releases/download/v3.7.2/sops-v3.7.2.linux && chmod u+x /usr/bin/sops && \
    # Remove useless packages
    apk --quiet del \
    gcc \
    musl-dev \
    libffi-dev \
    wget

# Copy playbooks over into the container
COPY . /etc/ansible/

ENTRYPOINT [ "/etc/ansible/entrypoint.sh" ]
