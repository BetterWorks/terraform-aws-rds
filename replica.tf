# module "replica_label" {
#   source                 = "git::https://github.com/betterworks/terraform-null-label.git?ref=tags/1.0.0-terraform-1"
#   namespace              = var.namespace
#   name                   = var.name
#   replica_count          = rds_replica_count
#   replica_instance_class = rds_replica_instance_class
#   stage                  = var.stage
#   attributes             = ["db", "master", "replica"]
#   enabled                = var.rds_replica_enabled ? "true" : "false"
# }
resource "aws_db_instance" "replica" {
  count             = var.enabled == "true" ? var.replica_count : 0
  identifier        = "${module.label.id}-replica-${count.index}"
  name              = null
  username          = null
  password          = null
  port              = var.database_port
  engine            = null
  engine_version    = null
  instance_class    = var.replica_instance_class
  allocated_storage = null
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_arn
  vpc_security_group_ids = compact(
    concat(
      [join("", aws_security_group.default.*.id)],
      var.associate_security_group_ids,
    ),
  )
  db_subnet_group_name            = null
  parameter_group_name            = length(var.parameter_group_name) > 0 ? var.parameter_group_name : aws_db_parameter_group.replica.count > 0 ? join("", aws_db_parameter_group.replica.*.name) : join("", aws_db_parameter_group.default.*.name)
  option_group_name               = length(var.option_group_name) > 0 ? var.option_group_name : join("", aws_db_option_group.default.*.name)
  license_model                   = var.license_model
  multi_az                        = var.multi_az
  storage_type                    = var.storage_type
  iops                            = var.iops
  publicly_accessible             = var.publicly_accessible
  replicate_source_db             = aws_db_instance.default[0].id
  snapshot_identifier             = var.snapshot_identifier
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = var.apply_immediately
  maintenance_window              = var.maintenance_window
  skip_final_snapshot             = var.skip_final_snapshot
  copy_tags_to_snapshot           = null
  backup_retention_period         = null
  backup_window                   = null
  tags                            = module.label.tags
  deletion_protection             = var.deletion_protection
  final_snapshot_identifier       = null
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = var.monitoring_interval == 0 ? null : var.monitoring_role_arn
  performance_insights_enabled    = var.performance_insights_enabled
  timeouts {
    create = "60m"
    update = "90m"
    delete = "2h"
  }
}

locals {
  db_replica_parameter = var.db_replica_parameter
}

resource "aws_db_parameter_group" "replica" {
  count  = length(var.parameter_group_name) == 0 && var.enabled == "true" && var.replica_count > 0 && local.db_replica_parameter != 0 ? 1 : 0
  name   = "${module.label.id}-replica"
  family = var.db_parameter_group
  tags   = module.label.tags
  lifecycle {
    create_before_destroy = true
  }
  dynamic "parameter" {
    for_each = local.db_replica_parameter
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}
