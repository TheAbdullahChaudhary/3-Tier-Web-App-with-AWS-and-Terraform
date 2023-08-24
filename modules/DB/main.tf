# DB - Security Group
resource "aws_security_group" "db_security_group" {
  name = "mydb1"

  description = "RDS postgres server"
  vpc_id      = var.vpc_id

  # Only postgres in
  ingress {
    from_port       = var.db_sg_ingress_to_port
    to_port         = var.db_sg_ingress_to_port
    protocol        = var.db_sg_ingress_protocol
    security_groups = [var.db_security_groups]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = var.db_sg_egress_from_port
    to_port     = var.db_sg_egress_to_port
    protocol    = var.db_sg_egress_protocol
    cidr_blocks = var.cidr_blocks_sg_egress_protocol
  }

}

# DB - Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  name = "e_db-subnet"
  # subnet_ids = [for value in aws_subnet.database_subnet: value.id]
  subnet_ids = var.db_subnets_ids


  tags = {
    Name = "My DB subnet group"
  }
}




# DB - RDS Instance
resource "aws_db_instance" "db_postgres" {
  allocated_storage       = var.db_rds_instance_allocated_storage
  backup_retention_period = var.db_rds_instance_backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name # DB - Subnet Group
  engine                  = var.db_rds_instance_engine
  engine_version          = var.db_rds_instance_engine_version
  identifier              = var.db_rds_instance_identifier
  instance_class          = var.db_rds_instance_instance_class
  multi_az                = var.db_rds_instance_multi_az
  name                    = var.db_rds_instance_name
  username                = var.db_rds_instance_username
  password                = var.db_rds_instance_password
  port                    = var.db_rds_instance_port
  publicly_accessible     = var.db_rds_instance_publicly_accessible
  storage_encrypted       = var.db_rds_instance_storage_encrypted
  storage_type            = var.db_rds_instance_storage_type
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  skip_final_snapshot     = var.db_rds_instance_skip_final_snapshot
}


