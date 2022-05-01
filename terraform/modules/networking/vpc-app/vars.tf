# ----------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These variables are expected to be passed in by the operator when calling this
# terraform module.
# ----------------------------------------------------------------------------------------------------------------------
variable "aws_account_id" {
  description = "The AWS Account ID to deploy the resources into."
  type        = string
}

variable "aws_region" {
  description = "The AWS Region where this VPC will exist."
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC. Examples include 'prod', 'dev', 'mgmt', etc."
  type        = string
}

variable "cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27. Examples include '10.100.0.0/16', '10.200.0.0/16', etc."
  type        = string
}

variable "num_nat_gateways" {
  description = "The number of NAT Gateways to launch for this VPC. For production VPCs, a NAT Gateway should be placed in each Availability Zone (so likely 3 total), whereas for non-prod VPCs, just one Availability Zone (and hence 1 NAT Gateway) will suffice."
  type        = number
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters are useful for additional customization of the VPC. Otherwise, they default to sane values.
# ----------------------------------------------------------------------------------------------------------------------

variable "num_availability_zones" {
  description = "How many AWS Availability Zones (AZs) to use. One subnet of each type (public, private app, private persistence) will be created in each AZ. All AZs will be used if you provide a value that is more than the number of AZs in a region. A value of null means all AZs should be used. For example, if you specify 3 in a region with 5 AZs, subnets will be created in just 3 AZs instead of all 5. On the other hand, if you specify 6 in the same region, all 5 AZs will be used with no duplicates (same as setting this to 5)."
  type        = number
  default     = null
}

variable "availability_zone_exclude_names" {
  description = "List of excluded Availability Zone names."
  type        = list(string)
  default     = []
}

variable "availability_zone_exclude_ids" {
  description = "List of excluded Availability Zone IDs."
  type        = list(string)
  default     = []
}

variable "availability_zone_state" {
  description = "Allows to filter list of Availability Zones based on their current state. Can be either \"available\", \"information\", \"impaired\" or \"unavailable\". By default the list includes a complete set of Availability Zones to which the underlying AWS account has access, regardless of their state."
  type        = string
  default     = null
}

variable "availability_zone_ids" {
  description = "List of specific Availability Zone IDs to use. If null (default), all availability zones in the configured AWS region will be used."
  type        = list(string)
  default     = null
  validation {
    # We have to use a conditional here because binary operators are not short circuited in terraform. This is the
    # equivalent of (var.availability_zone_ids == null || length(var.availablity_zone_ids) > 0)
    condition = (
      var.availability_zone_ids == null
      ? true
      : length(var.availability_zone_ids) > 0
    )
    error_message = "The variable availability_zone_ids must be null or a list containing at least one Availability Zone."
  }
}

variable "allow_private_persistence_internet_access" {
  description = "Should the private persistence subnet be allowed outbound access to the internet?"
  type        = bool
  default     = false
}

variable "use_custom_nat_eips" {
  description = "Set to true to use existing EIPs, passed in via var.custom_nat_eips, for the NAT gateway(s), instead of creating new ones."
  type        = bool
  default     = false
}

variable "custom_nat_eips" {
  description = "The list of EIPs (allocation ids) to use for the NAT gateways. Their number has to match the one given in 'num_nat_gateways'. Must be set if var.use_custom_nat_eips us true."
  type        = list(string)
  default     = []
}

variable "public_subnet_cidr_blocks" {
  description = "A map listing the specific CIDR blocks desired for each public subnet. The key must be in the form AZ-0, AZ-1, ... AZ-n where n is the number of Availability Zones. If left blank, we will compute a reasonable CIDR block for each subnet."
  type        = map(string)
  default     = {}
  # Example:
  # default = {
  #    AZ-0 = "10.226.20.0/24"
  #    AZ-1 = "10.226.21.0/24"
  #    AZ-2 = "10.226.22.0/24"
  # }
}

variable "private_app_subnet_cidr_blocks" {
  description = "A map listing the specific CIDR blocks desired for each private-app subnet. The key must be in the form AZ-0, AZ-1, ... AZ-n where n is the number of Availability Zones. If left blank, we will compute a reasonable CIDR block for each subnet."
  type        = map(string)
  default     = {}
  # Example:
  # default = {
  #    AZ-0 = "10.226.30.0/24"
  #    AZ-1 = "10.226.31.0/24"
  #    AZ-2 = "10.226.32.0/24"
  # }
}

variable "private_persistence_subnet_cidr_blocks" {
  description = "A map listing the specific CIDR blocks desired for each private-persistence subnet. The key must be in the form AZ-0, AZ-1, ... AZ-n where n is the number of Availability Zones. If left blank, we will compute a reasonable CIDR block for each subnet."
  type        = map(string)
  default     = {}
  # Example:
  # default = {
  #    AZ-0 = "10.226.40.0/24"
  #    AZ-1 = "10.226.41.0/24"
  #    AZ-2 = "10.226.42.0/24"
  # }
}

variable "public_propagating_vgws" {
  description = "A list of Virtual Private Gateways that will propagate routes to public subnets. All routes from VPN connections that use Virtual Private Gateways listed here will appear in route tables of public subnets. If left empty, no routes will be propagated."
  type        = list(string)
  default     = []
  # Example:
  #  default = ["vgw-07bf8d1a"]
}

variable "private_propagating_vgws" {
  description = "A list of Virtual Private Gateways that will propagate routes to private subnets. All routes from VPN connections that use Virtual Private Gateways listed here will appear in route tables of private subnets. If left empty, no routes will be propagated."
  type        = list(string)
  default     = []
  # Example:
  #  default = ["vgw-07bf8d1a"]
}

variable "persistence_propagating_vgws" {
  description = "A list of Virtual Private Gateways that will propagate routes to persistence subnets. All routes from VPN connections that use Virtual Private Gateways listed here will appear in route tables of persistence subnets. If left empty, no routes will be propagated."
  type        = list(string)
  default     = []
}

variable "tenancy" {
  description = "The allowed tenancy of instances launched into the selected VPC. Must be one of: default, dedicated, or host."
  type        = string
  default     = "default"
}

variable "custom_tags" {
  description = "A map of tags to apply to the VPC, Subnets, Route Tables, Internet Gateway, default security group, and default NACLs. The key is the tag name and the value is the tag value. Note that the tag 'Name' is automatically added by this module but may be optionally overwritten by this variable."
  type        = map(string)
  default     = {}
}

variable "vpc_custom_tags" {
  description = "A map of tags to apply just to the VPC itself, but not any of the other resources. The key is the tag name and the value is the tag value. Note that tags defined here will override tags defined as custom_tags in case of conflict."
  type        = map(string)
  default     = {}
}

variable "public_subnet_custom_tags" {
  description = "A map of tags to apply to the public Subnet, on top of the custom_tags. The key is the tag name and the value is the tag value. Note that tags defined here will override tags defined as custom_tags in case of conflict."
  type        = map(string)
  default     = {}
}

variable "private_app_subnet_custom_tags" {
  description = "A map of tags to apply to the private-app Subnet, on top of the custom_tags. The key is the tag name and the value is the tag value. Note that tags defined here will override tags defined as custom_tags in case of conflict."
  type        = map(string)
  default     = {}
}

variable "private_persistence_subnet_custom_tags" {
  description = "A map of tags to apply to the private-persistence Subnet, on top of the custom_tags. The key is the tag name and the value is the tag value. Note that tags defined here will override tags defined as custom_tags in case of conflict."
  type        = map(string)
  default     = {}
}

variable "nat_gateway_custom_tags" {
  description = "A map of tags to apply to the NAT gateways, on top of the custom_tags. The key is the tag name and the value is the tag value. Note that tags defined here will override tags defined as custom_tags in case of conflict."
  type        = map(string)
  default     = {}
}

variable "security_group_tags" {
  description = "A map of tags to apply to the default Security Group, on top of the custom_tags. The key is the tag name and the value is the tag value. Note that tags defined here will override tags defined as custom_tags in case of conflict."
  type        = map(string)
  default     = {}
}

variable "subnet_spacing" {
  description = "The amount of spacing between the different subnet types"
  type        = number
  default     = 10
}

variable "private_subnet_spacing" {
  description = "The amount of spacing between private app subnets."
  type        = number
  default     = null
}

variable "persistence_subnet_spacing" {
  description = "The amount of spacing between the private persistence subnets. Default: 2 times the value of private_subnet_spacing."
  type        = number
  default     = null
}

variable "public_subnet_bits" {
  description = "Takes the CIDR prefix and adds these many bits to it for calculating subnet ranges.  MAKE SURE if you change this you also change the CIDR spacing or you may hit errors.  See cidrsubnet interpolation in terraform config for more information."
  type        = number
  default     = 5
}

variable "private_subnet_bits" {
  description = "Takes the CIDR prefix and adds these many bits to it for calculating subnet ranges.  MAKE SURE if you change this you also change the CIDR spacing or you may hit errors.  See cidrsubnet interpolation in terraform config for more information."
  type        = number
  default     = 5
}

variable "persistence_subnet_bits" {
  description = "Takes the CIDR prefix and adds these many bits to it for calculating subnet ranges.  MAKE SURE if you change this you also change the CIDR spacing or you may hit errors.  See cidrsubnet interpolation in terraform config for more information."
  type        = number
  default     = 5
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the public subnet should be assigned a public IP address (versus a private IP address)"
  type        = bool
  default     = false
}

variable "create_vpc_endpoints" {
  description = "Create VPC endpoints for S3 and DynamoDB."
  type        = bool
  default     = true
}

variable "s3_endpoint_policy" {
  description = "IAM policy to restrict what resources can call this endpoint. For example, you can add an IAM policy that allows EC2 instances to talk to this endpoint but no other types of resources. If not specified, all resources will be allowed to call this endpoint."
  type        = string
  default     = null
}

variable "dynamodb_endpoint_policy" {
  description = "IAM policy to restrict what resources can call this endpoint. For example, you can add an IAM policy that allows EC2 instances to talk to this endpoint but no other types of resources. If not specified, all resources will be allowed to call this endpoint."
  type        = string
  default     = null
}

variable "create_public_subnets" {
  description = "If set to false, this module will NOT create the public subnet tier. This is useful for VPCs that only need private subnets. Note that setting this to false also means the module will NOT create an Internet Gateway or the NAT gateways, so if you want any public Internet access in the VPC (even outbound access—e.g., to run apt get), you'll need to provide it yourself via some other mechanism (e.g., via VPC peering, a Transit Gateway, Direct Connect, etc)."
  type        = bool
  default     = true
}

variable "create_igw" {
  description = "If the VPC will create an Internet Gateway. There are use cases when the VPC is desired to not be routable from the internet, and hence, they should not have an Internet Gateway. For example, when it is desired that public subnets exist but they are not directly public facing, since they can be routed from other VPC hosting the IGW."
  type        = bool
  default     = true
}

variable "create_private_app_subnets" {
  description = "If set to false, this module will NOT create the private app subnet tier."
  type        = bool
  default     = true
}

variable "create_private_persistence_subnets" {
  description = "If set to false, this module will NOT create the private persistence subnet tier."
  type        = bool
  default     = true
}

variable "enable_default_security_group" {
  description = "If set to false, the default security groups will NOT be created. This variable is a workaround to a terraform limitation where overriding var.default_security_group_ingress_rules = {} and var.default_security_group_egress_rules = {} does not remove the rules. More information at: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group#removing-aws_default_security_group-from-your-configuration"
  type        = bool
  default     = true
}

variable "default_security_group_ingress_rules" {
  description = "The ingress rules to apply to the default security group in the VPC. This is the security group that is used by any resource that doesn't have its own security group attached. The value for this variable must be a map where the keys are a unique name for each rule and the values are objects with the same fields as the ingress block in the aws_default_security_group resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group#ingress-block."
  # Ideally, we'd have a more specific type here, but neither the 'map' nor 'object' type has support for optional
  # fields, and we need optional fields when defining security group rules.
  type = any
  default = {
    # The default AWS configures:
    # https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html#DefaultSecurityGroup
    AllowAllFromSelf = {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      self      = true
    }
  }
}

variable "default_security_group_egress_rules" {
  description = "The egress rules to apply to the default security group in the VPC. This is the security group that is used by any resource that doesn't have its own security group attached. The value for this variable must be a map where the keys are a unique name for each rule and the values are objects with the same fields as the egress block in the aws_default_security_group resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group#egress-block."
  # Ideally, we'd have a more specific type here, but neither the 'map' nor 'object' type has support for optional
  # fields, and we need optional fields when defining security group rules.
  type = any
  default = {
    # The default AWS configures:
    # https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html#DefaultSecurityGroup
    AllowAllOutbound = {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

variable "apply_default_nacl_rules" {
  description = "If true, will apply the default NACL rules in var.default_nacl_ingress_rules and var.default_nacl_egress_rules on the default NACL of the VPC. Note that every VPC must have a default NACL - when this is false, the original default NACL rules managed by AWS will be used."
  type        = bool
  default     = false
}

variable "associate_default_nacl_to_subnets" {
  description = "If true, will associate the default NACL to the public, private, and persistence subnets created by this module. Only used if var.apply_default_nacl_rules is true. Note that this does not guarantee that the subnets are associated with the default NACL. Subnets can only be associated with a single NACL. The default NACL association will be dropped if the subnets are associated with a custom NACL later."
  type        = bool
  default     = true
}

variable "default_nacl_ingress_rules" {
  description = "The ingress rules to apply to the default NACL in the VPC. This is the NACL that is used by any subnet that doesn't have its own NACL attached. The value for this variable must be a map where the keys are a unique name for each rule and the values are objects with the same fields as the ingress block in the aws_default_network_acl resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl."
  # Ideally, we'd have a more specific type here, but neither the 'map' nor 'object' type has support for optional
  # fields, and we need optional fields when defining security group rules.
  type = any
  default = {
    # The default AWS configures:
    # https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#default-network-acl
    AllowAll = {
      from_port  = 0
      to_port    = 0
      action     = "allow"
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
      rule_no    = 100
    }
  }
}

variable "default_nacl_egress_rules" {
  description = "The egress rules to apply to the default NACL in the VPC. This is the security group that is used by any subnet that doesn't have its own NACL attached. The value for this variable must be a map where the keys are a unique name for each rule and the values are objects with the same fields as the egress block in the aws_default_network_acl resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl."
  # Ideally, we'd have a more specific type here, but neither the 'map' nor 'object' type has support for optional
  # fields, and we need optional fields when defining security group rules.
  type = any
  default = {
    # The default AWS configures:
    # https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html#default-network-acl
    AllowAll = {
      from_port  = 0
      to_port    = 0
      action     = "allow"
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
      rule_no    = 100
    }
  }
}

variable "one_route_table_public_subnets" {
  description = "If set to true, create one route table shared amongst all the public subnets; if set to false, create a separate route table per public subnet. Historically, we created one route table for all the public subnets, as they all routed through the Internet Gateway anyway, but in certain use cases (e.g., for use with Network Firewall), you may want to have separate route tables for each public subnet."
  type        = bool
  default     = true
}

variable "route_table_creation_timeout" {
  description = "The timeout for the creation of the Route Tables. It defines how long to wait for a route table to be created before considering the operation failed. Ref: https://www.terraform.io/language/resources/syntax#operation-timeouts"
  type        = string
  default     = "5m"
}

variable "route_table_update_timeout" {
  description = "The timeout for the update of the Route Tables. It defines how long to wait for a route table to be updated before considering the operation failed. Ref: https://www.terraform.io/language/resources/syntax#operation-timeouts"
  type        = string
  default     = "2m"
}

variable "route_table_deletion_timeout" {
  description = "The timeout for the deletion of the Route Tables. It defines how long to wait for a route table to be deleted before considering the operation failed. Ref: https://www.terraform.io/language/resources/syntax#operation-timeouts"
  type        = string
  default     = "5m"
}
