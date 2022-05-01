# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These variables are expected to be passed in by the operator when calling this
# terraform module.
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_account_id" {
  description = "The AWS Account ID to deploy the resources into."
  type        = string
}

variable "aws_region" {
  description = "The AWS Region where this VPC will exist."
  type        = string
}

variable "vpc_peering_connection_id" {
  description = "The VPC Peering Connection ID to manage."
  type        = string
}

variable "dns_resolution" {
  description = "Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC."
  type        = bool
  default     = false
}

variable "link_to_local_classic" {
  description = "Allow a local linked EC2-Classic instance to communicate with instances in a peer VPC."
  type        = bool
  default     = false
}

variable "link_to_remote_classic" {
  description = "Allow a local VPC to communicate with a linked EC2-Classic instance in a peer VPC."
  type        = bool
  default     = false
}

variable "route_tables" {
  description = "List of route tables to add routes to."
  type        = list(string)
}

variable "requester_vpc_cidr" {
  description = "The VPC CIDR of the requester VPC."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to created resources."
  type        = map(string)
  default     = {}
}

variable "route_creation_timeout" {
  description = "The timeout for the creation of the Route Tables. It defines how long to wait for a route table to be created before considering the operation failed. Ref: https://www.terraform.io/language/resources/syntax#operation-timeouts"
  type        = string
  default     = "5m"
}

variable "route_update_timeout" {
  description = "The timeout for the update of the Route Tables. It defines how long to wait for a route table to be updated before considering the operation failed. Ref: https://www.terraform.io/language/resources/syntax#operation-timeouts"
  type        = string
  default     = "2m"
}

variable "route_deletion_timeout" {
  description = "The timeout for the deletion of the Route Tables. It defines how long to wait for a route table to be deleted before considering the operation failed. Ref: https://www.terraform.io/language/resources/syntax#operation-timeouts"
  type        = string
  default     = "5m"
}
