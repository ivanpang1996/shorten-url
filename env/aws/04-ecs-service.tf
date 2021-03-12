//module "url_shortener_service" {
//  source = "./modules/ecs-services"
//
//  cluster_id = aws_ecs_cluster.url_shortener.id
//  service_name = "url-shortener"
//  vpc_id = data.aws_vpc.default_vpc.id
//  subnet_ids = [data.aws_subnet.subnet_1a.id, data.aws_subnet.subnet_1b.id, data.aws_subnet.subnet_1c.id]
//  container_definitions = file("./task-definitions/url-shortener-app.json")
//  ecs_task_execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
//  ecs_task_execution_role_policy = aws_iam_role_policy.ecs_task_execution_policy
//}
//
//resource "aws_iam_role" "ecs_task_execution_role" {
//  name = "ecs-task-execution-role"
//
//  assume_role_policy = <<EOF
//{
// "Version": "2012-10-17",
// "Statement": [
//   {
//     "Action": "sts:AssumeRole",
//     "Principal": {
//       "Service": "ecs-tasks.amazonaws.com"
//     },
//     "Effect": "Allow",
//     "Sid": ""
//   }
// ]
//}
//EOF
//}
//
//resource "aws_iam_role_policy" "ecs_task_execution_policy" {
//
//  role = aws_iam_role.ecs_task_execution_role.id
//  policy = <<EOF
//{
//  "Version": "2012-10-17",
//  "Statement": [
//    {
//      "Effect": "Allow",
//      "Action": [
//        "ecr:GetAuthorizationToken",
//        "ecr:BatchCheckLayerAvailability",
//        "ecr:BatchGetImage",
//        "ecr:GetDownloadUrlForLayer"
//      ],
//      "Resource": "*"
//    },
//    {
//      "Effect": "Allow",
//      "Action": [
//        "ssm:GetParameters",
//        "secretsmanager:GetSecretValue"
//      ],
//      "Resource": "*"
//    }
//  ]
//}
//EOF
//}
