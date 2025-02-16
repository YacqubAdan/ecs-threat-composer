output "alb_arn" {
    value       = aws_lb.project_alb.arn
    description = "The arn of alb"
}

output "alb_dns" {
    value       = aws_lb.project_alb.dns_name
    description = "The dns of the alb"
}

output "alb_url" {
    value       = "https://${aws_lb.project_alb.dns_name}"
    description = "The url of the alb"
}

output "tg_arn" {
    value       = aws_lb_target_group.project_tg.arn
    description = "The arn of target group"
}

output "http_listen" {
    value       = aws_lb_listener.lb_http.id
    description = "The id of http listener"
}

output "https_listen" {
    value       = aws_lb_listener.lb_https.id
    description = "The id of https listener"
}

output "alb_zone_id" {
    value       = aws_lb.project_alb.zone_id
    description = "The zone id of alb"
}