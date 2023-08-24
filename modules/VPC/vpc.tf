# VPC Resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "VPC-Lab"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gateway"
  }
}


# Public Subnet
resource "aws_subnet" "public_subnet" {
  for_each = var.az_public_subnet

  vpc_id = aws_vpc.main.id

  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "public-subnet-${each.key}"
  }
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  for_each = var.az_private_subnet

  vpc_id = aws_vpc.main.id

  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "private-subnet-${each.key}"
  }
}



# Database Subnet
resource "aws_subnet" "database_subnet" {
  for_each = var.az_database_subnet

  vpc_id = aws_vpc.main.id

  availability_zone = each.key
  cidr_block        = each.value

  tags = {
    Name = "database-subnet-${each.key}"
  }
}



# Route Table 
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "my-public-subnet-route-table"
  }
}

# Public subnet route table association
resource "aws_route_table_association" "public_subnet_route_table_association" {
  for_each = var.az_public_subnet

  subnet_id      = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}





output "vpc_id" {
  value = aws_vpc.main.id
}


output "public_subnet_id" {
  value = toset([for subnet in aws_subnet.public_subnet : subnet.id])
}


output "private_subnet_id" {
  value = toset([for subnet in aws_subnet.private_subnet : subnet.id])
}


# DB - Subnet Group 

output "db_subnet_id" {
  value = toset([for subnet in aws_subnet.database_subnet : subnet.id])
}


# output "public_subnet_id" {
#   value = aws_subnet.public_subnet[*].id
# }


# output "public_subnet_ids" {
#   value = { for subnet_key, subnet in aws_subnet.public_subnet : subnet_key => subnet.id }
# }


# ... (previous resource definitions)

# # Output for VPC ID
# output "vpc_id" {
#   value = aws_vpc.main.id
# }

# # Output for Public Subnet IDs
# output "public_subnet_ids" {
#   value = { for subnet_key, subnet in aws_subnet.public_subnet : subnet_key => subnet.id }
# }
