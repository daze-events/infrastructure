terraform {
  # source = "git::git@github.com:daze-events/infrastructure.git//modules/networking/vpc-peering-cross-accounts-requester?ref=v0.2.4"
  source = "../../../../../../../..//modules/networking/vpc-peering-cross-accounts-requester"
}

include {
  path = find_in_parent_folders()
}

locals {
  common_vars    = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  dev_account_id = local.common_vars.locals.accounts["dev"].id
}

dependency "vpc_requester" {
  config_path = "../app"
}

# Accepter VPC is in "accounts/dev/eu-central-1/core/_resources/vpc/app"
inputs = {
  vpc_id       = dependency.vpc_requester.outputs.vpc_id
  route_tables = dependency.vpc_requester.outputs.public_subnet_route_table_ids

  accepter_owner_id = local.dev_account_id
  accepter_vpc_id   = "vpc-0a463125f7410fda0"
  accepter_region   = "eu-central-1"
  accepter_vpc_cidr = "10.0.0.0/16"
}
