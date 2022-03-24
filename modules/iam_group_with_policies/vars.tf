#############################################
#          iam_group_with_policies          #
#############################################

variable "create_group" {
  description = <<EOF
  "Whether to create IAM group."
  EOF
  type        = bool
  default     = true
}

variable "name" {
  description = <<EOF
  "Name of IAM group."
  EOF
  type        = string
}

variable "group_users" {
  description = <<EOF
  "List of IAM users to have in an IAM group which can assume the role."
  EOF
  type        = list(string)
  default     = []
}

variable "custom_group_policy_arns" {
  description = <<EOF
  "List of IAM policies ARNs to attach to IAM group."
  EOF
  type        = list(string)
  default     = []
}

variable "custom_group_policies" {
  description = <<EOF
  "List of maps of inline IAM policies to attach to IAM group.
  Should have `name` and `policy` keys in each element."
  EOF
  type        = list(map(string))
  default     = []
}

variable "attach_iam_self_management_policy" {
  description = <<EOF
  "Whether to attach IAM policy which allows IAM users to manage their credentials and MFA."
  EOF
  type        = bool
  default     = true
}

variable "iam_self_management_policy_name_prefix" {
  description = <<EOF
  "Name prefix for IAM policy to create with IAM self-management permissions."
  EOF
  type        = string
  default     = "IAMSelfManagement-"
}

variable "aws_account_id" {
  description = <<EOF
  "AWS account id to use inside IAM policies. If empty, current AWS account ID will be used."
  EOF
  type        = string
  default     = ""
}

variable "tags" {
  description = <<EOF
  "A map of tags to add to all resources."
  EOF
  type        = map(string)
  default     = {}
}
