FROM python:alpine

RUN apk add ansible \
    && rm -rf /var/cache/apk/*

COPY . /etc/ansible/
