terraform {
  # source = "git::git@github.com:daze-events/infrastructure.git//modules/networking/vpc-peering-cross-accounts-requester?ref=v0.2.4"
  source = "../../../../../../..//modules/networking/vpc-peering-cross-accounts-accepter"
}

include {
  path = find_in_parent_folders()
}

locals {
  common_vars       = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  shared_account_id = local.common_vars.locals.accounts["shared"].id
}

dependency "vpc_accepter" {
  config_path = "../app"
}

inputs = {
  vpc_peering_connection_id = "pcx-0de4eb92e19538a3d"
  route_tables = concat(
    dependency.vpc_accepter.outputs.public_subnet_route_table_ids,
    dependency.vpc_accepter.outputs.private_app_subnet_route_table_ids,
    dependency.vpc_accepter.outputs.private_persistence_subnet_route_table_ids,
  )
  requester_vpc_cidr = "100.0.0.0/16"
}
