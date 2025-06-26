variable "vpc_id" {
  type        = string
  description = "The id of the VPC"
}

variable "ecs_sg_id" {
  type        = string
  description = "The id of container security group"
}

variable "alb_sg_id" {
  type        = string
  description = "The id of load balancer security group"
}

variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster"
}

variable "desired_num" {
  type        = number
  description = "The desired count of ECS tasks"
}

variable "service_name" {
  type        = string
  description = "The name of the ECS service"
}

variable "ecs_task_family" {
  type        = string
  description = "The name of the ECS task family"
}

variable "c_name" {
  type        = string
  description = "ECS container name"
}

variable "c_img" {
  type        = string
  description = "ECS container image"
}

variable "c_cpu" {
  type        = number
  description = "ECS container CPU"
}

variable "c_mem" {
  type        = number
  description = "ECS container memory"
}

variable "c_port" {
  type        = number
  description = "ECS container port"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for ECS service"
}

variable "tg_arn" {
  type        = string
  description = "The arn of target group"
}

variable "http_listen_arn" {
  type        = string
  description = "The arn of http listener"
}

variable "https_listen_arn" {
  type        = string
  description = "The arn of https listener"
}
