terraform {
  source = "../../../../../../modules//iam/role"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "mfa_enforce_policy" {
  config_path = "../../policies/mfa_enforce"
}

dependency "alexander_candfield" {
  config_path = "../../users/alexander_candfield"
}

dependency "iacopo_antonelli" {
  config_path = "../../users/iacopo_antonelli"
}

inputs = {
  role_name        = "admin-access"
  role_description = "Administrator privileges for account ${get_aws_account_id()}"

  create_role         = true
  attach_admin_policy = true

  number_of_custom_role_policy_arns = 1
  custom_role_policy_arns = [
    dependency.mfa_enforce_policy.outputs.arn,
  ]

  trusted_role_arns = [
    dependency.alexander_candfield.outputs.iam_user_arn,
    dependency.iacopo_antonelli.outputs.iam_user_arn
  ]
}
