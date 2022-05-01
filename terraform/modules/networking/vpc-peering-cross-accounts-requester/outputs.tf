output "vpc_peering_connection_id" {
  description = "Peering connection ID."
  value       = module.vpc_peering_cross_accounts_requester.vpc_peering_connection_id
}
