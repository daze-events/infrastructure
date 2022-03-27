terraform {
  source = "git::ssh://git@github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  name        = "BlockMostAccessUnlessSignedInWithMFA"
  path        = "/"
  description = "Enforces MFA on IAM Users."
  policy      = file("mfa_policy.json") # https://aws.amazon.com/premiumsupport/knowledge-center/mfa-iam-user-aws-cli/
}
