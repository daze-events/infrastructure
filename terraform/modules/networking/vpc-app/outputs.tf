output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = var.vpc_name
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

// A VPC automatically comes with a default security group. If you don't
// specify a different security group when you launch an instance, AWS
// associates the default security group with your instance. You can't
// delete a default security group.
output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}

output "public_subnets" {
  description = "A map of all public subnets, with the subnet name as the key, and all `aws-subnet` properties as the value."
  value       = module.vpc.public_subnets
}

output "private_app_subnets" {
  description = "A map of all private-app subnets, with the subnet name as the key, and all `aws-subnet` properties as the value."
  value       = module.vpc.private_app_subnets
}

output "private_persistence_subnets" {
  description = "A map of all private-persistence subnets, with the subnet name as the key, and all `aws-subnet` properties as the value."
  value       = module.vpc.private_persistence_subnets
}

output "public_subnet_cidr_blocks" {
  value = module.vpc.public_subnet_cidr_blocks
}

output "private_app_subnet_cidr_blocks" {
  value = module.vpc.private_app_subnet_cidr_blocks
}

output "private_persistence_subnet_cidr_blocks" {
  value = module.vpc.private_persistence_subnet_cidr_blocks
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  value = module.vpc.private_app_subnet_ids
}

output "private_persistence_subnet_ids" {
  value = module.vpc.private_persistence_subnet_ids
}

output "public_subnet_arns" {
  value = module.vpc.public_subnet_arns
}

output "private_app_subnet_arns" {
  value = module.vpc.private_app_subnet_arns
}

output "private_persistence_subnet_arn" {
  value = module.vpc.private_persistence_subnet_arn
}

output "public_subnet_route_table_id" {
  value = module.vpc.public_subnet_route_table_id
}

// A VPC can be created with one Route Table for all public subnets; or one route table per public subnet. This output
// prints out all the created route tables for public subnets, no matter how many have been created.
// The output `public_subnet_route_table_id` prints out only the first one (if it exists).
output "public_subnet_route_table_ids" {
  value = module.vpc.public_subnet_route_table_ids
}

output "private_app_subnet_route_table_ids" {
  value = module.vpc.private_app_subnet_route_table_ids
}

// This output is identical to the private_persistence_subnet_route_table_ids output below. This one does not follow
// our naming conventions, but we keep it around to maintain backwards compatibility.
output "private_persistence_route_table_ids" {
  value = module.vpc.private_persistence_route_table_ids
}

output "private_persistence_subnet_route_table_ids" {
  value = module.vpc.private_persistence_subnet_route_table_ids
}

output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
}

output "nat_gateway_public_ips" {
  value = module.vpc.nat_gateway_public_ips
}

output "num_availability_zones" {
  value = module.vpc.num_availability_zones
}

output "availability_zones" {
  value = module.vpc.availability_zones
}

output "vpc_ready" {
  value = module.vpc.vpc_ready
}


output "s3_vpc_endpoint_id" {
  value = module.vpc.s3_vpc_endpoint_id
}

output "dynamodb_vpc_endpoint_id" {
  value = module.vpc.dynamodb_vpc_endpoint_id
}
