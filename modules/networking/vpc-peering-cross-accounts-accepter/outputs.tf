output "vpc_peering_connection_id" {
  description = "Peering connection ID."
  value       = module.vpc_peering_cross_accounts_accepter.vpc_peering_connection_id
}

output "vpc_peering_accept_status" {
  description = "The status of the VPC Peering Connection request."
  value       = module.vpc_peering_cross_accounts_accepter.vpc_peering_accept_status
}
