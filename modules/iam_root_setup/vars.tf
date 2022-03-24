#################################
#          iam_account          #
#################################

variable "account_alias" {
  description = <<EOF
  "AWS IAM account alias for this account."
  EOF
  type        = string
}

variable "allow_users_to_change_password" {
  description = <<EOF
  "Whether to allow users to change their own password."
  EOF
  type        = bool
  default     = true
}

variable "get_caller_identity" {
  description = <<EOF
  "Whether to get AWS account ID, User ID, and ARN in which Terraform is authorized."
  EOF
  type        = bool
  default     = true
}

variable "hard_expiry" {
  description = <<EOF
  "Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)."
  EOF
  type        = bool
  default     = false
}

variable "create_account_password_policy" {
  description = <<EOF
  "Whether to create AWS IAM account password policy."
  EOF
  type        = bool
  default     = true
}

variable "max_password_age" {
  description = <<EOF
  "The number of days that an user password is valid."
  EOF
  type        = number
  default     = 60
}

variable "minimum_password_length" {
  description = <<EOF
  "Minimum length to require for user passwords."
  EOF
  type        = number
  default     = 12
}

variable "password_reuse_prevention" {
  description = <<EOF
  "The number of previous passwords that users are prevented from reusing."
  EOF
  type        = number
  default     = 3
}

variable "require_lowercase_characters" {
  description = <<EOF
  "Whether to require lowercase characters for user passwords."
  EOF
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = <<EOF
  "Whether to require numbers for user passwords."
  EOF
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = <<EOF
  "Whether to require symbols for user passwords."
  EOF
  type        = bool
  default     = true
}

variable "require_uppercase_characters" {
  description = <<EOF
  "Whether to require uppercase characters for user passwords."
  EOF
  type        = bool
  default     = true
}
