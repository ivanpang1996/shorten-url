output "service_name" {
  value = aws_ecs_service.url_shortener_service.name
}

output "security_group" {
  value = aws_security_group.ecs_service.id
}
