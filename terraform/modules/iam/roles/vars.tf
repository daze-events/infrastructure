variable "admin_role_name" {
  description = <<EOF
  "
  IAM role with admin access.
  "
  EOF
  type        = string
  default     = "admin"
}

variable "admin_role_path" {
  description = <<EOF
  "
  Path of admin IAM role.
  "
  EOF
  type        = string
  default     = "/"
}

variable "admin_role_permissions_boundary_arn" {
  description = <<EOF
  "
  Permissions boundary ARN to use for admin role.
  "
  EOF
  type        = string
  default     = ""
}

variable "admin_role_policy_arns" {
  description = <<EOF
  "
  List of policy ARNs to use for admin role.
  "
  EOF
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

variable "admin_role_requires_mfa" {
  description = <<EOF
  "
  Whether admin role requires MFA.
  "
  EOF
  type        = bool
  default     = true
}

variable "admin_role_tags" {
  description = <<EOF
  "
  A map of tags to add to admin role resource.
  "
  EOF
  type        = map(string)
  default     = {}
}

variable "create_admin_role" {
  description = <<EOF
  "
  Whether to create admin role.
  "
  EOF
  type        = bool
  default     = false
}

variable "create_poweruser_role" {
  description = <<EOF
  "
  Whether to create poweruser role.
  "
  EOF
  type        = bool
  default     = false
}

variable "create_readonly_role" {
  description = <<EOF
  "
  Whether to create readonly role.
  "
  EOF
  type        = bool
  default     = false
}

variable "force_detach_policies" {
  description = <<EOF
  "
  Whether policies should be detached from this role when destroying.
  "
  EOF
  type        = bool
  default     = false
}

variable "max_session_duration" {
  description = <<EOF
  "
  Maximum CLI/API session duration in seconds between 3600 and 43200.
  "
  EOF
  type        = number
  default     = 3600
}

variable "mfa_age" {
  description = <<EOF
  "
  Max age of valid MFA (in seconds) for roles which require MFA.
  "
  EOF
  type        = number
  default     = 86400
}

variable "poweruser_role_name" {
  description = <<EOF
  "
  IAM role with poweruser access.
  "
  EOF
  type        = string
  default     = "poweruser"
}

variable "poweruser_role_path" {
  description = <<EOF
  "
  Path of poweruser IAM role.
  "
  EOF
  type        = string
  default     = "/"
}

variable "poweruser_role_permissions_boundary_arn" {
  description = <<EOF
  "
  Permissions boundary ARN to use for poweruser role.
  "
  EOF
  type        = string
  default     = ""
}

variable "poweruser_role_policy_arns" {
  description = <<EOF
  "
  List of policy ARNs to use for poweruser role.
  "
  EOF
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/PowerUserAccess"
  ]
}

variable "poweruser_role_requires_mfa" {
  description = <<EOF
  "
  Whether poweruser role requires MFA.
  "
  EOF
  type        = bool
  default     = true
}

variable "poweruser_role_tags" {
  description = <<EOF
  "
  A map of tags to add to poweruser role resource.
  "
  EOF
  type        = map(string)
  default     = {}
}

variable "readonly_role_name" {
  description = <<EOF
  "
  IAM role with readonly access.
  "
  EOF
  type        = string
  default     = "readonly"
}

variable "readonly_role_path" {
  description = <<EOF
  "
  Path of readonly IAM role.
  "
  EOF
  type        = string
  default     = "/"
}

variable "readonly_role_permissions_boundary_arn" {
  description = <<EOF
  "
  Permissions boundary ARN to use for readonly role.
  "
  EOF
  type        = string
  default     = ""
}

variable "readonly_role_policy_arns" {
  description = <<EOF
  "
  List of policy ARNs to use for readonly role.
  "
  EOF
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
}

variable "readonly_role_requires_mfa" {
  description = <<EOF
  "
  Whether readonly role requires MFA.
  "
  EOF
  type        = bool
  default     = true
}

variable "readonly_role_tags" {
  description = <<EOF
  "
  A map of tags to add to readonly role resource.
  "
  EOF
  type        = map(string)
  default     = {}
}

variable "trusted_role_arns" {
  description = <<EOF
  "
  ARNs of AWS entities who can assume these roles.
  "
  EOF
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = <<EOF
  "
  AWS Services that can assume these roles.
  "
  EOF
  type        = list(string)
  default     = []
}
