#----------------------------------------------- Part I: VPC-----------------------------------------------


variable "aws_region" {
  description = "AWS Region"
}

variable "vpc_cidr_block" {
  description = "Main VPC CIDR Block"
}

variable "az_public_subnet" {
  type = map(string)
}

variable "az_private_subnet" {
  type = map(string)
}

variable "az_database_subnet" {
  type = map(string)
}

variable "availability_zones" {
  type = list(string)
}







#----------------------------------------------- Part II: Web Tier-----------------------------------------------



# Web - Application Load Balancer

# variable "public_subnet_id"{

# }




# Web - ALB Security Group


variable "web_alb_sg_ingress_protocol" {
}

variable "web_alb_sg_ingress_cidr_blocks" {
}

variable "web_alb_sg_egress_protocol" {
}

variable "web_alb_sg_egress_cidr_blocks" {
}

variable "web_alb_sg_ingress_from_port" {
}

variable "web_alb_sg_ingress_to_port" {
}

variable "web_alb_sg_egress_from_port" {
}

variable "web_alb_sg_egress_to_port" {
}





# Web - Listener

variable "web_listener_port" {
}

variable "web_listener_protocol" {
}

variable "web_listener_type" {
}


# Web - Target Group

variable "web_target_group_port" {
}

variable "web_target_group_protocol" {
}

variable "web_target_group_health_check_port" {
}

variable "web_target_group_health_check_protocol" {
}




# Web - EC2 Instance Security Group


variable "ec2_ingress_from_port" {
}

variable "ec2_ingress_to_port" {
}

variable "ec2_ingress_protocol" {
}




#----------------------------------------------- Part III: App Tier-----------------------------------------------


# App - ALB Security Group

variable "app_alb_sg_ingress_from_port" {
}

variable "app_alb_sg_ingress_to_port" {
}

variable "app_alb_sg_ingress_protocol" {
}

variable "app_alb_sg_egress_from_port" {
}

variable "app_alb_sg_egress_to_port" {
}

variable "app_alb_sg_egress_protocol" {
}

variable "app_alb_sg_egress_cidr_blocks" {
}




# App - Application Load Balancer

variable "app_aws_lb" {
}




# App - Listener

variable "app_listener_port" {
}

variable "app_listener_protocol" {
}

variable "app_listener_type" {
}


# App - Target Group
variable "app_target_group_port" {
}

variable "app_target_group_protocol" {
}

variable "app_target_group_health_check_port" {
}

variable "app_target_group_health_check_protocol" {
}


# App - EC2 Instance Security Group


variable "app_instance_sg_ingress_from_port" {
}

variable "app_instance_sg_ingress_to_port" {
}

variable "app_instance_sg_ingress_protocol" {
}

variable "app_instance_sg_egress_from_port" {
}

variable "app_instance_sg_egress_to_port" {
}

variable "app_instance_sg_egress_protocol" {
}

variable "app_instance_sg_egress_cidr_blocks" {
}


# App - Launch Template

variable "app_launch_template_name_prefix" {
}

variable "app_launch_template_image_id" {
}

variable "app_launch_template_instance_type" {
}



# App - Auto Scaling Group
variable "app_asg_desired_capacity" {
}

variable "app_asg_max_size" {
}

variable "app_asg_min_size" {
}






# --------------------------------------------------------- Part IV: DB ---------------------------------------------------------

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