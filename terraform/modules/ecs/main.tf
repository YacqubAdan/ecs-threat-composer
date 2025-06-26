resource "aws_iam_role" "exec_role" {
  name = "ecs-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "exec_policy" {
  role       = aws_iam_role.exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "project_cluster" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "project_task" {
  family                   = var.ecs_task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.c_cpu
  memory                   = var.c_mem
  execution_role_arn       = aws_iam_role.exec_role.arn
  task_role_arn            = aws_iam_role.exec_role.arn


  container_definitions = jsonencode([{
    name      = var.c_name
    image     = var.c_img
    cpu       = 0
    essential = true

    portMappings = [{
      containerPort = var.c_port
      hostPort      = var.c_port
      protocol      = "tcp"
    }]
  }])

  tags = {
    Name = var.ecs_task_family
  }
}

resource "aws_ecs_service" "project_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.project_cluster.id
  task_definition = aws_ecs_task_definition.project_task.arn
  desired_count   = var.desired_num
  launch_type     = "FARGATE"

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.ecs_sg_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = var.c_name
    container_port   = var.c_port
  }

  depends_on = [var.http_listen_arn, var.https_listen_arn]
}






