data "aws_ami" "this" {
  count  = var.ami_search ? 1 : 0
  owners = ["${var.ami_owner_account_id}"]
  filter {
    name   = "name"
    values = ["${var.ami_filter_name}"]
  }
}

module "single_server" {
  source = "git@github.com:gruntwork-io/terraform-aws-server.git//modules/single-server?ref=v0.14.2"

  name                                  = var.name
  ami                                   = var.ami_search ? data.aws_ami.this[0].id : var.ami
  instance_type                         = var.instance_type
  vpc_id                                = var.vpc_id
  subnet_id                             = var.subnet_id
  keypair_name                          = var.keypair_name
  user_data                             = var.user_data
  user_data_base64                      = var.user_data_base64
  additional_security_group_ids         = var.additional_security_group_ids
  allow_ssh_from_cidr_list              = var.allow_ssh_from_cidr_list
  allow_ssh_from_security_group_ids     = var.allow_ssh_from_security_group_ids
  allow_rdp_from_cidr_list              = var.allow_rdp_from_cidr_list
  allow_rdp_from_security_group_ids     = var.allow_rdp_from_security_group_ids
  allow_all_outbound_traffic            = var.allow_all_outbound_traffic
  dns_zone_id                           = var.dns_zone_id
  dns_name                              = var.dns_name
  dns_type                              = var.dns_type
  dns_ttl                               = var.dns_ttl
  dns_uses_private_ip                   = var.dns_uses_private_ip
  attach_eip                            = var.attach_eip
  tenancy                               = var.tenancy
  source_dest_check                     = var.source_dest_check
  tags                                  = var.tags
  ebs_optimized                         = var.ebs_optimized
  root_volume_type                      = var.root_volume_type
  root_volume_size                      = var.root_volume_size
  root_volume_delete_on_termination     = var.root_volume_delete_on_termination
  root_volume_tags                      = var.root_volume_tags
  security_group_name                   = var.security_group_name
  create_iam_role                       = var.create_iam_role
  iam_role_name                         = var.iam_role_name
  revoke_security_group_rules_on_delete = var.revoke_security_group_rules_on_delete
  monitoring                            = var.monitoring
  disable_api_termination               = var.disable_api_termination
  assume_role_principals                = var.assume_role_principals
  private_ip                            = var.private_ip
  secondary_private_ips                 = var.secondary_private_ips
  associate_public_ip_address           = var.associate_public_ip_address
  force_detach_policies                 = var.force_detach_policies
  security_group_tags                   = var.security_group_tags
  iam_role_tags                         = var.iam_role_tags
  eip_tags                              = var.eip_tags
  instance_tags                         = var.instance_tags
}
