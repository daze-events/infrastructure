# 🏗️ Infrastructure

Automation code for infrastructure 🏗️ and application 📦 package deployment on AWS.

## 1. 🗃️ Table of Contents

- [1. 🗃️ Table of Contents](#1-️-table-of-contents)
- [2. :octocat: Github Actions Status](#2-octocat-github-actions-status)
- [3. 🗺️ Roadmap](#3-️-roadmap)
- [4. 🗄️ Container Image Registry](#4-️-container-image-registry)
- [Technologies Stack](#technologies-stack)

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

## 4. 🗄️ Container Image Registry

For more info about where we store container iages, refer to [this Confluence document](https://daze-events.atlassian.net/l/c/sq707EBu).

## Technologies Stack

Here's a list of technologies we use:

- AWS Cloud
- Terraform
- Terragrunt
- Ansible
- Packer
- Docker
- Github Actions
- `pre-commit`
- `aws-vault`
- `awscli`
- `sops`
