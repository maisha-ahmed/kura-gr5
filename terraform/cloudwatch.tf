# ECS parameters
resource "aws_cloudwatch_metric_alarm" "ei_ecs_cpu_alarm" {
  alarm_name          = "EI ECS CPU Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization" #CPU units used by tasks 
  namespace           = "AWS/ECS"        #needed to select ecs fargate
  period              = "60"             #60 seconds
  statistic           = "Average"
  threshold           = "5"
  alarm_description   = "This metric monitors ECS CPU Utilization"
  alarm_actions       = [aws_sns_topic.ei_sns.arn]
  dimensions = {
    "ServiceName" = var.service_name
    "ClusterName" = var.cluster_name
  }
  depends_on = [aws_sns_topic.ei_sns]
}

resource "aws_cloudwatch_metric_alarm" "ei_ecs_memory_alarm" {
  alarm_name          = "EI ECS Memeory Utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization" #memory being used by tasks 
  namespace           = "AWS/ECS"           #needed to select ecs fargate
  period              = "60"                #60 seconds
  statistic           = "Average"
  threshold           = "5" #Percent
  alarm_description   = "This metric monitors ECS Memeory Utilization"
  alarm_actions       = [aws_sns_topic.ei_sns.arn]
  dimensions = {
    "ServiceName" = var.service_name
    "ClusterName" = var.cluster_name
  }
  depends_on = [aws_sns_topic.ei_sns]
}

# logs 
resource "aws_cloudwatch_log_group" "ei_log_group" {
  name = "ei-logs"

  tags = {
    Environment = "production"
    Application = "EI"
  }
}

