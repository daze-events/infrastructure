terraform {
  source = "../../../../modules//organization"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {}
