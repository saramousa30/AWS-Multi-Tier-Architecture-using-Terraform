# --------------------------------------------------------------- #
# -------------- Main Cofiguration File Variables --------------- #
# --------------------------------------------------------------- #

#------------------------------------------------------------------
# Provider Variables
#------------------------------------------------------------------

variable "region" {
  description = "Region code"
  type        = string
  default     = "us-east-1"
}

#------------------------------------------------------------------
# VPC Module Variables
#------------------------------------------------------------------

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

#------------------------------------------------------------------
# EC2 Module Variables
#------------------------------------------------------------------
variable "instance_type" {
  type        = string
  description = "The size of the EC2 instance"
}

variable "instance_ami" {
  type        = string
  description = "The AMI of the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "A key pair to access the EC2"
}


variable "create_bastion" {
  description = "Whether to create bastion host"
  type        = bool
  default     = true
}

variable "bastion_instance_count" {
  description = "Number of bastion instances"
  type        = number
  default     = 1
}

variable "create_web_instance" {
  description = "Whether to create private web instance"
  type        = bool
}

variable "web_instance_count" {
  description = "Number of web instances"
  type        = number
}


#------------------------------------------------------------------
# ALB Module Variables
#------------------------------------------------------------------
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

variable "target_group_name" {
  type        = string
  description = "The name of the target group"
}

#------------------------------------------------------------------
# ASG Module Variables
#------------------------------------------------------------------
variable "asg_max_size" {
  description = "Maximum number of instances ASG can scale up to."
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances that should always be running."
}

variable "asg_desired_cap" {
  description = "Number of instances to start with initially."
}

variable "asg_health_check_type" {
  description = "Type of health check for ASG (EC2 or ELB)"
  type        = string
  default     = "ELB"
}

#------------------------------------------------------------------
# DB Module Variables
#------------------------------------------------------------------
variable "db_username" {}
variable "db_password" {}
variable "db_name" {}
variable "multi_az" {
  type = bool
}


#------------------------------------------------------------------
# CloudWatch Module Variables
#------------------------------------------------------------------
variable "alarm_name" {}
variable "threshold" {}
variable "description" {}

#------------------------------------------------------------------
# SNS Module Variables
#------------------------------------------------------------------
variable "sns_topic_name" {}
variable "sns_topic_display_name" {}
variable "email_endpoint" {}
