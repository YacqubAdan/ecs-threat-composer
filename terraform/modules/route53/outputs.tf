output "ssl_cert_arn" {
  description = "The arn of the ssl cert"
  value       = aws_acm_certificate.ssl_cert.arn
}

output "route53_zone_id" {
  description = "The id of the Route53 Zone"
  value       = data.aws_route53_zone.dns_zone.zone_id
}

output "root_domain" {
  description = "The root domain"
  value       = var.root_domain

}