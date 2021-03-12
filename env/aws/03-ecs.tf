//resource "aws_ecs_cluster" "url_shortener" {
//  name = var.project_name
//}
//
//data "aws_vpc" "default_vpc" {
//  id = "vpc-1e2d8163"
//}
//
//data "aws_subnet" "subnet_1a" {
//  id = "subnet-d3108d8c"
//}
//
//data "aws_subnet" "subnet_1b" {
//  id = "subnet-2b78e84d"
//}
//
//data "aws_subnet" "subnet_1c" {
//  id = "subnet-c29907e3"
//}
//
//data "aws_security_group" "default" {
//  id = "sg-45612b4f"
//}
//
//resource "aws_security_group_rule" "db" {
//  type              = "ingress"
//  from_port         = 3306
//  to_port           = 3306
//  protocol          = "tcp"
//  cidr_blocks       = ["0.0.0.0/0"]
//  security_group_id = data.aws_security_group.default.id
//}
//
//resource "aws_security_group_rule" "redis" {
//  type              = "ingress"
//  from_port         = 6379
//  to_port           = 6379
//  protocol          = "tcp"
//  cidr_blocks       = ["0.0.0.0/0"]
//  security_group_id = data.aws_security_group.default.id
//}
//
//resource "aws_ecr_repository" "url_shortener" {
//  name                 = var.project_name
//  image_tag_mutability = "MUTABLE"
//
//  image_scanning_configuration {
//    scan_on_push = true
//  }
//}
