output "replica_instance_id" {
  value       = aws_db_instance.replica.*.id
  description = "ID of the replica instances"
}

output "replica_instance_address" {
  value       = aws_db_instance.replica.*.address
  description = "Addresses of the replica instances"
}

output "replica_instance_endpoint" {
  value       = aws_db_instance.replica.*.endpoint
  description = "DNS Endpoint of the replica instances"
}