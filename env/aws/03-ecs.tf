resource "aws_ecs_cluster" "url_shortener" {
  name = var.project_name
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

resource "aws_ecr_repository" "url_shortener" {
  name                 = var.project_name
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
