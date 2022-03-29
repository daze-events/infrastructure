variable "admin_role_policy_arn" {
  description = <<EOF
"
Policy ARN to use for admin role.
"
EOF
  type        = string
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "attach_admin_policy" {
  description = <<EOF
"
Whether to attach an admin policy to a role.
"
EOF
  type        = bool
  default     = false
}

variable "attach_poweruser_policy" {
  description = <<EOF
"
Whether to attach a poweruser policy to a role.
"
EOF
  type        = bool
  default     = false
}

variable "attach_readonly_policy" {
  description = <<EOF
"
Whether to attach a readonly policy to a role.
"
EOF
  type        = bool
  default     = false
}

variable "create_instance_profile" {
  description = <<EOF
"
Whether to create an instance profile.
"
EOF
  type        = bool
  default     = false
}

variable "create_role" {
  description = <<EOF
"
Whether to create a role.
"
EOF
  type        = bool
  default     = false
}

variable "custom_role_policy_arns" {
  description = <<EOF
  "
  List of ARNs of IAM policies to attach to IAM role.
  "
  EOF
  type        = list(string)
  default     = []
}

variable "custom_role_trust_policy" {
  description = <<EOF
  "
  A custom role trust policy.
  "
  EOF
  type        = string
  default     = ""
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
  default     = 14400
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

variable "number_of_custom_role_policy_arns" {
  description = <<EOF
  "
  Number of IAM policies to attach to IAM role.
  "
  EOF
  type        = number
  default     = null
}

variable "poweruser_role_policy_arn" {
  description = <<EOF
  "
  Policy ARN to use for poweruser role.
  "
  EOF
  type        = string
  default     = "arn:aws:iam::aws:policy/PowerUserAccess"
}

variable "readonly_role_policy_arn" {
  description = <<EOF
  "
  Policy ARN to use for readonly role.
  "
  EOF
  type        = string
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "role_description" {
  description = <<EOF
  "
  IAM Role description.
  "
  EOF
  type        = string
  default     = ""
}

variable "role_name" {
  description = <<EOF
  "
  IAM role name.
  "
  EOF
  type        = string
  default     = ""
}

variable "role_path" {
  description = <<EOF
  "
  Path of IAM role.
  "
  EOF
  type        = string
  default     = "/"
}

variable "role_permissions_boundary_arn" {
  description = <<EOF
  "
  Permissions boundary ARN to use for IAM role.
  "
  EOF
  type        = string
  default     = ""
}

variable "role_requires_mfa" {
  description = <<EOF
  "
  Whether role requires MFA.
  "
  EOF
  type        = bool
  default     = true
}

variable "role_sts_externalid" {
  description = <<EOF
  "
  STS ExternalId condition values to use with a role (when MFA is not required).
  "
  EOF
  type        = any
  default     = []
}

variable "tags" {
  description = <<EOF
  "
  A map of tags to add to IAM role resources.
  "
  EOF
  type        = map(string)
  default     = {}
}

variable "trusted_role_actions" {
  description = <<EOF
  "
  Actions of STS.
  "
  EOF
  type        = list(string)
  default = [
    "sts:AssumeRole"
  ]
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
