resource "aws_lb" "project_alb" {
    name               = var.alb_name
    internal           = false
    load_balancer_type = "application"
    security_groups = [var.alb_sg_id]
    subnets = var.subnet_ids
    enable_deletion_protection = false
}

resource "aws_lb_target_group" "project_tg" {
    name     = var.target_group_name
    vpc_id   = var.vpc_id
    port     = var.target_port
    protocol = "HTTP"
    target_type = "ip"
}

resource "aws_lb_listener" "lb_http" {
    load_balancer_arn = aws_lb.project_alb.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
        type             = "redirect"
        target_group_arn = aws_lb_target_group.project_tg.arn
        redirect {
            port = 443
            status_code = "HTTP_301"
            protocol    = "HTTPS"
        }
    }
}

resource "aws_lb_listener" "lb_https" {
    load_balancer_arn = aws_lb.project_alb.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = var.cert_arn
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.project_tg.arn
    }
}





