terraform {
  # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
  # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
  required_version = "= 1.1.8"

  required_providers {
    aws = {
      version = "~> 3.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [var.aws_account_id]
}

module "vpc_peering_cross_accounts_requester" {
  source = "git@github.com:gruntwork-io/module-vpc.git//modules/vpc-peering-cross-accounts-requester?ref=v0.21.0"

  vpc_id            = var.vpc_id
  route_tables      = var.route_tables
  accepter_owner_id = var.accepter_owner_id
  accepter_vpc_id   = var.accepter_vpc_id
  accepter_region   = var.accepter_region
  accepter_vpc_cidr = var.accepter_vpc_cidr

  tags = var.tags

  route_creation_timeout = var.route_creation_timeout
  route_deletion_timeout = var.route_deletion_timeout

  allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
}
