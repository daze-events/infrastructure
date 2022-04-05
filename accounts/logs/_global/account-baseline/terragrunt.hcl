terraform {
  source = "git::git@github.com:gruntwork-io/terraform-aws-service-catalog.git//modules/landingzone/account-baseline-app?ref=v0.85.2"

  # This module deploys some resources (e.g., AWS Config) across all AWS regions, each of which needs its own provider,
  # which in Terraform means a separate process. To avoid all these processes thrashing the CPU, which leads to network
  # connectivity issues, we limit the parallelism here.
  extra_arguments "parallelism" {
    commands  = get_terraform_commands_that_need_parallelism()
    arguments = ["-parallelism=2"]
  }
}

include {
  path = find_in_parent_folders()
}

locals {

  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  # A local for more convenient access to the accounts map.
  accounts = local.common_vars.locals.accounts

  # A local for convenient access to the security account root ARN.
  security_account_root_arn = "arn:aws:iam::${local.accounts.security.id}:root"
}

inputs = {
  # Use the S3 bucket and KMS key that were already created in the logs account by account-baseline-root
  # This is already defined in the common.hcl
  # cloudtrail_s3_bucket_name = "<CLOUDTRAIL_BUCKET_NAME>"
  # cloudtrail_kms_key_arn    = "<CLOUDTRAIL_KMS_KEY_ARN>"

  enable_cloudtrail = false

  # All of the other accounts send logs to this account.
  cloudtrail_allow_kms_describe_key_to_external_aws_accounts = true
  cloudtrail_external_aws_account_ids_with_write_access = [
    for account in local.accounts :
    account.id if account != "logs"
  ]

  custom_cloudtrail_trail_name = local.common_vars.locals.organization_name

  enable_config = false
  # Use the S3 bucket that was already created in the logs account by account-baseline-root
  # config_s3_bucket_name                            = "<CONFIG_BUCKET_NAME>"
  config_aggregate_config_data_in_external_account = false
  config_central_account_id                        = local.accounts.logs
  config_force_destroy                             = false

  # This is the Logs account, so we create the S3 bucket and SNS topic for aggregating Config logs from all accounts.
  config_should_create_s3_bucket = true
  config_should_create_sns_topic = true

  # All of the other accounts send logs to this account.
  config_linked_accounts = [
    for account in local.accounts :
    account.id if account != "logs"
  ]

  # Allow users in the security account to assume IAM roles in this account
  allow_full_access_from_other_account_arns      = [local.security_account_root_arn]
  allow_read_only_access_from_other_account_arns = [local.security_account_root_arn]
  allow_logs_access_from_other_account_arns      = [local.security_account_root_arn]
}
