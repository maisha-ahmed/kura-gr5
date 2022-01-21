resource "aws_acm_certificate" "ecs_domain_cert" {
  domain_name = "*.${var.ecs_domain_name}"
  validation_method = "DNS"

  tags {
      Name= "Fargate-Cluster-Cert"
  }
}

data "aws_route53_zone" "ecs_domain" {
  name = "${var.ecs_domain_name}"
  private_zone = false
}