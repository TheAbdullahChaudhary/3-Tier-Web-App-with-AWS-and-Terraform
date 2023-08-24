# Web - Application Load Balancer

variable "public_subnet_id" {
}




# Web - ALB Security Group


variable "web_alb_sg_ingress_protocol" {
}

variable "web_alb_sg_ingress_cidr_blocks" {
}

variable "web_alb_sg_egress_protocol" {
}

variable "web_alb_sg_egress_cidr_blocks" {
}

variable "vpc_id" {
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





#web_instance_sg_id output

# variable "web_instance_sg_id"{ 
# }