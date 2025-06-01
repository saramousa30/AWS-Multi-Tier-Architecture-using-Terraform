# ----------------------------------------------------------------------------- #
# ------------------------------- ALB Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

# Create Load Balancer (ALB)
resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = var.is_internal
  load_balancer_type         = var.alb_type
  security_groups            = [var.sg_id]
  subnets                    = var.alb_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name  = "ALB"
    Owner = "Sara Mousa"
  }

}

# Create Target Group
resource "aws_lb_target_group" "alb_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
  }

  tags = {
    Name  = "ALB_TG"
    Owner = "Sara Mousa"
  }
}

# Create Listener for ALB
resource "aws_lb_listener" "alp_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

