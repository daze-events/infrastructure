# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be passed in by the templates using this module.
# ----------------------------------------------------------------------------------------------------------------------
variable "aws_account_id" {
  description = "The AWS Account ID to deploy the resources into."
  type        = string
}

variable "aws_region" {
  description = "The AWS Region where this VPC will exist."
  type        = string
}

variable "name" {
  description = "The name of the server. This will be used to namespace all resources created by this module."
  type        = string
}

variable "ami" {
  description = "The ID of the AMI to run for this server."
  type        = string
  default     = ""
}

variable "ami_search" {
  description = ""
  type        = bool
  default     = false
}

variable "ami_owner_account_id" {
  description = <<EOF
  "
  The owner of the AMI to search for.
  "
  EOF
  type        = string
  default     = ""
}

variable "ami_filter_name" {
  description = <<EOF
  "
  A regex string to search the AMI with a corresponding name.
  "
  EOF
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of EC2 instance to run (e.g. t2.micro)"
  type        = string
}

variable "vpc_id" {
  description = "The id of the VPC where this server should be deployed."
  type        = string
}

variable "subnet_id" {
  description = "The id of the subnet where this server should be deployed."
  type        = string
}

variable "keypair_name" {
  description = "The name of a Key Pair that can be used to SSH to this instance. Leave blank if you don't want to enable Key Pair auth."
  type        = string
  default     = ""
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables may be optionally passed in by the templates using this module to overwite the defaults.
# ----------------------------------------------------------------------------------------------------------------------

variable "user_data" {
  description = "The User Data script to run on this instance when it is booting. If you need to pass gzipped, base64-encoded data (e.g., for a cloud-init script), use var.user_data_base64 instead."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "The base64-encoded User Data script to run on the server when it is booting. This can be used to pass binary User Data, such as a gzipped cloud-init script. If you wish to pass in plain text (e.g., typical Bash script) for User Data, use var.user_data instead."
  type        = string
  default     = null
}

variable "additional_security_group_ids" {
  description = "A list of optional additional security group ids to assign to the server."
  type        = list(string)
  default     = []
}

variable "allow_ssh_from_cidr_list" {
  description = "A list of IP address ranges in CIDR format from which SSH access will be permitted. Attempts to access the server from all other IP addresses will be blocked."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allow_ssh_from_security_group_ids" {
  description = "The IDs of security groups from which SSH connections will be allowed."
  type        = list(string)
  default     = []
}

variable "allow_rdp_from_cidr_list" {
  description = "A list of IP address ranges in CIDR format from which rdp access will be permitted. Attempts to access the bastion host from all other IP addresses will be blocked."
  type        = list(string)
  default     = []
}

variable "allow_rdp_from_security_group_ids" {
  description = "The IDs of security groups from which rdp connections will be allowed."
  type        = list(string)
  default     = []
}

variable "allow_all_outbound_traffic" {
  description = "A boolean that specifies whether or not to add a security group rule that allows all outbound traffic from this server."
  type        = bool
  default     = true
}

variable "dns_zone_id" {
  description = "The id of a route53 hosted zone. Leave blank if you don't want a DNS entry for this server. If you specify this variable, you must also specify var.dns_name."
  type        = string
  default     = ""
}

variable "dns_name" {
  description = "The DNS name to add for this server in var.dns_zone_id. Only used if var.dns_zone_id is set. For example, if var.dns_zone_id points to the hosted zone for example.com and you set dns_name to foo, this server will have the domain foo.example.com."
  type        = string
  default     = ""
}

variable "dns_type" {
  description = "The DNS record type when adding a DNS record for this server. Only used if var.dns_zone_id is set."
  type        = string
  default     = "A"
}

variable "dns_ttl" {
  description = "The TTL, in seconds, of the DNS record for this server.  Only used if var.dns_zone_id is set."
  type        = number
  default     = 300
}

variable "dns_uses_private_ip" {
  description = "If set to true, point the Route 53 DNS record at the private IP of the EIP rather than the public IP."
  type        = bool
  default     = false
}

variable "attach_eip" {
  description = "Determines if an Elastic IP (EIP) will be created for this instance. Must be set to a boolean (not a string!) true or false value."
  type        = bool
  default     = true
}

variable "tenancy" {
  description = "The tenancy of this server. Must be one of: default, dedicated, or host."
  type        = string
  default     = "default"
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Must be set to a boolean (not a string!) true or false value."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A set of tags for the EC2 Instance. These are common tags and will be used for Instance, IAM Role, EIP and Security Group. Note that other AWS resources created by this module such as an Elastic IP Address and Route53 Record do not support tags."
  type        = map(string)
  default     = {}
}

variable "ebs_optimized" {
  description = "If true, the launced EC2 Instance will be EBS-optimized."
  type        = bool
  default     = false
}

variable "root_volume_type" {
  description = "The root volume type. Must be one of: standard, gp2, io1."
  type        = string
  default     = "standard"
}

variable "root_volume_size" {
  description = "The size of the root volume, in gigabytes."
  type        = number
  default     = 8
}

variable "root_volume_delete_on_termination" {
  description = "If set to true, the root volume will be deleted when the Instance is terminated."
  type        = bool
  default     = true
}

variable "root_volume_tags" {
  description = "Tags to set on the root volume."
  type        = map(string)
  default     = {}
}

variable "security_group_name" {
  description = "The name for the bastion host's security group. If set to an empty string, will use var.name."
  type        = string
  default     = ""
}

variable "create_iam_role" {
  description = "When true, this module will create a new IAM role to bind to the EC2 instance. Set to false if you wish to use a preexisting IAM role."
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "The name for the bastion host's IAM role and instance profile. If set to an empty string, will use var.name. Required when create_iam_role is false."
  type        = string
  default     = ""
}

variable "revoke_security_group_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first."
  type        = bool
  default     = false
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
  type        = bool
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection."
  type        = bool
  default     = false
}

variable "assume_role_principals" {
  description = "A list of AWS service principals that can assume the instance IAM role. If deploying in AWS China, set this to [ec2.amazonaws.com.cn]."
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Whether or not to associate a public IP address to the instance. When null, defaults to the subnet setting (e.g., if public subnet defaults to associating a public IP, associate one - otherwise, does not associate a public IP)."
  type        = bool
  default     = null
}

variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it. If policies are attached to the role via the aws_iam_policy_attachment resource and you are modifying the role name or path, the force_detach_policies argument must be set to true and applied before attempting the operation otherwise you will encounter a DeleteConflict error. The aws_iam_role_policy_attachment resource (recommended) does not have this requirement."
  type        = string
  default     = false
}

variable "security_group_tags" {
  description = "A set of tags to set for the Security Group. This is optional and if not provided the tags from variable tags will be used"
  type        = map(string)
  default     = {}
}

variable "iam_role_tags" {
  description = "A set of tags to set for instance iam role. This is optional and if not provided the tags from variable tags will be used"
  type        = map(string)
  default     = {}
}

variable "eip_tags" {
  description = "A set of tags to set for the EIP for EC2 Instance. This is optional and if not provided the tags from variable tags will be used"
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "A set of tags for EC2 Instance. This is optional and if not provided the tags from variable tags will be used"
  type        = map(string)
  default     = {}
}

variable "additional_iam_policies" {
  description = "additional iam policies to attach to the role"
  type        = list(string)
  default     = []
}
