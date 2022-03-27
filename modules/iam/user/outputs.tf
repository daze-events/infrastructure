output "iam_access_key_encrypted_secret" {
  description = <<EOF
  "
  The encrypted secret, base64 encoded.
  "
  EOF
  value       = module.iam_user.iam_access_key_encrypted_secret
  sensitive   = true
}

output "iam_access_key_id" {
  description = <<EOF
  "
  The access key ID.
  "
  EOF
  value       = module.iam_user.iam_access_key_id
}

output "iam_access_key_key_fingerprint" {
  description = <<EOF
  "
  The fingerprint of the PGP key used to encrypt the secret.
  "
  EOF
  value       = module.iam_user.iam_access_key_key_fingerprint
}

output "iam_access_key_secret" {
  description = <<EOF
  "
  The access key secret.
  "
  EOF
  value       = module.iam_user.iam_access_key_secret
  sensitive   = true
}

output "iam_access_key_ses_smtp_password_v4" {
  description = <<EOF
  "
  The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm.
  "
  EOF
  value       = module.iam_user.iam_access_key_ses_smtp_password_v4
  sensitive   = true
}

output "iam_access_key_status" {
  description = <<EOF
  "
  Active or Inactive. Keys are initially active, but can be made inactive by other means.
  "
  EOF
  value       = module.iam_user.iam_access_key_status
}

output "iam_user_arn" {
  description = <<EOF
  "
  The ARN assigned by AWS for this user.
  "
  EOF
  value       = module.iam_user.iam_user_arn
}

output "iam_user_login_profile_encrypted_password" {
  description = <<EOF
  "
  The encrypted password, base64 encoded.
  "
  EOF
  value       = module.iam_user.iam_user_login_profile_encrypted_password
}

output "iam_user_login_profile_key_fingerprint" {
  description = <<EOF
  "
  The fingerprint of the PGP key used to encrypt the password.
  "
  EOF
  value       = module.iam_user.iam_user_login_profile_key_fingerprint
}

output "iam_user_name" {
  description = <<EOF
  "
  The user's name.
  "
  EOF
  value       = module.iam_user.iam_user_name
}

output "iam_user_ssh_key_fingerprint" {
  description = <<EOF
  "
  The MD5 message digest of the SSH public key.
  "
  EOF
  value       = module.iam_user.iam_user_ssh_key_fingerprint
}

output "iam_user_ssh_key_ssh_public_key_id" {
  description = <<EOF
  "
  The unique identifier for the SSH public key.
  "
  EOF
  value       = module.iam_user.iam_user_ssh_key_ssh_public_key_id
}

output "iam_user_unique_id" {
  description = <<EOF
  "
  The unique ID assigned by AWS.
  "
  EOF
  value       = module.iam_user.iam_user_unique_id
}

output "keybase_password_decrypt_command" {
  description = <<EOF
  "
  Decrypt user password command.
  "
  EOF
  value       = module.iam_user.keybase_password_decrypt_command
}

output "keybase_password_pgp_message" {
  description = <<EOF
  "
  Encrypted password.
  "
  EOF
  value       = module.iam_user.keybase_password_pgp_message
}

output "keybase_secret_key_decrypt_command" {
  description = <<EOF
  "
  Decrypt access secret key command.
  "
  EOF
  value       = module.iam_user.keybase_secret_key_decrypt_command
}

output "keybase_secret_key_pgp_message" {
  description = <<EOF
  "
  Encrypted access secret key.
  "
  EOF
  value       = module.iam_user.keybase_secret_key_pgp_message
}

output "pgp_key" {
  description = <<EOF
  "
  PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted).
  "
  EOF
  value       = module.iam_user.pgp_key
}
