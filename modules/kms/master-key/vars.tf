# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# These variables must be passed in by the operator.
# ---------------------------------------------------------------------------------------------------------------------

# AWS Terminology Explained:
# - Customer Master Key (CMK): A key used to encrypt/decrypt arbitrary data, or to generate a Data Key that can be used
#                              to encrypt/decrypt a higher volume of arbitrary data. See this module's README for details.

variable "name" {
  description = ""
  type        = string
}

variable "cmk_administrator_iam_arns" {
  description = ""
  type        = list(string)
}

variable "cmk_user_iam_arns" {
  description = ""
  type        = list(any)
}

variable "cmk_external_user_iam_arns" {
  description = ""
  type        = list(string)
  default     = []
}

variable "allow_manage_key_permissions_with_iam" {
  description = ""
  type        = bool
}

variable "customer_master_keys" {
  description = "Map of CMK names to spec for managing each key. Each entry in the map corresponds to a key that will be created by this template."
  # Ideally, we will use a more strict type here but since we want to support required and optional values, and since
  # Terraform's type system only supports maps that have the same type for all values, we have to use the less useful
  # `any` type.
  type    = any
  default = {}

  # Each entry in the map supports the following attributes:
  #
  # OPTIONAL (defaults to value of corresponding module input):
  # - cmk_administrator_iam_arns              list(string)          : A list of IAM ARNs for users who should be given
  #                                                                   administrator access to this CMK (e.g.
  #                                                                   arn:aws:iam::<aws-account-id>:user/<iam-user-arn>).
  # - cmk_user_iam_arns                       list(object[CMKUser]) : A list of IAM ARNs for users who should be given
  #                                                                   permissions to use this CMK (e.g.
  #                                                                   arn:aws:iam::<aws-account-id>:user/<iam-user-arn>).
  # - cmk_read_only_user_iam_arns             list(object[CMKUser]) : A list of IAM ARNs for users who should be given
  #                                                                   read-only (decrypt-only) permissions to use this CMK (e.g.
  #                                                                   arn:aws:iam::<aws-account-id>:user/<iam-user-arn>).
  # - cmk_describe_only_user_iam_arns         list(object[CMKUser]) : A list of IAM ARNs for users who should be given
  #                                                                   describe-only (kms:DescribeKey) permissions to use this CMK (e.g.
  #                                                                   arn:aws:iam::<aws-account-id>:user/<iam-user-arn>). This is
  #                                                                   useful for deploying services that depend on the
  #                                                                   key (e.g., Cloudtrail) in other accounts, to trade
  #                                                                   key aliases for CMK ARNs.
  # - cmk_external_user_iam_arns              list(string)          : A list of IAM ARNs for users from external AWS accounts
  #                                                                   who should be given permissions to use this CMK (e.g.
  #                                                                   arn:aws:iam::<aws-account-id>:root).
  # - allow_manage_key_permissions_with_iam   bool                  : If true, both the CMK's Key Policy and IAM Policies
  #                                                                   (permissions) can be used to grant permissions on the CMK.
  #                                                                   If false, only the CMK's Key Policy can be used to grant
  #                                                                   permissions on the CMK. False is more secure (and
  #                                                                   generally preferred), but true is more flexible and
  #                                                                   convenient.
  # - deletion_window_in_days                 number                : The number of days to keep this KMS Master Key around after it has been
  #                                                                   marked for deletion.
  # - tags                                    map(string)           : A map of tags to apply to the KMS Key to be created. In this map
  #                                                                   variable, the key is the tag name and the value  is the tag value. Note
  #                                                                   that this map is merged with var.global_tags, and can be used to override
  #                                                                   tags specified in that variable.
  # - enable_key_rotation                     bool                  : Whether to enable automatic annual rotation of the KMS key.
  # - multi_region                            bool                  : Whether to enable multi-region replication for the KMS key.
  # - spec                                    string                : Specifies whether the key contains a symmetric key or an asymmetric key
  #                                                                   pair and the encryption algorithms or signing algorithms that the key
  #                                                                   supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096,
  #                                                                   ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1.
  # - cmk_service_principals                  list(object[ServicePrincipal]) : A list of Service Principals that should be given
  #                                                                            permissions to use this CMK (e.g. s3.amazonaws.com). See
  #                                                                            below for the structure of the object that should be passed
  #                                                                            in.
  #
  # Structure of ServicePrincipal object:
  # - name          string                   : The name of the service principal (e.g.: s3.amazonaws.com).
  # - actions       list(string)             : The list of actions that the given service principal is allowed to
  #                                            perform (e.g. ["kms:DescribeKey", "kms:GenerateDataKey"]).
  # - conditions    list(object[Condition])  : (Optional) List of conditions to apply to the permissions for the service
  #                                            principal. Use this to apply conditions on the permissions for
  #                                            accessing the KMS key (e.g., only allow access for certain encryption
  #                                            contexts). The condition object accepts the same fields as the condition
  #                                            block on the IAM policy document (See
  #                                            https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html#condition).
  # Structure of CMKUser object:
  # - name          list(string)             : The list of names of the AWS principal (e.g.: arn:aws:iam::0000000000:user/dev).
  # - conditions    list(object[Condition])  : (Optional) List of conditions to apply to the permissions for the CMK User
  #                                            Use this to apply conditions on the permissions for accessing the KMS key
  #                                            (e.g., only allow access for certain encryption contexts).
  #                                            The condition object accepts the same fields as the condition
  #                                            block on the IAM policy document (See
  #                                            https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#condition).
  # Example:
  # customer_master_keys = {
  #   cmk-stage = {
  #     cmk_administrator_iam_arns            = ["arn:aws:iam::0000000000:user/admin"]
  #     cmk_user_iam_arns                     = [
  #       {
  #         name = ["arn:aws:iam::0000000000:user/dev"]
  #         conditions = []
  #       }
  #     ]
  #     cmk_read_only_user_iam_arns           = [
  #       {
  #         name = ["arn:aws:iam::0000000000:user/qa"]
  #         conditions = []
  #       }
  #     ]
  #     cmk_describe_only_user_iam_arns       = [
  #       {
  #         name = ["arn:aws:iam::0000000000:user/qa"]
  #         conditions = []
  #       }
  #     ]
  #     cmk_external_user_iam_arns            = ["arn:aws:iam::1111111111:user/root"]
  #     cmk_service_principals                = [
  #       {
  #         name       = "s3.amazonaws.com"
  #         actions    = ["kms:Encrypt"]
  #         conditions = []
  #       }
  #     ]
  #   }
  #   cmk-prod = {
  #     cmk_administrator_iam_arns            = ["arn:aws:iam::0000000000:user/admin"]
  #     cmk_user_iam_arns                     = [
  #       {
  #         name = ["arn:aws:iam::0000000000:user/prod"]
  #         conditions = []
  #       }
  #     ]
  #     allow_manage_key_permissions_with_iam = true
  #     # Override the default value for all keys configured with var.default_deletion_window_in_days
  #     deletion_window_in_days = 7
  #
  #     # Set extra tags on the CMK for prod
  #     tags = {
  #       Environment = "prod"
  #     }
  #   }
  # }
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL MODULE PARAMETERS
# These variables have defaults, but may be overridden by the operator.
# ---------------------------------------------------------------------------------------------------------------------

variable "default_deletion_window_in_days" {
  description = "The default value to use for deletion_window_in_days (the number of days to keep this KMS Master Key around after it has been marked for deletion). Applies to all keys, unless overridden in the customer_master_keys map."
  type        = number
  default     = 30
}

variable "global_tags" {
  description = "A map of tags to apply to all KMS Keys to be created. In this map variable, the key is the tag name and the value  is the tag value."
  type        = map(string)
  default     = {}
}

# AWS will rotate the key annually and retain old keys
# There is no downside to enabling key rotation. You can set this to false if you'd prefer to rotate keys manually
# See https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html
# Note: asymmetric keys DO NOT support automatic key rotation, ensure you set to false when creating one.
variable "default_enable_key_rotation" {
  description = "The default value to use for enable_key_rotation (whether or not to enable automatic annual rotation of the KMS key). Applies to all keys, unless overridden in the customer_master_keys map."
  type        = bool
  default     = true
}

variable "default_multi_region" {
  description = "The default value to use for multi_region (whether to enable multi-region replication for the KMS key). Applies to all keys, unless overridden in the customer_master_keys map."
  type        = bool
  default     = false
}

variable "default_customer_master_key_spec" {
  description = "The default value to use for spec (specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports). Applies to all keys, unless overridden in the customer_master_keys map. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1."
  type        = string
  default     = null
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE DEPENDENCIES
# Workaround Terraform limitation where there is no module depends_on.
# See https://github.com/hashicorp/terraform/issues/1178 for more details.
# This can be used to make sure the module resources are created after other bootstrapping resources have been created.
# For example, in AWS, when provisioning a wildcard ACM certificate for a public zone, you need to create several
# verification DNS records - but they must be created in the public zone itself. In this use case, you can pass the public
# zones as a dependency into this module:
# dependencies = flatten([values(aws_route53_zone.public_zones).*.name_servers])
# ---------------------------------------------------------------------------------------------------------------------

variable "dependencies" {
  description = "Create a dependency between the resources in this module to the interpolated values in this list (and thus the source resources). In other words, the resources in this module will now depend on the resources backing the values in this list such that those resources need to be created before the resources in this module, and the resources in this module need to be destroyed before the resources in the list."
  type        = list(string)
  default     = []
}
