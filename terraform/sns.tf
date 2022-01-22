resource "aws_sns_topic" "ei_sns" {
  name = "${var.application_name}_sns_topic"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.ei_sns.arn
  protocol  = "email"
  endpoint  = "ibrahima.diallo1289@gmail.com" 
}