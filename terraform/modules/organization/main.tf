resource "aws_organizations_organization" "this" {
  feature_set                   = var.feature_set
  enabled_policy_types          = var.enabled_policy_types
  aws_service_access_principals = var.aws_service_access_principals
}
