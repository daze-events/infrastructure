module "iam_assumable_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"
  version = "~> 4"

  admin_role_name                         = var.admin_role_name
  admin_role_path                         = var.admin_role_path
  admin_role_permissions_boundary_arn     = var.admin_role_permissions_boundary_arn
  admin_role_policy_arns                  = var.admin_role_policy_arns
  admin_role_requires_mfa                 = var.admin_role_requires_mfa
  admin_role_tags                         = var.admin_role_tags
  create_admin_role                       = var.create_admin_role
  create_poweruser_role                   = var.create_poweruser_role
  create_readonly_role                    = var.create_readonly_role
  force_detach_policies                   = var.force_detach_policies
  max_session_duration                    = var.max_session_duration
  mfa_age                                 = var.mfa_age
  poweruser_role_name                     = var.poweruser_role_name
  poweruser_role_path                     = var.poweruser_role_path
  poweruser_role_permissions_boundary_arn = var.poweruser_role_permissions_boundary_arn
  poweruser_role_policy_arns              = var.poweruser_role_policy_arns
  poweruser_role_requires_mfa             = var.poweruser_role_requires_mfa
  poweruser_role_tags                     = var.poweruser_role_tags
  readonly_role_name                      = var.readonly_role_name
  readonly_role_path                      = var.readonly_role_path
  readonly_role_permissions_boundary_arn  = var.readonly_role_permissions_boundary_arn
  readonly_role_policy_arns               = var.readonly_role_policy_arns
  readonly_role_requires_mfa              = var.readonly_role_requires_mfa
  readonly_role_tags                      = var.readonly_role_tags
  trusted_role_arns                       = var.trusted_role_arns
  trusted_role_services                   = var.trusted_role_services

}
