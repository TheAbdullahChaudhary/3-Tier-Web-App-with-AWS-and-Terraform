terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.26.0"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "default"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
}


# $ terraform apply -var-file=env/dev.tfvars



#--------------------------------------------------------- Part I: VPC ---------------------------------------------------------

module "vpc" {
  source = "./modules/vpc"


  aws_region         = var.aws_region
  vpc_cidr_block     = var.vpc_cidr_block
  az_public_subnet   = var.az_public_subnet
  az_private_subnet  = var.az_private_subnet
  az_database_subnet = var.az_database_subnet
  availability_zones = var.availability_zones

}





#--------------------------------------------------------- Part II: Web Tier---------------------------------------------------------


module "Web_Tier" {
  source = "./modules/Web_Tier"


  # Web - ALB Security Group

  web_alb_sg_ingress_protocol    = var.web_alb_sg_ingress_protocol
  web_alb_sg_ingress_cidr_blocks = var.web_alb_sg_ingress_cidr_blocks
  web_alb_sg_egress_protocol     = var.web_alb_sg_egress_protocol
  web_alb_sg_egress_cidr_blocks  = var.web_alb_sg_egress_cidr_blocks
  web_alb_sg_ingress_from_port   = var.web_alb_sg_ingress_from_port
  web_alb_sg_ingress_to_port     = var.web_alb_sg_ingress_to_port
  web_alb_sg_egress_from_port    = var.web_alb_sg_egress_from_port
  web_alb_sg_egress_to_port      = var.web_alb_sg_egress_to_port


  # Web - Listener

  web_listener_port     = var.web_listener_port
  web_listener_protocol = var.web_listener_protocol
  web_listener_type     = var.web_listener_type



  # Web - Target Group

  web_target_group_port                  = var.web_target_group_port
  web_target_group_protocol              = var.web_target_group_protocol
  web_target_group_health_check_port     = var.web_target_group_health_check_port
  web_target_group_health_check_protocol = var.web_target_group_health_check_protocol

  # Web - EC2 Instance Security Group


  ec2_ingress_from_port = var.ec2_ingress_from_port
  ec2_ingress_to_port   = var.ec2_ingress_to_port
  ec2_ingress_protocol  = var.ec2_ingress_protocol

  #Subnet and VPC ID
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id




}





#--------------------------------------------------------- Part III: App Tier ---------------------------------------------------------
module "App_Tier" {
  source = "./modules/App_Tier"



  # App - ALB Security Group

  web_instance_sg_id = module.Web_Tier.web_instance_sg_id

  app_alb_sg_ingress_from_port  = var.app_alb_sg_ingress_from_port
  app_alb_sg_ingress_to_port    = var.app_alb_sg_ingress_to_port
  app_alb_sg_ingress_protocol   = var.app_alb_sg_ingress_protocol
  app_alb_sg_egress_from_port   = var.app_alb_sg_egress_from_port
  app_alb_sg_egress_to_port     = var.app_alb_sg_egress_to_port
  app_alb_sg_egress_protocol    = var.app_alb_sg_egress_protocol
  app_alb_sg_egress_cidr_blocks = var.app_alb_sg_egress_cidr_blocks


  # App - Application Load Balancer
  app_aws_lb = var.app_aws_lb


  # App - Listener
  app_listener_port     = var.app_listener_port
  app_listener_protocol = var.app_listener_protocol
  app_listener_type     = var.app_listener_type

  # App - Target Group
  app_target_group_port                  = var.app_target_group_port
  app_target_group_protocol              = var.app_target_group_protocol
  app_target_group_health_check_port     = var.app_target_group_health_check_port
  app_target_group_health_check_protocol = var.app_target_group_health_check_protocol


  # App - EC2 Instance Security Group
  app_instance_sg_ingress_from_port  = var.app_instance_sg_ingress_from_port
  app_instance_sg_ingress_to_port    = var.app_instance_sg_ingress_to_port
  app_instance_sg_ingress_protocol   = var.app_instance_sg_ingress_protocol
  app_instance_sg_egress_from_port   = var.app_instance_sg_egress_from_port
  app_instance_sg_egress_to_port     = var.app_instance_sg_egress_to_port
  app_instance_sg_egress_protocol    = var.app_instance_sg_egress_protocol
  app_instance_sg_egress_cidr_blocks = var.app_instance_sg_egress_cidr_blocks



  # App - Launch Template
  app_launch_template_name_prefix   = var.app_launch_template_name_prefix
  app_launch_template_image_id      = var.app_launch_template_image_id
  app_launch_template_instance_type = var.app_launch_template_instance_type


  # App - Auto Scaling Group
  app_asg_desired_capacity = var.app_asg_desired_capacity
  app_asg_max_size         = var.app_asg_max_size
  app_asg_min_size         = var.app_asg_min_size


  #VPC ID
  vpc_id = module.vpc.vpc_id


  #vpc_zone_identifiers is private subnet
  vpc_zone_identifiers = module.vpc.private_subnet_id

}




# --------------------------------------------------------- Part IV: DB ---------------------------------------------------------

module "DB" {
  source = "./modules/DB"


  # DB - Security Group
  db_sg_ingress_from_port        = var.db_sg_ingress_from_port
  db_sg_ingress_to_port          = var.db_sg_ingress_to_port
  db_sg_ingress_protocol         = var.db_sg_ingress_protocol
  db_sg_egress_from_port         = var.db_sg_egress_from_port
  db_sg_egress_to_port           = var.db_sg_egress_to_port
  db_sg_egress_protocol          = var.db_sg_egress_protocol
  cidr_blocks_sg_egress_protocol = var.cidr_blocks_sg_egress_protocol



  # DB - RDS Instance
  db_rds_instance_allocated_storage       = var.db_rds_instance_allocated_storage
  db_rds_instance_backup_retention_period = var.db_rds_instance_backup_retention_period
  db_rds_instance_engine                  = var.db_rds_instance_engine
  db_rds_instance_engine_version          = var.db_rds_instance_engine_version
  db_rds_instance_identifier              = var.db_rds_instance_identifier
  db_rds_instance_instance_class          = var.db_rds_instance_instance_class
  db_rds_instance_multi_az                = var.db_rds_instance_multi_az
  db_rds_instance_name                    = var.db_rds_instance_name
  db_rds_instance_username                = var.db_rds_instance_username
  db_rds_instance_password                = var.db_rds_instance_password
  db_rds_instance_port                    = var.db_rds_instance_port
  db_rds_instance_publicly_accessible     = var.db_rds_instance_publicly_accessible
  db_rds_instance_storage_encrypted       = var.db_rds_instance_storage_encrypted
  db_rds_instance_storage_type            = var.db_rds_instance_storage_type
  db_rds_instance_skip_final_snapshot     = var.db_rds_instance_skip_final_snapshot


  #VPC ID (pasing from VPC Module)
  vpc_id = module.vpc.vpc_id


  # DB - Security Group taken from App sg
  # db_instance_sg_id = module.App_Tier.app_instance_sg_id
  db_security_groups = module.App_Tier.app_instance_sg



  # DB - Subnet Group 

  db_subnets_ids = module.vpc.db_subnet_id


}