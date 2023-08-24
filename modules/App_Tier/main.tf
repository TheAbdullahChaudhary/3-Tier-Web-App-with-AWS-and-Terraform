# App - ALB Security Group
resource "aws_security_group" "alb_app_http" {
  name        = "alb-app-security-group"
  description = "Allowing HTTP requests to the app tier application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.app_alb_sg_ingress_from_port
    to_port         = var.app_alb_sg_ingress_to_port
    protocol        = var.app_alb_sg_ingress_protocol
    security_groups = [var.web_instance_sg_id]


  }

  egress {
    from_port   = var.app_alb_sg_egress_from_port
    to_port     = var.app_alb_sg_egress_to_port
    protocol    = var.app_alb_sg_egress_protocol
    cidr_blocks = var.app_alb_sg_egress_cidr_blocks
  }

  tags = {
    Name = "alb-app-security-group"
  }
}

# App - Application Load Balancer
resource "aws_lb" "app_app_lb" {
  name               = "app-app-lb"
  internal           = var.app_aws_lb
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_app_http.id]
  #vpc_zone_identifiers is private subnet
  subnets = var.vpc_zone_identifiers
  # subnets = [for value in aws_subnet.private_subnet: value.id]
}





# App - Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_app_lb.arn
  port              = var.app_listener_port
  protocol          = var.app_listener_protocol

  default_action {
    type             = var.app_listener_type
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}


# App - Target Group
resource "aws_lb_target_group" "app_target_group" {
  name     = "app-target-group"
  port     = var.app_target_group_port
  protocol = var.app_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = var.app_target_group_health_check_port
    protocol = var.app_target_group_health_check_protocol
  }
}







# App - Launch Template
resource "aws_launch_template" "app_launch_template" {
  name_prefix            = var.app_launch_template_name_prefix
  image_id               = var.app_launch_template_image_id
  instance_type          = var.app_launch_template_instance_type
  vpc_security_group_ids = [aws_security_group.app_instance_sg.id]
}

# App - Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  desired_capacity  = var.app_asg_desired_capacity
  max_size          = var.app_asg_max_size
  min_size          = var.app_asg_min_size
  target_group_arns = [aws_lb_target_group.app_target_group.arn]
  # vpc_zone_identifier = [for value in aws_subnet.private_subnet: value.id]

  #vpc_zone_identifiers is private subnet
  vpc_zone_identifier = var.vpc_zone_identifiers

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }



  #Output app_instance_sg for DB sg

  # output "app_instance_sg" {
  #   value = aws_security_group.app_instance_sg.id
  # }





}





