# Web - EC2 Instance Security Group
resource "aws_security_group" "web_instance_sg" {
  name        = "web-server-security-group"
  description = "Allowing requests to the web servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.ec2_ingress_from_port
    to_port         = var.ec2_ingress_to_port
    protocol        = var.ec2_ingress_protocol
    security_groups = [aws_security_group.alb_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-security-group"
  }
}

# moduleA/outputs.tf

output "web_instance_sg_id" {
  value = aws_security_group.web_instance_sg.id
}
