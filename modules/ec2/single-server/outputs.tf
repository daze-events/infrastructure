output "arn" {
  value = module.single_server.arn
}

output "id" {
  value = module.single_server.id
}

output "name" {
  value = module.single_server.name
}

output "public_ip" {
  value = module.single_server.public_ip
}

output "private_ip" {
  value = module.single_server.private_ip
}

output "secondary_private_ips" {
  value = module.single_server.secondary_private_ips
}

output "fqdn" {
  value = module.single_server.fqdn
}

output "security_group_id" {
  value = module.single_server.security_group_id
}

output "iam_role_id" {
  value = module.single_server.iam_role_id
}

output "iam_role_name" {
  value = module.single_server.iam_role_name
}

output "iam_role_arn" {
  value = module.single_server.iam_role_arn
}

output "instance_ip" {
  value = module.single_server.instance_ip
}

output "ami" {
  value = module.single_server.ami
}
