terraform {
  source = "../../../../../../modules//iam/group-with-policies"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "alexander_candfield" {
  config_path = "../../users/alexander_candfield"
}

dependency "iacopo_antonelli" {
  config_path = "../../users/iacopo_antonelli"
}

inputs = {
  name = "self-management"

  group_users = [
    dependency.alexander_candfield.outputs.iam_user_name,
    dependency.iacopo_antonelli.outputs.iam_user_name
  ]
}
