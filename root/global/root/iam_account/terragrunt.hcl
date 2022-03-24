terraform {
  source = "../../../../modules//iam_root_setup"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {}
