# -------------------------------------------------------------- #
# -------------------- DB Module Variables --------------------- #
# -------------------------------------------------------------- #

variable "database_subnet_ids" {
  description = "List of database subnet IDs"
  type        = list(string)
}

variable "db_user" {}
variable "db_pass" {}
variable "db_name" {}
variable "multi_az" {
  type = bool
}

variable "db_sg_id" {
  type        = string
  description = "The ID of the security group that will be attached to the database instances"
}
