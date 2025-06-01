# ----------------------------------------------------------------------------- #
# ------------------------------- SNS Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

resource "aws_sns_topic" "asg_cpu" {
  name         = var.name
  display_name = var.display_name
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.asg_cpu.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
}
