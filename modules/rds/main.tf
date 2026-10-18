# Only the allowed security group (EKS nodes) can reach the database on 3306
resource "aws_security_group" "this" {
  name   = "${var.name}-rds"
  vpc_id = var.vpc_id

  ingress {
    description     = "MySQL from EKS nodes"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.allowed_security_group]
  }
}

module "this" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.10"

  identifier = "${var.name}-mysql"

  engine               = "mysql"
  engine_version       = "8.4"
  family               = "mysql8.4"
  major_engine_version = "8.4"
  instance_class       = var.instance_class

  allocated_storage     = 20
  max_allocated_storage = 100 # storage autoscaling

  db_name  = var.db_name
  username = "admin"
  port     = 3306

  # Password is generated and stored in AWS Secrets Manager, never in code or state
  manage_master_user_password = true

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.this.id]

  multi_az                = var.multi_az
  backup_retention_period = 7
  deletion_protection     = var.deletion_protection
  skip_final_snapshot     = !var.deletion_protection
}
