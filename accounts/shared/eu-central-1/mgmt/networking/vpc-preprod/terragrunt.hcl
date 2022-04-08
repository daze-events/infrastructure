terraform {
  source = "git::git@github.com:daze-events/infrastructure.git//modules/networking/vpc-app?ref=v0.2.4"
  # source = "../../../../../../modules//networking/vpc-app"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_name                           = "mgmt-preprod"
  cidr_block                         = "100.0.0.0/16"
  num_nat_gateways                   = 0
  num_availability_zones             = 2
  map_public_ip_on_launch            = true
  create_private_app_subnets         = false
  create_private_persistence_subnets = false
}
