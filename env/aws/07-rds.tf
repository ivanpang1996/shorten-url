resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier      = "db-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name           = "url"
  master_username         = "root"
  master_password         = data.external.db_password.result["PASSWORD"]
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

# TODO: please run ../init/00-setup-secret.sh before "terraform apply"
data "external" "db_password" {
  program = [
    "bash",
    "-c",
    "aws ssm get-parameter --name DB_PASSWORD | jq '{PASSWORD: .Parameter.Value}'"]
}
