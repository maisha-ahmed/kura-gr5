data "aws_ecr_repository" "circleci_ecr" {
  name          = "circle-ci"
  most_recent   = true

}