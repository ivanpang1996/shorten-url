resource "aws_ecs_cluster" "url_shortener" {
  name = "url-shortener"
}

resource "aws_ecr_repository" "url_shortener" {
  name                 = "url_shortener"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy" "ecs_task_execution_policy" {

  role = aws_iam_role.ecs_task_execution_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "url-shortener-app"
  requires_compatibilities = ["FARGATE"]
  container_definitions = file("./task-definitions/url-shortener-app.json")

  cpu = 1024
  memory = 2048
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_subnet" "subnet_1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.16.0/20"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_1b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.0.0/20"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_1c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.31.32.0/20"
  map_public_ip_on_launch = true
}

resource "aws_lb_target_group" "url_shortener_group" {
  name        = "url-shortener-lb-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_lb" "alb" {
  name               = "url-shortener-lb"
  internal           = false
  load_balancer_type = "application"
//  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.subnet_1a.id ,aws_subnet.subnet_1b.id ,aws_subnet.subnet_1c.id]

  enable_deletion_protection = true

//  access_logs {
//    bucket  = aws_s3_bucket.lb_logs.bucket
//    prefix  = "test-lb"
//    enabled = true
//  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
//  ssl_policy        = "ELBSecurityPolicy-2016-08"
//  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.url_shortener_group.arn
  }
}

resource "aws_ecs_service" "url_shortener_service" {
  name            = "url-shortener"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.url_shortener.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 3
//  iam_role        = aws_iam_role.ecs_task_execution_role.arn
  depends_on      = [aws_iam_role_policy.ecs_task_execution_policy]

//  ordered_placement_strategy {
//    type  = "binpack"
//    field = "cpu"
//  }

  network_configuration {
    subnets = [aws_subnet.subnet_1a.id, aws_subnet.subnet_1b.id, aws_subnet.subnet_1c.id]
    assign_public_ip = true
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
