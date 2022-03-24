terraform {
  source = "../../../../../modules//iam_user"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name          = "alexander.candfield"
  pgp_key       = "keybase:alex_candfield"
  force_destroy = true
}
