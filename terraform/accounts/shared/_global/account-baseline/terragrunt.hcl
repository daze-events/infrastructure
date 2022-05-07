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
  # cloudtrail_s3_bucket_name = "<CLOUDTRAIL_BUCKET_NAME>"
  # cloudtrail_kms_key_arn    = "<CLOUDTRAIL_KMS_KEY_ARN>"
  enable_cloudtrail = false

  # Use the S3 bucket that was already created in the logs account by account-baseline-root
  # config_s3_bucket_name                            = "<CONFIG_BUCKET_NAME>"

  enable_config                                    = false
  config_aggregate_config_data_in_external_account = true
  config_central_account_id                        = local.accounts.logs.id

  # Specify the services the dev IAM role will have access to
  dev_permitted_services = ["ec2", "s3", "rds", "dynamodb", "elasticache", "eks", "ecs"]

  # Specify the services the auto-deploy IAM role will have access to
  # auto_deploy_permissions = ["cloudwatch:*", "logs:*", "dynamodb:*", "ecr:*", "ecs:*", "iam:GetPolicy", "iam:GetPolicyVersion", "iam:ListEntitiesForPolicy", "eks:DescribeCluster", "route53:*", "s3:*", "autoscaling:*", "elasticloadbalancing:*", "iam:GetRole", "iam:GetRolePolicy", "iam:PassRole"]

  # Allow users in the security account to access the IAM roles in this account
  allow_read_only_access_from_other_account_arns = [local.security_account_root_arn]
  allow_billing_access_from_other_account_arns   = [local.security_account_root_arn]
  allow_dev_access_from_other_account_arns       = [local.security_account_root_arn]
  allow_full_access_from_other_account_arns      = [local.security_account_root_arn]

  ### GITHUB ACTIONS ACCESS ###
  enable_github_actions_access = true

  allow_auto_deploy_from_github_actions_for_sources = {
    "daze-events/infrastructure" = ["main"]
  }

  auto_deploy_permissions = [
    "ecr:GetAuthorizationToken",
    "ecr:BatchCheckLayerAvailability",
    "ecr:GetDownloadUrlForLayer",
    "ecr:GetRepositoryPolicy",
    "ecr:DescribeRepositories",
    "ecr:ListImages",
    "ecr:DescribeImages",
    "ecr:BatchGetImage",
    "ecr:GetLifecyclePolicy",
    "ecr:GetLifecyclePolicyPreview",
    "ecr:ListTagsForResource",
    "ecr:DescribeImageScanFindings",
    "ecr:InitiateLayerUpload",
    "ecr:UploadLayerPart",
    "ecr:CompleteLayerUpload",
    "ecr:PutImage",
  ]
  #############################

  # A list of account root ARNs that should be able to assume the auto deploy role.
  # allow_auto_deploy_from_other_account_arns = [
  #   # External CI/CD systems may use an IAM user in the security account to perform deployments.
  #   local.security_account_root_arn,

  #   # The shared-services account contains automation and infrastructure tools, such as CI/CD systems.
  #   # "arn:aws:iam::${local.accounts.shared}:root",
  # ]
}
