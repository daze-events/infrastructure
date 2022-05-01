data "aws_iam_policy_document" "cmk-encrypt-policy" {
  statement {
    sid       = "AllowEncryption"
    effect    = "Allow"
    actions   = ["kms:Encrypt"]
    resources = [(lookup(module.kms_master_key.key_arn, var.name, null))]
  }
}

data "aws_iam_policy_document" "cmk-decrypt-policy" {
  statement {
    sid       = "AllowDecryption"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = [lookup(module.kms_master_key.key_arn, var.name, null)]
  }
}

data "aws_iam_policy_document" "cmk-sign-policy" {
  statement {
    sid       = "AllowSign"
    effect    = "Allow"
    actions   = ["kms:Sign"]
    resources = [lookup(module.kms_master_key.key_arn, var.name, null)]
  }
}

data "aws_iam_policy_document" "cmk-verify-policy" {
  statement {
    sid       = "AllowVerify"
    effect    = "Allow"
    actions   = ["kms:Verify"]
    resources = [lookup(module.kms_master_key.key_arn, var.name, null)]
  }
}
