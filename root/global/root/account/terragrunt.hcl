terraform {
  source = "../../../../modules//iam/account"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {}
