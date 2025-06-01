# -------------------------------------------------------------- #
# -------------------- ALB Module Variables -------------------- #
# -------------------------------------------------------------- #

variable "alb_name" {
  type        = string
  description = "Name of the ALB"
}

variable "is_internal" {
  type        = bool
  description = "Determine whether the ALb is External or Internal"
}

variable "alb_type" {
  type        = string
  description = "The ALB type"
}

variable "sg_id" {
  type        = string
  description = "The ID of the security group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "alb_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the load balancer"
}


variable "target_group_name" {
  type        = string
  description = "The name of the target group"
}
