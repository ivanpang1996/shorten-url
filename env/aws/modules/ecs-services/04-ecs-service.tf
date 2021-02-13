resource "aws_ecs_service" "url_shortener_service" {
  name            = var.service_name
  launch_type     = "FARGATE"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 3
  //  iam_role        = aws_iam_role.ecs_task_execution_role.arn
  depends_on      = [var.ecs_task_execution_role_policy]

  //  ordered_placement_strategy {
  //    type  = "binpack"
  //    field = "cpu"
  //  }

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

  //  placement_constraints {
  //    type       = "memberOf"
  //    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  //  }
}

resource "aws_security_group" "ecs_service" {
  name        = "${var.service_name}-service"
  description = "${var.service_name}-service"

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
