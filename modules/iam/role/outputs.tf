output "iam_instance_profile_arn" {
  description = <<EOF
  "
  ARN of IAM instance profile.
  "
  EOF
  value       = module.iam_assumable_role.iam_instance_profile_arn
}

output "iam_instance_profile_id" {
  description = <<EOF
  "
  IAM Instance profile's ID.
  "
  EOF
  value       = module.iam_assumable_role.iam_instance_profile_id
}

output "iam_instance_profile_name" {
  description = <<EOF
  "
  Name of IAM instance profile.
  "
  EOF
  value       = module.iam_assumable_role.iam_instance_profile_name
}

output "iam_instance_profile_path" {
  description = <<EOF
  "
  Path of IAM instance profile.
  "
  EOF
  value       = module.iam_assumable_role.iam_instance_profile_path
}

output "iam_role_arn" {
  description = <<EOF
  "
  ARN of IAM role.
  "
  EOF
  value       = module.iam_assumable_role.iam_role_arn
}

output "iam_role_name" {
  description = <<EOF
  "
  Name of IAM role.
  "
  EOF
  value       = module.iam_assumable_role.iam_role_name
}

output "iam_role_path" {
  description = <<EOF
  "
  Path of IAM role.
  "
  EOF
  value       = module.iam_assumable_role.iam_role_path
}

output "iam_role_unique_id" {
  description = <<EOF
  "
  Unique ID of IAM role.
  "
  EOF
  value       = module.iam_assumable_role.iam_role_unique_id
}

output "role_requires_mfa" {
  description = <<EOF
  "
  Whether IAM role requires MFA.
  "
  EOF
  value       = module.iam_assumable_role.role_requires_mfa
}

output "role_sts_externalid" {
  description = <<EOF
  "
  STS ExternalId condition value to use with a role.
  "
  EOF
  value       = module.iam_assumable_role.role_sts_externalid
}
