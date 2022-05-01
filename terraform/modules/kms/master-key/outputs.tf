output "key_arn" {
  value = lookup(module.kms_master_key.key_arn, var.name, null)
}

output "key_id" {
  value = lookup(module.kms_master_key.key_id, var.name, null)
}

output "key_alias" {
  value = lookup(module.kms_master_key.key_alias, var.name, null)
}

output "cmk_decrypt_policy_json" {
  value = data.aws_iam_policy_document.cmk-decrypt-policy.json
}

output "cmk_encrypt_policy_json" {
  value = data.aws_iam_policy_document.cmk-encrypt-policy.json
}

output "cmk-decrypt-policy_arn" {
  value = aws_iam_policy.cmk-decrypt.arn
}

output "cmk-encrypt-policy_arn" {
  value = aws_iam_policy.cmk-encrypt.arn
}
