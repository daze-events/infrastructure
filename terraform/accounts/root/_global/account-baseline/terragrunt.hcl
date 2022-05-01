terraform {
  source = "git::git@github.com:gruntwork-io/terraform-aws-service-catalog.git//modules/landingzone/account-baseline-root?ref=v0.85.2"

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

inputs = {
  # If you've already created an AWS Organization in your root account, you'll be able to import it later in this guide
  create_organization = true

  organizations_enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "BACKUP_POLICY",
    "TAG_POLICY",
  ]

  organizations_default_tags = {
    Organization = "Daze-Events",
  }

  # The child AWS accounts to create in this AWS organization
  child_accounts = {
    logs = {
      email = "daze.events.manager+logs@gmail.com"

      # Mark this account as the logs account, used to aggregate all AWS Config and CloudTrail data.
      is_logs_account = true
      tags = {
        Environment = "Logs"
      }
    },

    security = {
      email = "daze.events.manager+security@gmail.com"
      tags = {
        Environment = "Security"
      }
    },

    shared = {
      email = "daze.events.manager+shared@gmail.com"
      tags = {
        Environment = "Shared"
      }
    },

    dev = {
      email = "daze.events.manager+dev@gmail.com"
      tags = {
        Environment = "Dev"
      }
    },

    stage = {
      email = "daze.events.manager+stage@gmail.com"
      tags = {
        Environment = "Stage"
      }
    },

    prod = {
      email = "daze.events.manager+prod@gmail.com"
      tags = {
        Environment = "Prod"
      }
    }

  }

  enable_config     = false
  enable_cloudtrail = false

  # The IAM users to create in this account. Since this is the root account, you should only create IAM users for a
  # small handful of trusted admins.
  #
  # NOTE: Make sure to include the IAM user you created manually here! We'll import the user into Terraform state in
  # the next step of this guide, allowing you to manage this user as code going forward.
  users = {
    "alexander.candfield" = {
      groups               = ["full-access", "billing", ]
      pgp_key              = "keybase:alex_candfield"
      create_login_profile = false
      create_access_keys   = false
    }

    "iacopo.antonelli" = {
      groups               = ["full-access", "billing", ]
      pgp_key              = "keybase:iacopo_antonelli"
      create_login_profile = false
      create_access_keys   = false
    }
  }
  force_destroy_users = true
}
