terraform {
  source = "../../../../../../modules//iam/user"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name          = "iacopo.antonelli"
  pgp_key       = "keybase:iacopo_antonelli"
  force_destroy = true
}
