# DB - Security Group

variable "db_sg_ingress_from_port" {
}

variable "db_sg_ingress_to_port" {
}

variable "db_sg_ingress_protocol" {
}

variable "db_sg_egress_from_port" {
}

variable "db_sg_egress_to_port" {
}

variable "db_sg_egress_protocol" {
}

variable "cidr_blocks_sg_egress_protocol" {
}




# DB - Subnet Group
variable "db_subnets_ids" {
  type = list(string)

}



# DB - RDS Instance

variable "db_rds_instance_allocated_storage" {
}

variable "db_rds_instance_backup_retention_period" {
}

variable "db_rds_instance_engine" {
}

variable "db_rds_instance_engine_version" {
}

variable "db_rds_instance_identifier" {
}

variable "db_rds_instance_instance_class" {
}

variable "db_rds_instance_multi_az" {
}

variable "db_rds_instance_name" {
}

variable "db_rds_instance_username" {
}

variable "db_rds_instance_password" {
}

variable "db_rds_instance_port" {
}

variable "db_rds_instance_publicly_accessible" {
}

variable "db_rds_instance_storage_encrypted" {
}

variable "db_rds_instance_storage_type" {
}

variable "db_rds_instance_skip_final_snapshot" {
}




#VPC ID 
variable "vpc_id" {
}

# DB - Security Group taken from App sg
variable "db_security_groups" {
}



