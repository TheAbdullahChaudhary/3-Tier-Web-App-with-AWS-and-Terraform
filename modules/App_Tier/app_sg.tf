# App - EC2 Instance Security Group
resource "aws_security_group" "app_instance_sg" {
  name        = "app-server-security-group"
  description = "Allowing requests to the app servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.app_instance_sg_ingress_from_port
    to_port         = var.app_instance_sg_ingress_to_port
    protocol        = var.app_instance_sg_ingress_protocol
    security_groups = [aws_security_group.alb_app_http.id]
  }

  egress {
    from_port   = var.app_instance_sg_egress_from_port
    to_port     = var.app_instance_sg_egress_to_port
    protocol    = var.app_instance_sg_egress_protocol
    cidr_blocks = var.app_instance_sg_egress_cidr_blocks
  }

  tags = {
    Name = "app-server-security-group"
  }
}

output "app_instance_sg" {
  value = aws_security_group.app_instance_sg.id
}