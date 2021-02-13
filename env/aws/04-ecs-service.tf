module "url_shortener_service" {  //TODO: need refactor
  source = "./modules/ecs-services"

  cluster_id = aws_ecs_cluster.url_shortener.id
  service_name = "url-shortener"
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [aws_subnet.subnet_1a.id, aws_subnet.subnet_1b.id, aws_subnet.subnet_1c.id]
  container_definitions = file("./task-definitions/url-shortener-app.json")
  ecs_task_execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  ecs_task_execution_role_policy = aws_iam_role_policy.ecs_task_execution_policy
}
