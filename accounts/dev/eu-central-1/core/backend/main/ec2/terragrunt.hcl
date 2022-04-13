terraform {
  # source = "git::git@github.com:daze-events/infrastructure.git//modules/networking/vpc-app?ref=v0.2.4"
  source = "${get_path_to_repo_root()}/modules//ec2/single-server"
}

locals {
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  app_vars         = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  role_vars        = read_terragrunt_config(find_in_parent_folders("role.hcl"))

  shared_account_id = local.common_vars.locals.accounts.shared.id

  environment = local.environment_vars.locals.environment
  function    = local.environment_vars.locals.function
  app         = local.app_vars.locals.app
  role        = local.role_vars.locals.role
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../_resources/vpc/app"
}

inputs = {
  name                 = "${local.environment}-${local.function}-${local.app}-${local.role}"
  ami_search           = true
  ami_owner_account_id = "${local.shared_account_id}"
  ami_filter_name      = "dz-dev-ubuntu*"
  instance_type        = "t3a.micro"
  vpc_id               = dependency.vpc.outputs.vpc_id
  subnet_id            = dependency.vpc.outputs.public_subnet_ids[0]
}
