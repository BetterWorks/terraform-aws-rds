output "replica_instance_id" {
  value       = var.enabled && var.replica_count > 0 ? aws_db_instance.replica.*.id : []
  description = "ID of the replica instances"
}

output "replica_instance_address" {
  value       = var.enabled && var.replica_count > 0 ? aws_db_instance.replica.*.address : []
  description = "Addresses of the replica instances"
}

output "replica_instance_endpoint" {
  value       = var.enabled && var.replica_count > 0 ? aws_db_instance.replica.*.endpoint : []
  description = "DNS Endpoint of the replica instances"
}
