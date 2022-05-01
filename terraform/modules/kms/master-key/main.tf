module "kms_master_key" {
  source = "git@github.com:gruntwork-io/terraform-aws-security.git//modules/kms-master-key?ref=v0.63.1"

  customer_master_keys = {
    "${var.name}" = {
      cmk_administrator_iam_arns            = var.cmk_administrator_iam_arns
      cmk_user_iam_arns                     = var.cmk_user_iam_arns
      cmk_external_user_iam_arns            = var.cmk_external_user_iam_arns
      allow_manage_key_permissions_with_iam = var.allow_manage_key_permissions_with_iam
    }
  }
  default_deletion_window_in_days  = var.default_deletion_window_in_days
  default_enable_key_rotation      = var.default_enable_key_rotation
  default_customer_master_key_spec = var.default_customer_master_key_spec
}

resource "aws_iam_policy" "cmk-encrypt" {
  name   = "${var.name}-encrypt"
  policy = data.aws_iam_policy_document.cmk-encrypt-policy.json
  path   = "/"
}

resource "aws_iam_policy" "cmk-decrypt" {
  name   = "${var.name}-decrypt"
  policy = data.aws_iam_policy_document.cmk-decrypt-policy.json
  path   = "/"
}
