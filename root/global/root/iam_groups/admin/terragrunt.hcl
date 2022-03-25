terraform {
  source = "../../../../../modules//iam_group_with_policies"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "mfa_enforce_policy" {
  config_path = "../../iam_policies/mfa_enforce"
}

dependency "alexander_candfield" {
  config_path = "../../iam_users/alexander_candfield"
}

dependency "iacopo_antonelli" {
  config_path = "../../iam_users/iacopo_antonelli"
}

inputs = {
  name = "Admins"

  group_users = [
    dependency.alexander_candfield.outputs.iam_user_name,
    dependency.iacopo_antonelli.outputs.iam_user_name
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    dependency.mfa_enforce_policy.outputs.arn
  ]
}
