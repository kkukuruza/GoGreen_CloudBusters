## VPC
resource "aws_vpc" "go_green_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "GoGreenVpc"
  }
}
## Public Subnet
resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "Public Subnet"
  }
}

resource "aws_subnet" "public_subnet2" {
  cidr_block = var.public_subnet2
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "Public Subnet2"
  }
}
## Private Subnet
resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "Web Tier"
  }
}

resource "aws_subnet" "private_subnet2" {
  cidr_block = var.private_subnet2
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "Web Tier2"
  }
}

resource "aws_subnet" "private_subnet3" {
  cidr_block = var.private_subnet3
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "App Tier"
  }
}

resource "aws_subnet" "private_subnet4" {
  cidr_block = var.private_subnet4
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "App Tier2"
  }
}

resource "aws_subnet" "private_subnet5" {
  cidr_block = var.private_subnet5
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "DB Tier"
  }
}

resource "aws_subnet" "private_subnet6" {
  cidr_block = var.private_subnet6
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "DB Tier"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "GoGreen_ig" {
  vpc_id = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "go_green_internet_gateway"
  }
}

## Route Table
resource "aws_route_table" "GoGreen_rt" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GoGreen_ig.id
  }
  tags = {
    "Name" = "Public Route Table"
  }
}


## Route Table ASS
resource "aws_route_table_association" "GoGreen_ass" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

## Route Table ASS2
resource "aws_route_table_association" "GoGreen_ass2" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.public_subnet2.id
}
## Route Table ASS3
resource "aws_route_table_association" "GoGreen_ass3" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.private_subnet.id
}

## Route Table ASS4
resource "aws_route_table_association" "GoGreen_ass4" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.private_subnet2.id
}

## Route Table ASS5
resource "aws_route_table_association" "GoGreen_ass5" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.private_subnet3.id
}

## Route Table ASS6
resource "aws_route_table_association" "GoGreen_ass6" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.private_subnet4.id
}

## Route Table ASS7
resource "aws_route_table_association" "GoGreen_ass7" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.private_subnet5.id
}

## Route Table ASS8
resource "aws_route_table_association" "GoGreen_ass8" {
  route_table_id = aws_route_table.GoGreen_rt.id
  subnet_id      = aws_subnet.private_subnet6.id
}


## Elastic Ip
resource "aws_eip" "GoGreen_eip" {
  vpc = true
}
# Create a NAT gateway
resource "aws_nat_gateway" "GoGreen_nat" {
  allocation_id = aws_eip.GoGreen_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "example-nat-gateway"
  }
}

## Elastic Ip2
resource "aws_eip" "GoGreen_eip2" {
  vpc = true
}
# Create a NAT gateway
resource "aws_nat_gateway" "GoGreen_nat2" {
  allocation_id = aws_eip.GoGreen_eip2.id
  subnet_id     = aws_subnet.public_subnet2.id
  tags = {
    Name = "example-nat-gateway"
  }
}



# ALB (public) Security Group
resource "aws_security_group" "alb_sg" {
  name        = "ALB-SG"
  description = "Allow inbound traffic on ports 80 and 443"
  vpc_id      = aws_vpc.go_green_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Web Tier Security Group
resource "aws_security_group" "web_sg" {
  name        = "WEB-SG"
  description = "Allow inbound traffic on port 8080 from ALB-SG"
  vpc_id      = aws_vpc.go_green_vpc.id
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
}
# ALB (private) Security Group
resource "aws_security_group" "alb_private_sg" {
  name        = "ALBP-SG"
  description = "Allow inbound traffic on port 80 from WEB-SG"
  vpc_id      = aws_vpc.go_green_vpc.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }
}
# App Tier Security Group
resource "aws_security_group" "app_sg" {
  name        = "APP-SG"
  description = "Allow inbound traffic on port 8080 from ALBP-SG"
  vpc_id      = aws_vpc.go_green_vpc.id
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_private_sg.id]
  }
}
# Database Tier Security Group
resource "aws_security_group" "db_sg" {
  name        = "DB-SG"
  description = "Allow inbound traffic on port 3306 from APP-SG"
  vpc_id      = aws_vpc.go_green_vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
}


## Network_Acl
# Create Network ACLs for each tier
resource "aws_network_acl" "web" {
  vpc_id = aws_vpc.go_green_vpc.id
  tags = {
    Name = "web-acl"
  }
}
resource "aws_network_acl" "app" {
  vpc_id = aws_vpc.go_green_vpc.id
  tags = {
    Name = "app-acl"
  }
}
resource "aws_network_acl" "db" {
  vpc_id = aws_vpc.go_green_vpc.id
  tags = {
    Name = "db-acl"
  }
}
# Associate Network ACLs with their respective subnets
resource "aws_network_acl_association" "web" {
  subnet_id      = aws_subnet.private_subnet.id
  network_acl_id = aws_network_acl.web.id
}
resource "aws_network_acl_association" "web2" {
  subnet_id      = aws_subnet.private_subnet2.id
  network_acl_id = aws_network_acl.web.id
}
resource "aws_network_acl_association" "app" {
  subnet_id      = aws_subnet.private_subnet3.id
  network_acl_id = aws_network_acl.app.id
}
resource "aws_network_acl_association" "app2" {
  subnet_id      = aws_subnet.private_subnet4.id
  network_acl_id = aws_network_acl.app.id
}
resource "aws_network_acl_association" "db" {
  subnet_id      = aws_subnet.private_subnet5.id
  network_acl_id = aws_network_acl.db.id
}
resource "aws_network_acl_association" "db2" {
  subnet_id      = aws_subnet.private_subnet6.id
  network_acl_id = aws_network_acl.db.id
}
# Define rules for each tier
# Replace the CIDR blocks in the following rules with the appropriate CIDR blocks for your architecture.
# Web Tier: Allow traffic from ALB and App Tier
resource "aws_network_acl_rule" "web_allow_inbound" {
  network_acl_id = aws_network_acl.web.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.10.5.0/23" # Replace with the CIDR block of your ALB and App Tier
  from_port      = 0
  to_port        = 65535
}
# App Tier: Allow traffic from Web Tier and Database Tier
resource "aws_network_acl_rule" "app_allow_inbound" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.10.3.0/23" # Replace with the CIDR block of your Web Tier
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "app_allow_db" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.10.7.0/23" # Replace with the CIDR block of your Database Tier
  from_port      = 0
  to_port        = 65535
}
#Database Tier: Allow traffic from App Tier only
resource "aws_network_acl_rule" "db_allow_inbound" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.10.5.0/23" # Replace with the CIDR block of your App Tier
  from_port      = 0
  to_port        = 65535
}
#Default outbound rule to allow traffic to leave the subnets
resource "aws_network_acl_rule" "web_allow_outbound" {
  network_acl_id = aws_network_acl.web.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "app_allow_outbound" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "db_allow_outbound" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}