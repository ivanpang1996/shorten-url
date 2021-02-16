//resource "aws_elasticache_replication_group" "redis_cluster" {
//  replication_group_id          = "redis-cluster"
//  replication_group_description = "redis-cluster"
//  node_type                     = "cache.t2.small"
//  port                          = 6379
//  parameter_group_name          = "default.redis6.x.cluster.on"
//  automatic_failover_enabled    = true
//  security_group_ids = [aws_security_group.redis_cluster.id]
//
//  cluster_mode {
//    replicas_per_node_group = 1
//    num_node_groups         = 2
//  }
//}
//
//resource "aws_security_group" "redis_cluster" {
//  name        = "redis-cluster"
//  description = "redis-cluster"
//  vpc_id = data.aws_vpc.default_vpc.id
//
//  ingress {
//    from_port   = 6379
//    to_port     = 6379
//    protocol    = "tcp"
//    security_groups = [module.url_shortener_service.security_group]
//  }
//
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}
