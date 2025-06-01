# ---------------------------------------------------------------------
# Needed values for the project's various components
# ---------------------------------------------------------------------

region = "us-east-1"

vpc_name = "Sara_VPC"
vpc_cidr = "10.0.0.0/16"
vpc_azs  = ["us-east-1a", "us-east-1b"]

vpc_public_subnets_cidr   = ["10.0.0.0/24", "10.0.1.0/24"]
vpc_private_subnets_cidr  = ["10.0.10.0/24", "10.0.11.0/24"]
vpc_database_subnets_cidr = ["10.0.20.0/24", "10.0.21.0/24"]


instance_type          = "t2.micro"
instance_ami           = "ami-04a81a99f5ec58529"
key_name               = "instance_key_pair"
create_bastion         = true
bastion_instance_count = 1
create_web_instance    = false
web_instance_count     = 2


alb_name          = "ALB"
is_internal       = false
alb_type          = "application"
target_group_name = "TG"


asg_max_size          = 3
asg_min_size          = 1
asg_desired_cap       = 2
asg_health_check_type = "ELB"


db_username = "admin"
db_password = "#master_password"
db_name     = "MySQL_Database"
multi_az    = false


alarm_name  = "High_CPU_ASG"
threshold   = 20
description = "Alarm when CPU >= 20% for 2 minutes"


sns_topic_name         = "cpu-alerts"
sns_topic_display_name = "High CPU Usage Alerts"
email_endpoint         = "saramousa30@gmail.com"

