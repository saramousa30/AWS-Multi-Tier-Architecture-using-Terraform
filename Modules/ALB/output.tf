# -------------------------------------------------------------- #
# --------------------- ALB Module Outputs --------------------- #
# -------------------------------------------------------------- #

output "alb_dns" {
  description = "The DNS of the ALB."
  value       = aws_lb.alb.dns_name
}

output "target_group_arn" {
  description = "The arn of the target group."
  value       = aws_lb_target_group.alb_tg.arn
}
