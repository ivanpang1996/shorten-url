resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.service_name}-app"
  requires_compatibilities = ["FARGATE"]
  container_definitions = var.container_definitions

  cpu = 1024
  memory = 2048
  network_mode = "awsvpc"
  execution_role_arn = var.ecs_task_execution_role_arn

  lifecycle {
    ignore_changes = [container_definitions]
  }
}

