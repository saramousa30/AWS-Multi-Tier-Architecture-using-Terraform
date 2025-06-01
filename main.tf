
# VPC
module "VPC" {
  source                    = "./Modules/VPC"
  region                    = var.region
  vpc_name                  = var.vpc_name
  vpc_cidr                  = var.vpc_cidr
  vpc_azs                   = var.vpc_azs
  vpc_public_subnets_cidr   = var.vpc_public_subnets_cidr
  vpc_private_subnets_cidr  = var.vpc_private_subnets_cidr
  vpc_database_subnets_cidr = var.vpc_database_subnets_cidr
}

#Security Group 
module "Security_Group" {
  source = "./Modules/Security_Group"
  vpc_id = module.VPC.vpc_id
}


# instances (EC2)
module "instances" {
  source = "./Modules/EC2"

  # Basic configuration
  instance_type = var.instance_type
  instance_ami  = var.instance_ami
  key_name      = var.key_name

  # Bastion configuration
  create_bastion         = var.create_bastion
  bastion_instance_count = var.bastion_instance_count
  public_subnet_ids      = module.VPC.public_subnet_ids
  bastion_sg_id          = module.Security_Group.bastion_sg_id


  create_web_instance = var.create_web_instance
  web_instance_count  = var.web_instance_count
  private_subnet_ids  = module.VPC.private_subnet_ids
  web_sg_id           = module.Security_Group.web_sg_id

}

# ALB
module "ALB" {
  source            = "./Modules/ALB"
  alb_name          = var.alb_name
  is_internal       = var.is_internal
  alb_type          = var.alb_type
  sg_id             = module.Security_Group.alb_sg_id
  vpc_id            = module.VPC.vpc_id
  alb_subnet_ids    = module.VPC.public_subnet_ids
  target_group_name = var.target_group_name
}

#ASG
module "ASG" {
  source                = "./Modules/ASG"
  image_ami             = var.instance_ami
  instance_type         = var.instance_type
  key_name              = var.key_name
  sg_id                 = module.Security_Group.web_sg_id
  asg_max_size          = var.asg_max_size
  asg_min_size          = var.asg_min_size
  asg_desired_cap       = var.asg_desired_cap
  asg_health_check_type = var.asg_health_check_type
  private_subnet_ids    = module.VPC.private_subnet_ids
  tg_arn                = module.ALB.target_group_arn
  db_name               = var.db_name
  db_user               = var.db_username
  db_pass               = var.db_password
  db_host               = local.db_hostname
}

#DB
module "DB" {
  source              = "./Modules/DB"
  database_subnet_ids = module.VPC.database_subnet_ids
  db_user             = var.db_username
  db_pass             = var.db_password
  db_name             = var.db_name
  db_sg_id            = module.Security_Group.db_sg_id
  multi_az            = var.multi_az
}

locals {
  db_hostname = split(":", module.DB.db_endpoint)[0]
}
#Because rds_endpoint typically returns something like: <hostname>:3306

#SNS
module "SNS" {
  source         = "./Modules/SNS"
  name           = var.sns_topic_name
  display_name   = var.sns_topic_name
  email_endpoint = var.email_endpoint
}

#CloudWatch
module "CloudWatch" {
  source                 = "./Modules/CloudWatch"
  alarm_name             = var.alarm_name
  threshold              = var.threshold
  description            = var.description
  sns_topic_arn          = module.SNS.asg_cpu_topic_arn
  autoscaling_group_name = module.ASG.asg_name
}
