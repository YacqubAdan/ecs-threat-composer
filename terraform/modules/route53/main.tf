
data "aws_route53_zone" "dns_zone" {
  name = var.root_domain
}

resource "aws_acm_certificate" "ssl_cert" {
  domain_name               = var.root_domain                   
  subject_alternative_names = ["tc.${var.root_domain}"]           
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "dns_validation_root" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.ssl_cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.ssl_cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.ssl_cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.dns_zone.zone_id
  ttl             = var.dns_record_ttl
}


resource "aws_route53_record" "dns_validation_tc" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.ssl_cert.domain_validation_options)[1].resource_record_name
  records         = [tolist(aws_acm_certificate.ssl_cert.domain_validation_options)[1].resource_record_value]
  type            = tolist(aws_acm_certificate.ssl_cert.domain_validation_options)[1].resource_record_type
  zone_id         = data.aws_route53_zone.dns_zone.zone_id
  ttl             = var.dns_record_ttl
}


resource "aws_acm_certificate_validation" "ssl_validation" {
  certificate_arn         = aws_acm_certificate.ssl_cert.arn
  validation_record_fqdns = [
    aws_route53_record.dns_validation_root.fqdn,  
    aws_route53_record.dns_validation_tc.fqdn     
  ]
}


resource "aws_route53_record" "root_alias" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = var.root_domain                      
  type    = "A"

  alias {
    name                   = var.alb_dns            
    zone_id                = var.alb_zone_id        
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "tc_alias" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = "tc.${var.root_domain}"               
  type    = "A"

  alias {
    name                   = var.alb_dns            
    zone_id                = var.alb_zone_id        
    evaluate_target_health = true
  }
}
