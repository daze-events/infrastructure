output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_name" {
  value = var.vpc_name
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

// A VPC automatically comes with a default security group. If you don't
// specify a different security group when you launch an instance, AWS
// associates the default security group with your instance. You can't
// delete a default security group.
output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}

output "public_subnets" {
  description = "A map of all public subnets, with the subnet name as the key, and all `aws-subnet` properties as the value."
  value = {
    for subnet in aws_subnet.public :
    subnet.id => subnet
  }
}

output "private_app_subnets" {
  description = "A map of all private-app subnets, with the subnet name as the key, and all `aws-subnet` properties as the value."
  value = {
    for subnet in aws_subnet.private-app :
    subnet.id => subnet
  }
}

output "private_persistence_subnets" {
  description = "A map of all private-persistence subnets, with the subnet name as the key, and all `aws-subnet` properties as the value."
  value = {
    for subnet in aws_subnet.private-persistence :
    subnet.id => subnet
  }
}

output "public_subnet_cidr_blocks" {
  value = aws_subnet.public[*].cidr_block
}

output "private_app_subnet_cidr_blocks" {
  value = aws_subnet.private-app[*].cidr_block
}

output "private_persistence_subnet_cidr_blocks" {
  value = aws_subnet.private-persistence[*].cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private-app[*].id
}

output "private_persistence_subnet_ids" {
  value = aws_subnet.private-persistence[*].id
}

output "public_subnet_arns" {
  value = aws_subnet.public[*].arn
}

output "private_app_subnet_arns" {
  value = aws_subnet.private-app[*].arn
}

output "private_persistence_subnet_arn" {
  value = aws_subnet.private-persistence[*].arn
}

output "public_subnet_route_table_id" {
  value = var.create_public_subnets ? aws_route_table.public[0].id : null
}

// A VPC can be created with one Route Table for all public subnets; or one route table per public subnet. This output
// prints out all the created route tables for public subnets, no matter how many have been created.
// The output `public_subnet_route_table_id` prints out only the first one (if it exists).
output "public_subnet_route_table_ids" {
  value = var.create_public_subnets ? aws_route_table.public[*].id : null
}

output "private_app_subnet_route_table_ids" {
  value = aws_route_table.private-app[*].id
}

// This output is identical to the private_persistence_subnet_route_table_ids output below. This one does not follow
// our naming conventions, but we keep it around to maintain backwards compatibility.
output "private_persistence_route_table_ids" {
  value = aws_route_table.private-persistence[*].id
}

output "private_persistence_subnet_route_table_ids" {
  value = aws_route_table.private-persistence[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat[*].id
}

output "nat_gateway_public_ips" {
  value = aws_eip.nat[*].public_ip
}

output "num_availability_zones" {
  value = local.num_availability_zones
}

output "availability_zones" {
  value = slice(data.aws_availability_zones.all.names, 0, local.num_availability_zones)
}

output "vpc_ready" {
  value = null_resource.vpc_ready.id
}


output "s3_vpc_endpoint_id" {
  value = var.create_vpc_endpoints ? aws_vpc_endpoint.s3[0].id : null
}

output "dynamodb_vpc_endpoint_id" {
  value = var.create_vpc_endpoints ? aws_vpc_endpoint.dynamodb[0].id : null
}
