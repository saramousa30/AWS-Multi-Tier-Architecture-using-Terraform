# --------------------------------------------------------------- #
# --------------------- VPC Module Variables -------------------- #
# --------------------------------------------------------------- #

variable "region" {}

# --------------------------------------------------------------
# Variables for the VPC
# --------------------------------------------------------------

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "demo-vpc"
}

variable "vpc_cidr" {
  description = "VPC CIDR range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "List of AZs"
  type        = list(string)
}

# --------------------------------------------------------------
# Variables for public subnets
# --------------------------------------------------------------

variable "vpc_public_subnets_cidr" {
  description = "List of public subnet CIDR ranges"
  type        = list(string)
}

variable "vpc_private_subnets_cidr" {
  description = "List of private subnet CIDR ranges"
  type        = list(string)
}

variable "vpc_database_subnets_cidr" {
  description = "List of database subnet CIDR ranges"
  type        = list(string)
}
