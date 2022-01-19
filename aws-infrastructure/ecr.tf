#Creating ECR Repository
resource "aws_ecr_repository" "ei_ecr" {
  name = "circleci"
}