terraform {
  # source = "git::git@github.com:daze-events/infrastructure.git//modules/ec2/single-server?ref=v0.5.0"
  source = "${get_path_to_repo_root()}/modules/ec2/single-server?ref=v0.5.0"
}

locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  function_vars    = read_terragrunt_config(find_in_parent_folders("function.hcl"))
  role_vars        = read_terragrunt_config(find_in_parent_folders("role.hcl"))

  account_name      = local.account_vars.locals.account_name
  shared_account_id = local.common_vars.locals.accounts.shared.id
  environment       = local.environment_vars.locals.environment
  function          = local.function_vars.locals.function
  role              = local.role_vars.locals.role
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../_resources/vpc/app"
}

dependency "kms" {
  config_path = "../../../_resources/kms/master-key"
}

inputs = {
  name                    = "${local.account_name}-${local.environment}-${local.function}-${local.role}"
  ami_search              = true
  ami_owner_account_id    = "${local.shared_account_id}"
  ami_filter_name         = "dz-dev-ubuntu*"
  instance_type           = "t3a.micro"
  vpc_id                  = dependency.vpc.outputs.vpc_id
  subnet_id               = dependency.vpc.outputs.public_subnet_ids[0]
  additional_iam_policies = [dependency.kms.outputs.cmk_decrypt_policy_json]
}
