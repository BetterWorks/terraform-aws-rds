output "instance_id" {
  value       = join("", aws_db_instance.default.*.id)
  description = "ID of the instance"
}

output "instance_identifier" {
  value       = join("", aws_db_instance.default.*.identifier)
  description = "ID of the instance"
}
output "instance_address" {
  value       = join("", aws_db_instance.default.*.address)
  description = "Address of the instance"
}

output "instance_endpoint" {
  value       = join("", aws_db_instance.default.*.endpoint)
  description = "DNS Endpoint of the instance"
}

output "subnet_group_id" {
  value       = join("", aws_db_subnet_group.default.*.id)
  description = "ID of the Subnet Group"
}

output "security_group_id" {
  value       = join("", aws_security_group.default.*.id)
  description = "ID of the Security Group"
}

output "parameter_group_id" {
  value       = join("", aws_db_parameter_group.default.*.id)
  description = "ID of the Parameter Group"
}

output "option_group_id" {
  value       = join("", aws_db_option_group.default.*.id)
  description = "ID of the Option Group"
}

output "hostname" {
  value       = module.dns_host_name.hostname
  description = "DNS host name of the instance"
}

output "master_storage_type" {
  value       = join("", aws_db_instance.default.*.storage_type)
  description = "Storage type of the master instance"
}
