variable "cluster_id" {}

variable "service_name" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "container_definitions" {}

variable "ecs_task_execution_role_arn" {}

variable "ecs_task_execution_role_policy" {}
