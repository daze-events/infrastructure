terraform {
  source = "git::git@github.com:daze-events/infrastructure.git//modules/networking/vpc-app?ref=v0.2.4"
}

locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  app_vpc_cidrs = local.common_vars.locals.app_vpc_cidrs

  account_name = local.account_vars.locals.account_name
  environment  = local.environment_vars.locals.environment
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_name                           = "${local.account_name}-${local.environment}"
  cidr_block                         = "${local.app_vpc_cidrs.dev}"
  num_nat_gateways                   = 0
  num_availability_zones             = 2
  map_public_ip_on_launch            = true
  create_private_app_subnets         = false
  create_private_persistence_subnets = false
}
