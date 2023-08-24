#--------------------------------------------------------- Part I: VPC---------------------------------------------------------

aws_region = "ap-southeast-1"

vpc_cidr_block = "10.0.0.0/16"

az_public_subnet = {
  "ap-southeast-1a" : "10.0.0.0/24",
  "ap-southeast-1b" : "10.0.1.0/24"
}

az_private_subnet = {
  "ap-southeast-1a" : "10.0.101.0/24",
  "ap-southeast-1b" : "10.0.102.0/24"
}

az_database_subnet = {
  "ap-southeast-1a" : "10.0.201.0/24",
  "ap-southeast-1b" : "10.0.202.0/24"
}

availability_zones = [
  "ap-southeast-1a",
  "ap-southeast-1b"
]





# ---------------------------------------------------------Part II: Web Tier---------------------------------------------------------



# Web - ALB Security Group
web_alb_sg_ingress_protocol    = "tcp"
web_alb_sg_ingress_cidr_blocks = ["0.0.0.0/0"]
web_alb_sg_egress_protocol     = "-1"
web_alb_sg_egress_cidr_blocks  = ["0.0.0.0/0"]
web_alb_sg_ingress_to_port     = 80
web_alb_sg_ingress_from_port   = 80
web_alb_sg_egress_from_port    = 0
web_alb_sg_egress_to_port      = 0



# Web - Listener
web_listener_port     = "80"
web_listener_protocol = "HTTP"
web_listener_type     = "forward"


# Web - Target Group
web_target_group_port                  = 80
web_target_group_protocol              = "HTTP"
web_target_group_health_check_port     = 80
web_target_group_health_check_protocol = "HTTP"



# Web - EC2 Instance Security Group
ec2_ingress_from_port = 80
ec2_ingress_to_port   = 80
ec2_ingress_protocol  = "tcp"




# --------------------------------------------------------- Part III: App Tier ---------------------------------------------------------


# App - ALB Security Group
app_alb_sg_ingress_from_port  = 80
app_alb_sg_ingress_to_port    = 80
app_alb_sg_ingress_protocol   = "tcp"
app_alb_sg_egress_from_port   = 0
app_alb_sg_egress_to_port     = 0
app_alb_sg_egress_protocol    = "-1"
app_alb_sg_egress_cidr_blocks = ["0.0.0.0/0"]


# App - Application Load Balancer
app_aws_lb = false


# App - Listener
app_listener_port     = "80"
app_listener_protocol = "HTTP"
app_listener_type     = "forward"

# App - Target Group
app_target_group_port                  = 80
app_target_group_protocol              = "HTTP"
app_target_group_health_check_port     = 80
app_target_group_health_check_protocol = "HTTP"


# App - EC2 Instance Security Group
app_instance_sg_ingress_from_port  = 80
app_instance_sg_ingress_to_port    = 80
app_instance_sg_ingress_protocol   = "tcp"
app_instance_sg_egress_from_port   = 0
app_instance_sg_egress_to_port     = 0
app_instance_sg_egress_protocol    = "-1"
app_instance_sg_egress_cidr_blocks = ["0.0.0.0/0"]



# App - Launch Template
app_launch_template_name_prefix   = "app-launch-template"
app_launch_template_image_id      = "ami-0e2e44c03b85f58b3"
app_launch_template_instance_type = "t2.micro"


# App - Auto Scaling Group
app_asg_desired_capacity = 0
app_asg_max_size         = 0
app_asg_min_size         = 0



# --------------------------------------------------------- Part IV: DB ---------------------------------------------------------

# DB - Security Group

db_sg_ingress_from_port        = 5432
db_sg_ingress_to_port          = 5432
db_sg_ingress_protocol         = "tcp"
db_sg_egress_from_port         = 0
db_sg_egress_to_port           = 0
db_sg_egress_protocol          = "-1"
cidr_blocks_sg_egress_protocol = ["0.0.0.0/0"]




# DB - RDS Instance

db_rds_instance_allocated_storage       = 256 # gigabytes
db_rds_instance_backup_retention_period = 7   # in days
db_rds_instance_engine                  = "postgres"
db_rds_instance_engine_version          = "14.9"
db_rds_instance_identifier              = "dbpostgres"
db_rds_instance_instance_class          = "db.t3.micro"
db_rds_instance_multi_az                = false
db_rds_instance_name                    = "dbpostgres"
db_rds_instance_username                = "dbadmin"
db_rds_instance_password                = "set-your-own-password!"
db_rds_instance_port                    = 5432
db_rds_instance_publicly_accessible     = false
db_rds_instance_storage_encrypted       = true
db_rds_instance_storage_type            = "gp2"
db_rds_instance_skip_final_snapshot     = true