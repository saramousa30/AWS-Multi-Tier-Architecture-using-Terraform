# -------------------------------------------------------------- #
# -------------------- ASG Module Variables -------------------- #
# -------------------------------------------------------------- #

variable "image_ami" {
  type        = string
  default     = "ami-053b0d53c279acc90"
  description = "The AMI of the image"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The size of the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "A key pair to access the EC2"
}

variable "sg_id" {}

variable "asg_max_size" {
  description = "Maximum number of instances ASG can scale up to."
  default     = 3
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances that should always be running."
  default     = 1
}

variable "asg_desired_cap" {
  description = "Number of instances to start with initially."
  default     = 2
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "asg_health_check_type" {
  description = "Type of health check for ASG (EC2 or ELB)"
  type        = string
  default     = "ELB"
}

variable "tg_arn" {}

variable "db_user" {}
variable "db_pass" {}
variable "db_name" {}
variable "db_host" {}
