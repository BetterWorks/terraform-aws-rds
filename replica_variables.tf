variable "replica_instance_class" {
  type        = string
  default = "db.t3.micro"
  description = "Class of RDS instance"
}

variable "replica_count" {
  type        = number
  description = "no of read replica's to stand up"
  default = 0
}

variable "db_replica_parameter" {
  type        = list(map(string))
  default     = []
  description = "A list of DB parameters to apply. Note that parameters may differ from a DB family to another"
}