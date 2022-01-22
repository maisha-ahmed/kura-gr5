output "app-url" {
  value = aws_alb.ei_alb.dns_name
}