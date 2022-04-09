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

variable "vpc_id" {
  description = "The VPC ID."
  type        = string
}

variable "route_tables" {
  description = "List of route tables to add routes to."
  type        = list(string)
}

variable "accepter_owner_id" {
  description = "The account ID of the accepter VPC."
  type        = string
}

variable "accepter_vpc_id" {
  description = "The ID of the accepter VPC."
  type        = string
}

variable "accepter_region" {
  description = "The region of the accepter VPC."
  type        = string
}

variable "accepter_vpc_cidr" {
  description = "The VPC CIDR of the accepter VPC."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "route_creation_timeout" {
  description = "How long to wait for a route to be created before considering the operation failed."
  type        = string
  default     = "2m"
}

variable "route_deletion_timeout" {
  description = "How long to wait for a route to be deleted before considering the operation failed."
  type        = string
  default     = "5m"
}

variable "allow_remote_vpc_dns_resolution" {
  description = "Allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC."
  type        = bool
  default     = false
}
