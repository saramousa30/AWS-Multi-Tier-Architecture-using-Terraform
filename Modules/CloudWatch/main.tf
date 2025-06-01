# ----------------------------------------------------------------------------- #
# --------------------------- CloudWatch Module ------------------------------- #
# ----------------------------------------------------------------------------- #

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name                = var.alarm_name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60 # Metric is evaluated every 60 seconds
  statistic                 = "Average"
  threshold                 = var.threshold # Triggers if average CPU ≥ threshold
  alarm_description         = var.description
  insufficient_data_actions = []
  alarm_actions             = [var.sns_topic_arn]

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
}
