# 🏗️ Infrastructure

Automation code for deploying infrastructure components and applications

## 1. 🗃️ Table of Contents

- [1. 🗃️ Table of Contents](#1-️-table-of-contents)
- [2. :octocat: Github Actions Status](#2-octocat-github-actions-status)
- [3. 🗺️ Roadmap](#3-️-roadmap)

## 2. :octocat: Github Actions Status

[![Ansible codebase](https://github.com/daze-events/infrastructure/actions/workflows/ansible.yml/badge.svg)](https://github.com/daze-events/infrastructure/actions/workflows/ansible.yml)

[![Packer codebase](https://github.com/daze-events/infrastructure/actions/workflows/packer.yml/badge.svg)](https://github.com/daze-events/infrastructure/actions/workflows/packer.yml)

## 3. 🗺️ Roadmap

List of features to implement in the short-to-medium term:

- [x] Create AWS Accounts with **Terraform**
- [x] Implement **Packer** automation to create AMI's
- [x] Implement **Ansible** automation to configure new servers
- [x] Implement Github Action to build & test **Ansible** image and push it to Registry
- [x] Allow access from **Github Actions** to AWS **Elastic Container Registry**
- [x] Implement Github Action for Continuous Deployment of **Packer** builds
- [x] Implement mechanism for storage of secrets in VC using [**sops**](https://github.com/mozilla/sops) and AWS **Key Management Service**
- [ ] Implement mechanism to unmount & mount data EBS volume for a specific instance
