output "admin_iam_role_arn" {
  description = <<EOF
  "
  ARN of admin IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.admin_iam_role_arn
}

output "admin_iam_role_name" {
  description = <<EOF
  "
  Name of admin IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.admin_iam_role_name
}

output "admin_iam_role_path" {
  description = <<EOF
  "
  Path of admin IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.admin_iam_role_path
}

output "admin_iam_role_requires_mfa" {
  description = <<EOF
  "
  Whether admin IAM role requires MFA.
  "
  EOF
  value       = module.iam_assumable_roles.admin_iam_role_requires_mfa
}

output "admin_iam_role_unique_id" {
  description = <<EOF
  "
  Unique ID of IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.admin_iam_role_unique_id
}

output "poweruser_iam_role_arn" {
  description = <<EOF
  "
  ARN of poweruser IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.poweruser_iam_role_arn
}

output "poweruser_iam_role_name" {
  description = <<EOF
  "
  Name of poweruser IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.poweruser_iam_role_name
}

output "poweruser_iam_role_path" {
  description = <<EOF
  "
  Path of poweruser IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.poweruser_iam_role_path
}

output "poweruser_iam_role_requires_mfa" {
  description = <<EOF
  "
  Whether poweruser IAM role requires MFA.
  "
  EOF
  value       = module.iam_assumable_roles.poweruser_iam_role_requires_mfa
}

output "poweruser_iam_role_unique_id" {
  description = <<EOF
  "
  Unique ID of IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.poweruser_iam_role_unique_id
}

output "readonly_iam_role_arn" {
  description = <<EOF
  "
  ARN of readonly IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.readonly_iam_role_arn
}

output "readonly_iam_role_name" {
  description = <<EOF
  "
  Name of readonly IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.readonly_iam_role_name
}

output "readonly_iam_role_path" {
  description = <<EOF
  "
  Path of readonly IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.readonly_iam_role_path
}

output "readonly_iam_role_requires_mfa" {
  description = <<EOF
  "
  Whether readonly IAM role requires MFA.
  "
  EOF
  value       = module.iam_assumable_roles.readonly_iam_role_requires_mfa
}

output "readonly_iam_role_unique_id" {
  description = <<EOF
  "
  Unique ID of IAM role.
  "
  EOF
  value       = module.iam_assumable_roles.readonly_iam_role_unique_id
}
