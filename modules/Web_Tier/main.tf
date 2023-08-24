# Web - Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_http.id]
  # subnets            = [for value in aws_subnet.public_subnet : value.id]
  subnets = var.public_subnet_id
}

# Web - ALB Security Group
resource "aws_security_group" "alb_http" {
  name        = "alb-security-group"
  description = "Allowing HTTP requests to the application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.web_alb_sg_ingress_from_port
    to_port     = var.web_alb_sg_ingress_to_port
    protocol    = var.web_alb_sg_ingress_protocol
    cidr_blocks = var.web_alb_sg_ingress_cidr_blocks
  }

  egress {
    from_port   = var.web_alb_sg_egress_from_port
    to_port     = var.web_alb_sg_egress_to_port
    protocol    = var.web_alb_sg_egress_protocol
    cidr_blocks = var.web_alb_sg_egress_cidr_blocks
  }

  tags = {
    Name = "alb-security-group"
  }
}




# Web - Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.web_listener_port
  protocol          = var.web_listener_protocol

  default_action {
    type             = var.web_listener_type
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }
}

# Web - Target Group
resource "aws_lb_target_group" "web_target_group" {
  name     = "web-target-group"
  port     = var.web_target_group_port
  protocol = var.web_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = var.web_target_group_health_check_port
    protocol = var.web_target_group_health_check_protocol
  }
}





#sc




# Web - Launch Template
resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-launch-template"
  image_id      = "ami-0e2e44c03b85f58b3"
  instance_type = "t2.micro"
}

# Web - Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity  = 0
  max_size          = 0
  min_size          = 0
  target_group_arns = [aws_lb_target_group.web_target_group.arn]

  # vpc_zone_identifier = [for value in aws_subnet.public_subnet: value.id]
  vpc_zone_identifier = var.public_subnet_id

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }




  #SG OUTPUT

  #   output "web_security_groups_id" {
  #   value = aws_security_group.web_instance_sg.id
  # }

  # output "web_instance_sg_id" {
  #   value = aws_security_group.web_instance_sg.id
  # }

  # output "web_instance_sg_id" {
  #   value = aws_security_group.web_instance_sg.id
  # }
  # output "web_instance_sg_id" {
  #   value = aws_security_group.web_instance_sg.id
  # }
}