resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier      = "db-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "url"
  master_username         = "root"
  master_password         = "root123456"   #TODO
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster_instance" "db_cluster_instances" {
  count              = 2
  identifier         = "db-cluster-${count.index}"
  cluster_identifier = aws_rds_cluster.db_cluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.db_cluster.engine
  engine_version     = aws_rds_cluster.db_cluster.engine_version
  publicly_accessible = true
}

resource "aws_rds_cluster_endpoint" "endpoint" {
  cluster_identifier          = aws_rds_cluster.db_cluster.id
  cluster_endpoint_identifier = "cluster"
  custom_endpoint_type        = "ANY"

  static_members = [
    aws_rds_cluster_instance.db_cluster_instances[0].id,
    aws_rds_cluster_instance.db_cluster_instances[1].id
  ]
}
