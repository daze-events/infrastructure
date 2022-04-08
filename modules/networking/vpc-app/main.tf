terraform {
  # The configuration for this backend will be filled in by Terragrunt or via a backend.hcl file. See
  # https://www.terraform.io/docs/backends/config.html#partial-configuration
  backend "s3" {}

  # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
  # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
  required_version = "= 1.1.8"

  required_providers {
    aws = {
      version = "~> 4.8"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [var.aws_account_id]
}

module "vpc" {
  source = "git@github.com:gruntwork-io/module-vpc.git//modules/vpc-app?ref=v0.21.0"

  aws_region                                = var.aws_region
  vpc_name                                  = var.vpc_name
  cidr_block                                = var.cidr_block
  num_nat_gateways                          = var.num_nat_gateways
  num_availability_zones                    = var.num_availability_zones
  availability_zone_exclude_names           = var.availability_zone_exclude_names
  availability_zone_exclude_ids             = var.availability_zone_exclude_ids
  availability_zone_state                   = var.availability_zone_state
  availability_zone_ids                     = var.availability_zone_ids
  allow_private_persistence_internet_access = var.allow_private_persistence_internet_access
  use_custom_nat_eips                       = var.use_custom_nat_eips
  custom_nat_eips                           = var.custom_nat_eips
  public_subnet_cidr_blocks                 = var.public_subnet_cidr_blocks
  private_app_subnet_cidr_blocks            = var.private_app_subnet_cidr_blocks
  private_persistence_subnet_cidr_blocks    = var.private_persistence_subnet_cidr_blocks
  public_propagating_vgws                   = var.public_propagating_vgws
  private_propagating_vgws                  = var.private_propagating_vgws
  persistence_propagating_vgws              = var.persistence_propagating_vgws
  tenancy                                   = var.tenancy
  custom_tags                               = var.custom_tags
  vpc_custom_tags                           = var.vpc_custom_tags
  public_subnet_custom_tags                 = var.public_subnet_custom_tags
  private_app_subnet_custom_tags            = var.private_app_subnet_custom_tags
  private_persistence_subnet_custom_tags    = var.private_persistence_subnet_custom_tags
  nat_gateway_custom_tags                   = var.nat_gateway_custom_tags
  security_group_tags                       = var.security_group_tags
  subnet_spacing                            = var.subnet_spacing
  private_subnet_spacing                    = var.private_subnet_spacing
  persistence_subnet_spacing                = var.persistence_subnet_spacing
  public_subnet_bits                        = var.public_subnet_bits
  private_subnet_bits                       = var.private_subnet_bits
  persistence_subnet_bits                   = var.persistence_subnet_bits
  map_public_ip_on_launch                   = var.map_public_ip_on_launch
  create_vpc_endpoints                      = var.create_vpc_endpoints
  s3_endpoint_policy                        = var.s3_endpoint_policy
  dynamodb_endpoint_policy                  = var.dynamodb_endpoint_policy
  create_public_subnets                     = var.create_public_subnets
  create_igw                                = var.create_igw
  create_private_app_subnets                = var.create_private_app_subnets
  create_private_persistence_subnets        = var.create_private_persistence_subnets
  enable_default_security_group             = var.enable_default_security_group
  default_security_group_ingress_rules      = var.default_security_group_ingress_rules
  default_security_group_egress_rules       = var.default_security_group_egress_rules
  apply_default_nacl_rules                  = var.apply_default_nacl_rules
  associate_default_nacl_to_subnets         = var.associate_default_nacl_to_subnets
  default_nacl_ingress_rules                = var.default_nacl_ingress_rules
  default_nacl_egress_rules                 = var.default_nacl_egress_rules
  one_route_table_public_subnets            = var.one_route_table_public_subnets
  route_table_creation_timeout              = var.route_table_creation_timeout
  route_table_update_timeout                = var.route_table_update_timeout
  route_table_deletion_timeout              = var.route_table_deletion_timeout
}

module "vpc_network_acls" {
  source = "git@github.com:gruntwork-io/module-vpc.git//modules/vpc-app-network-acls?ref=v0.21.0"

  vpc_id      = module.vpc.vpc_id
  vpc_name    = module.vpc.vpc_name
  vpc_ready   = module.vpc.vpc_ready
  num_subnets = module.vpc.num_availability_zones

  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  public_subnet_cidr_blocks  = module.vpc.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = module.vpc.private_subnet_cidr_blocks
}
