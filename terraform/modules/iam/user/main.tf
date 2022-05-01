module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 4"

  name                          = var.name
  create_iam_access_key         = var.create_iam_access_key
  create_iam_user_login_profile = var.create_iam_user_login_profile
  create_user                   = var.create_user
  force_destroy                 = var.force_destroy
  password_length               = var.password_length
  password_reset_required       = var.password_reset_required
  path                          = var.path
  permissions_boundary          = var.permissions_boundary
  pgp_key                       = var.pgp_key
  ssh_key_encoding              = var.ssh_key_encoding
  ssh_public_key                = var.ssh_public_key
  tags                          = var.tags
  upload_iam_user_ssh_key       = var.upload_iam_user_ssh_key
}
