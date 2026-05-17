resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = var.component_name
  type    = var.dns_type
  ttl     = var.ttl
  records = [var.private_ip]
}