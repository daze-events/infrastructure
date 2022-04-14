terraform {
  source = "git::git@github.com:daze-events/infrastructure.git//modules/ec2/key-pair?ref=v0.5.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  function_vars    = read_terragrunt_config(find_in_parent_folders("function.hcl"))

  account_name = local.account_vars.locals.account_name
  environment  = local.environment_vars.locals.environment
  function     = local.function_vars.locals.function

}

inputs = {
  key_name   = "${local.account_name}-${local.environment}-${local.function}"
  public_key = "${file(pathexpand("~/.ssh/id_rsa.pub"))}"
}
