resource "aws_ecs_service" "url_shortener_service" {
  name            = var.service_name
  launch_type     = "FARGATE"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 3
  depends_on      = [var.ecs_task_execution_role_policy]

  network_configuration {
    subnets = var.subnet_ids
    assign_public_ip = true
    security_groups = [aws_security_group.ecs_service.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.url_shortener_group.arn
    container_name   = "app"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_security_group" "ecs_service" {
  name        = "${var.service_name}-service"
  description = "${var.service_name}-service"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
