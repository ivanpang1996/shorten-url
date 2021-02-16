resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.t3.medium"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.5"
  port                 = 6379
}

//resource "aws_elasticache_replication_group" "baz" {
//  replication_group_id          = "tf-redis-cluster"
//  replication_group_description = "test description"
//  node_type                     = "cache.t2.small"
//  port                          = 6379
//  parameter_group_name          = "default.redis3.2.cluster.on"
//  automatic_failover_enabled    = true
//
//  cluster_mode {
//    replicas_per_node_group = 1
//    num_node_groups         = 2
//  }
//}
