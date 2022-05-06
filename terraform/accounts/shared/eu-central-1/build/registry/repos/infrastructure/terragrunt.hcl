terraform {
  source = "${get_path_to_repo_root()}/terraform/modules/ecr/repo"
  # source = ""
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "daze-infrastructure"
  allowed_aws_account_ids = [
    local.common_vars.locals.accounts.dev.id,
  ]
}
