# ----------------------------------------------------------------------------- #
# ------------------------------- ASG Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

resource "aws_launch_template" "launch_template" {
  name          = "ASG_Launch_Template"
  image_id      = var.image_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data = base64encode(templatefile("${path.module}/config_file.sh.tpl", {
    DB_HOST = var.db_host,
    DB_USER = var.db_user,
    DB_PASS = var.db_pass,
    DB_NAME = var.db_name
  }))

  vpc_security_group_ids = [var.sg_id]
  tags = {
    Name = "ASG_Launch_Template"
  }
}

# Create Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "asg" {
  name                      = "ASG"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_cap
  health_check_grace_period = 300
  health_check_type         = var.asg_health_check_type
  vpc_zone_identifier       = var.private_subnet_ids
  target_group_arns         = [var.tg_arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }

  tag {
    key                 = "Name"
    value               = "ASG_Instance_Web"
    propagate_at_launch = true
  }
}
