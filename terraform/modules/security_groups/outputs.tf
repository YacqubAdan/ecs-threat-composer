output "ecs_sg_id" {
    description = "The id of container security group"
    value       = aws_security_group.ecs_sg.id
}

output "alb_sg_id" {
    description = "The id of load balancer security group"
    value       = aws_security_group.alb_sg.id
}