# -------------------------------------------------------------- #
# -------------------- EC2 Module Variables -------------------- #
# -------------------------------------------------------------- #


# --------------------------------------------------------------
# Variables for the instance itself
# --------------------------------------------------------------

variable "instance_type" {
  type        = string
  description = "The size of the EC2 instance"
}

variable "instance_ami" {
  type        = string
  description = "The AMI of the EC2 instance"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}
variable "private_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "key_name" {
  type        = string
  description = "A key pair to access the EC2"
}


# Bastion variables
variable "create_bastion" {
  description = "Whether to create bastion host"
  type        = bool
  default     = true
}

variable "bastion_instance_count" {
  description = "Number instances"
  type        = number
}


# Web variables
variable "create_web_instance" {
  description = "Whether to create private web instance"
  type        = bool
}

variable "web_instance_count" {
  description = "Number of web instances"
  type        = number
}

# --------------------------------------------------------------
# Variables for the security group
# --------------------------------------------------------------

variable "bastion_sg_id" {
  type        = string
  description = "The ID of the security group that will be attached to the bastion instances"
}

variable "web_sg_id" {
  type        = string
  description = "The ID of the security group that will be attached to the web instances"
}
