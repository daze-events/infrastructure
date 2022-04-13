output "key_arn" {
  description = "A map of CMK name to CMK ARN."
  value       = module.kms_master_key.key_arn
}

output "key_id" {
  description = "A map of CMK name to CMK ID."
  value       = module.kms_master_key.key_id
}

output "key_alias" {
  description = "A map of CMK name to CMK alias."
  value       = module.kms_master_key.key_alias
}
