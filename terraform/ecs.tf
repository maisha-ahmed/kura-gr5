#Creating ECS Cluster
resource "aws_ecs_cluster" "ei_cluster" {
  name = "${var.application_name}_cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  depends_on = [aws_ecr_repository.ei_ecr]
}