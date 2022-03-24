variable "name" {
  description = <<EOF
  "
  Desired name for the IAM user.
  "
  EOF
  type        = string
}

variable "create_iam_access_key" {
  description = <<EOF
  "
  Whether to create IAM access key.
  "
  EOF
  type        = bool
  default     = true
}

variable "create_iam_user_login_profile" {
  description = <<EOF
  "
  Whether to create IAM user login profile.
  "
  EOF
  type        = bool
  default     = true
}

variable "create_user" {
  description = <<EOF
  "
  Whether to create the IAM user.
  "
  EOF
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = <<EOF
  "
  When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices.
  Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed.
  "
  EOF
  type        = bool
  default     = false
}

variable "password_length" {
  description = <<EOF
  "
  The length of the generated password.
  "
  EOF
  type        = number
  default     = 20
}

variable "password_reset_required" {
  description = <<EOF
  "
  Whether the user should be forced to reset the generated password on first login.
  "
  EOF
  type        = bool
  default     = true
}

variable "path" {
  description = <<EOF
  "
  Desired path for the IAM user.
  "
  EOF
  type        = string
  default     = "/"
}

variable "permissions_boundary" {
  description = <<EOF
  "
  The ARN of the policy that is used to set the permissions boundary for the user.
  "
  EOF
  type        = string
  default     = ""
}

variable "pgp_key" {
  description = <<EOF
  "
  Either a base-64 encoded PGP public key, or a keybase username in the form "keybase:username".
  Used to encrypt password and access key.
  "pgp_key" is required when "create_iam_user_login_profile" is set to "true"
  "
  EOF
  type        = string
  default     = ""
}

variable "ssh_key_encoding" {
  description = <<EOF
  "
  Specifies the public key encoding format to use in the response.
  To retrieve the public key in ssh-rsa format, use SSH.
  To retrieve the public key in PEM format, use PEM.
  "
  EOF
  type        = string
  default     = "SSH"
}

variable "ssh_public_key" {
  description = <<EOF
  "
  The SSH public key.
  The public key must be encoded in ssh-rsa format or PEM format.
  "
  EOF
  type        = string
  default     = ""
}

variable "tags" {
  description = <<EOF
  "
  A map of tags to add to all resources.
  "
  EOF
  type        = map(string)
  default     = {}
}

variable "upload_iam_user_ssh_key" {
  description = <<EOF
  "
  Whether to upload a public ssh key to the IAM user.
  "
  EOF
  type        = bool
  default     = false
}
