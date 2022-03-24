output "caller_identity_account_id" {
  description = <<EOF
  "The AWS Account ID number of the account that owns or contains the calling entity."
  EOF
  value       = module.iam_account.caller_identity_account_id
}

output "caller_identity_arn" {
  description = <<EOF
  "The AWS ARN associated with the calling entity."
  EOF
  value       = module.iam_account.caller_identity_arn
}

output "caller_identity_user_id" {
  description = <<EOF
  "The unique identifier of the calling entity."
  EOF
  value       = module.iam_account.caller_identity_user_id
}

output "iam_account_password_policy_expire_passwords" {
  description = <<EOF
  "Indicates whether passwords in the account expire.
  Returns true if max_password_age contains a value greater than 0.
  Returns false if it is 0 or not present."
  EOF
  value       = module.iam_account.iam_account_password_policy_expire_passwords
}

output "arn" {
  description = <<EOF
  "The ARN assigned by AWS to this policy."
  EOF
  value       = module.iam_policy.arn
}

output "description" {
  description = <<EOF
  "The description of the policy."
  EOF
  value       = module.iam_policy.description
}

output "id" {
  description = <<EOF
  "The policy's ID."
  EOF
  value       = module.iam_policy.id
}

output "name" {
  description = <<EOF
  "The name of the policy."
  EOF
  value       = module.iam_policy.name
}

output "path" {
  description = <<EOF
  "The path of the policy in IAM."
  EOF
  value       = module.iam_policy.path
}

output "policy" {
  description = <<EOF
  "The policy document."
  EOF
  value       = module.iam_policy.policy
}
