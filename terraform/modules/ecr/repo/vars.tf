
#####################################################
#                  Required inputs                  #
#####################################################
variable "name" {
  description = <<EOT
  "
  Name of the repository.
  "
  EOT
  type        = string
}

#####################################################
#                  Optional inputs                  #
#####################################################
variable "encryption_configuration_type" {
  description = <<EOT
  "
  The encryption type to use for the repository.
  Valid values are `AES256` or `KMS`.
  Defaults to `AES256`.
  "
  EOT
  type        = string
  default     = "AES256"
}

variable "encryption_configuration_kms_key_arn" {
  description = <<EOT
  "
  The ARN of the KMS key to use when `encryption_type` is `KMS`.
  If not specified, uses the default AWS managed key for ECR.
  "
  EOT
  type        = string
  default     = ""
}

variable "image_tag_mutability" {
  description = <<EOT
  "
  The tag mutability setting for the repository.
  Must be one of: `MUTABLE` or `IMMUTABLE`.
  Defaults to `MUTABLE`.
  "
  EOT
  type        = string
  default     = "MUTABLE"
}

variable "image_scanning_scan_on_push" {
  description = <<EOT
  "
  Indicates whether images are scanned (or not) after being pushed to the repository.
  By default, image scanning must be manually triggered.
  "
  EOT
  type        = bool
  default     = false
}

variable "tags" {
  description = <<EOT
  "
  A map of tags to assign to the resource.
  If configured with a provider `default_tags` configuration block present,
  tags with matching keys will overwrite those defined at the provider-level.
  "
  EOT
  type        = map(string)
  default     = {}
}

variable "allowed_aws_account_ids" {
  description = <<EOF
  "
  List of AWS Account IDs allowed to push/pull to/from the ECR repository.
  "
  EOF
  type        = list(string)
  default     = [""]
}
