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


#VPC ID

variable "vpc_id" {
}



#SG ID
# variable "web_instance_sg_id"{
# }

# variable "web_instance_sg_id"{
# description = "Security group ID for web instances"
#   type        = list(string) 

# }

# variable "web_instance_sg_id"{
# }
variable "web_instance_sg_id" {

}




variable "vpc_zone_identifiers" {

}

# variable "private_subnet_id" {

# }


