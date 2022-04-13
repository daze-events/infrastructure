# terraform {
#   # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
#   # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
#   required_version = "= 1.1.8"

#   required_providers {
#     aws = {
#       version = "~> 3.0"
#       source  = "hashicorp/aws"
#     }
#   }
# }

# provider "aws" {
#   # The AWS region in which all resources will be created
#   region = var.aws_region

#   # Only these AWS Account IDs may be operated on by this template
#   allowed_account_ids = [var.aws_account_id]
# }

module "kms_master_key" {
  source = "git@github.com:gruntwork-io/terraform-aws-security.git//modules/kms-master-key?ref=v0.63.1"

  customer_master_keys             = var.customer_master_keys
  default_deletion_window_in_days  = var.default_deletion_window_in_days
  global_tags                      = var.global_tags
  default_enable_key_rotation      = var.default_enable_key_rotation
  default_multi_region             = var.default_multi_region
  default_customer_master_key_spec = var.default_customer_master_key_spec
  dependencies                     = var.dependencies
}
