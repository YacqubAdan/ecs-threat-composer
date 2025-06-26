variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "subnet_ids" {
  description = "The IDs of the subnets"
  type        = list(string)
}

# ALB specific

variable "alb_name" {
  type        = string
  description = "The name of the ALB"
}

variable "target_group_name" {
  type        = string
  description = "Name of the target group"
}


variable "alb_sg_id" {
  type        = string
  description = "Security group ID attached to the ALB"
}

variable "target_port" {
  type        = number
  description = "Port for the target group"
}

variable "cert_arn" {
  type        = string
  description = "ARN of the SSL certificate"
}