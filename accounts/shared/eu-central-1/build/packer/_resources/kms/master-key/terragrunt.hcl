terraform {
  source = "git::git@github.com:daze-events/infrastructure.git//modules/kms/master-key?ref=v0.5.0"
}

locals {
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  function_vars    = read_terragrunt_config(find_in_parent_folders("function.hcl"))

  shared_account_id = local.common_vars.locals.accounts.security.id
  dev_account_id    = local.common_vars.locals.accounts.dev.id
  account_name      = local.account_vars.locals.account_name
  environment       = local.environment_vars.locals.environment
  function          = local.function_vars.locals.function
}

include {
  path = find_in_parent_folders()
}

inputs = {

  customer_master_keys = {
    "${local.account_name}-${local.environment}-${local.function}" = {

      cmk_administrator_iam_arns = [
        "arn:aws:iam::${local.shared_account_id}:user/alexander.candfield",
      ]

      cmk_user_iam_arns = [
        {
          name       = ["arn:aws:iam::${local.shared_account_id}:user/alexander.candfield"]
          conditions = []
        }

      ]

      cmk_external_user_iam_arns = [
        "arn:aws:iam::${local.dev_account_id}:root",
      ]
      allow_manage_key_permissions_with_iam = true
    }
  }
}
