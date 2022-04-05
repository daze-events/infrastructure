terraform {
  source = "git::git@github.com:gruntwork-io/terraform-aws-service-catalog.git//modules/landingzone/account-baseline-security?ref=v0.85.2"

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
  # config_s3_bucket_name     = "<CONFIG_BUCKET_NAME>"

  enable_config             = false
  config_central_account_id = local.accounts.logs

  # Enable the IAM groups you want
  should_create_iam_group_full_access    = true
  should_create_iam_group_read_only      = true
  should_create_iam_group_user_self_mgmt = true

  # Configure the names for IAM groups
  iam_group_name_full_access        = "full-access"
  iam_group_name_read_only          = "read-only"
  iam_group_name_iam_user_self_mgmt = "iam-user-self-mgmt"
  # iam_group_names_ssh_grunt_sudo_users  = ["ssh-grunt-sudo-users"]
  # iam_group_names_ssh_grunt_users       = ["ssh-grunt-users"]

  # Create IAM groups that grant access to the other AWS accounts
  iam_groups_for_cross_account_access = [

    ################################################################################
    #                                                                              #
    #                             DEVELOPMENT ACCOUNT                              #
    #                                                                              #
    ################################################################################
    {
      group_name    = "_account.dev-full-access",
      iam_role_arns = ["arn:aws:iam::${local.accounts.dev.id}:role/allow-full-access-from-other-accounts"]
    },
    {
      group_name    = "_account.dev-read-only",
      iam_role_arns = ["arn:aws:iam::${local.accounts.dev.id}:role/allow-read-only-access-from-other-accounts"]
    },
    {
      group_name    = "_account.dev-dev",
      iam_role_arns = ["arn:aws:iam::${local.accounts.dev.id}:role/allow-dev-access-from-other-accounts"]
    },
    # {
    #   group_name    = "_account.dev-openvpn-admins",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.dev.id}:role/openvpn-allow-certificate-revocations-for-external-accounts"]
    # },
    # {
    #   group_name    = "_account.dev-openvpn-users",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.dev.id}:role/openvpn-allow-certificate-requests-for-external-accounts"]
    # },

    ################################################################################
    #                                                                              #
    #                               STAGING ACCOUNT                                #
    #                                                                              #
    ################################################################################

    {
      group_name    = "_account.stage-full-access",
      iam_role_arns = ["arn:aws:iam::${local.accounts.stage.id}:role/allow-full-access-from-other-accounts"]
    },
    {
      group_name    = "_account.stage-read-only",
      iam_role_arns = ["arn:aws:iam::${local.accounts.stage.id}:role/allow-read-only-access-from-other-accounts"]
    },
    {
      group_name    = "_account.stage-dev",
      iam_role_arns = ["arn:aws:iam::${local.accounts.stage.id}:role/allow-dev-access-from-other-accounts"]
    },
    # {
    #   group_name    = "_account.stage-openvpn-admins",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.stage.id}:role/openvpn-allow-certificate-revocations-for-external-accounts"]
    # },
    # {
    #   group_name    = "_account.stage-openvpn-users",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.stage.id}:role/openvpn-allow-certificate-requests-for-external-accounts"]
    # },

    ################################################################################
    #                                                                              #
    #                              PRODUCTION ACCOUNT                              #
    #                                                                              #
    ################################################################################

    {
      group_name    = "_account.prod-full-access",
      iam_role_arns = ["arn:aws:iam::${local.accounts.prod.id}:role/allow-full-access-from-other-accounts"]
    },
    {
      group_name    = "_account.prod-read-only",
      iam_role_arns = ["arn:aws:iam::${local.accounts.prod.id}:role/allow-read-only-access-from-other-accounts"]
    },
    {
      group_name    = "_account.prod-dev",
      iam_role_arns = ["arn:aws:iam::${local.accounts.prod.id}:role/allow-dev-access-from-other-accounts"]
    },
    # {
    #   group_name    = "_account.prod-openvpn-admins",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.prod.id}:role/openvpn-allow-certificate-revocations-for-external-accounts"]
    # },
    # {
    #   group_name    = "_account.prod-openvpn-users",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.prod.id}:role/openvpn-allow-certificate-requests-for-external-accounts"]
    # },

    ################################################################################
    #                                                                              #
    #                               LOGGING ACCOUNT                                #
    #                                                                              #
    ################################################################################

    {
      group_name    = "_account.logs-full-access",
      iam_role_arns = ["arn:aws:iam::${local.accounts.logs.id}:role/allow-full-access-from-other-accounts"]
    },
    {
      group_name    = "_account.logs-read-only",
      iam_role_arns = ["arn:aws:iam::${local.accounts.logs.id}:role/allow-read-only-access-from-other-accounts"]
    },
    {
      group_name    = "_account.logs-dev",
      iam_role_arns = ["arn:aws:iam::${local.accounts.logs.id}:role/allow-dev-access-from-other-accounts"]
    },
    # {
    #   group_name    = "_account.logs-openvpn-admins",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.logs.id}:role/openvpn-allow-certificate-revocations-for-external-accounts"]
    # },
    # {
    #   group_name    = "_account.logs-openvpn-users",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.logs.id}:role/openvpn-allow-certificate-requests-for-external-accounts"]
    # },

    ################################################################################
    #                                                                              #
    #                                SHARED ACCOUNT                                #
    #                                                                              #
    ################################################################################

    {
      group_name    = "_account.shared-full-access",
      iam_role_arns = ["arn:aws:iam::${local.accounts.shared.id}:role/allow-full-access-from-other-accounts"]
    },
    {
      group_name    = "_account.shared-read-only",
      iam_role_arns = ["arn:aws:iam::${local.accounts.shared.id}:role/allow-read-only-access-from-other-accounts"]
    },
    {
      group_name    = "_account.shared-dev",
      iam_role_arns = ["arn:aws:iam::${local.accounts.shared.id}:role/allow-dev-access-from-other-accounts"]
    },
    # {
    #   group_name    = "_account.shared-openvpn-admins",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.shared.id}:role/openvpn-allow-certificate-revocations-for-external-accounts"]
    # },
    # {
    #   group_name    = "_account.shared-openvpn-users",
    #   iam_role_arns = ["arn:aws:iam::${local.accounts.shared.id}:role/openvpn-allow-certificate-requests-for-external-accounts"]
    # },

  ]

  # Create all the IAM users for your company and assign them to IAM groups
  users = {
    "alexander.candfield" = {
      groups = [
        "iam-user-self-mgmt",
        "full-access",
        "_all-accounts",
      ]
      pgp_key              = "keybase:alex_candfield"
      create_login_profile = true
      create_access_keys   = false
    }

    "iacopo.antonelli" = {
      groups = [
        "iam-user-self-mgmt",
        "_account.dev-dev",
        "_account.stage-dev",
        "_account.prod-dev",
        "_account.logs-read-only",
        "_account.shared-read-only",
      ]
      pgp_key              = "keybase:iacopo_antonelli"
      create_login_profile = true
      create_access_keys   = false
    }
  }

  # # Allow accounts to have read access to IAM groups and the public SSH keys of users in the group.
  # allow_ssh_grunt_access_from_other_account_arns = [
  #   for name, id in local.accounts :
  #     "arn:aws:iam::${id}:root" if name != "security"
  # ]
  iam_group_names_ssh_grunt_sudo_users = []
  iam_group_names_ssh_grunt_users      = []
}
