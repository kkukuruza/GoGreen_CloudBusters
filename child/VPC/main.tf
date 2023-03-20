## VPC
resource "aws_vpc" "go_green_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "${var.vpc_tag} VPC",
    "ENV"  = "${var.env_tag} Server"
  }
}
## Public Subnet
resource "aws_subnet" "public_subnet_1" {
  cidr_block = var.public_subnet_1
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  cidr_block = var.public_subnet_2
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} Public Subnet 2"
  }
}
## Private Subnet
resource "aws_subnet" "private_subnet_1" {
  cidr_block = var.private_subnet_1
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} Web Tier 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  cidr_block = var.private_subnet_2
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} Web Tier 2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  cidr_block = var.private_subnet_3
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} App Tier 1"
  }
}

resource "aws_subnet" "private_subnet_4" {
  cidr_block = var.private_subnet_4
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} App Tier 2"
  }
}

resource "aws_subnet" "private_subnet_5" {
  cidr_block = var.private_subnet_5
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} DB Tier 1"
  }
}

resource "aws_subnet" "private_subnet_6" {
  cidr_block = var.private_subnet_6
  vpc_id     = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} DB Tier 2"
  }
}

## Internet Gateway
resource "aws_internet_gateway" "go_green_ig" {
  vpc_id = aws_vpc.go_green_vpc.id
  tags = {
    "Name" = "${var.vpc_tag} IG"
  }
}

## Elastic Ip 1
resource "aws_eip" "go_green_eip_1" {
  vpc = true
}

# Create a NAT gateway 1
resource "aws_nat_gateway" "go_green_nat_1" {
  allocation_id = aws_eip.go_green_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "${var.vpc_tag} NAT 1"
  }
}

## Elastic Ip 2 
resource "aws_eip" "go_green_eip_2" {
  vpc = true
}
# Create a NAT gateway 2
resource "aws_nat_gateway" "go_green_nat_2" {
  allocation_id = aws_eip.go_green_eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "${var.vpc_tag} NAT 2"
  }
}

## Route Table
resource "aws_route_table" "go_green_rt" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.go_green_ig.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Public Route Table"
  }
}

## Private Route Table 1
resource "aws_route_table" "go_green_private_rt_1" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go_green_nat_1.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Private Route Table 1"
  }
}

## Private Route Table 3
resource "aws_route_table" "go_green_private_rt_3" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go_green_nat_1.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Private Route Table 3"
  }
}

## Private Route Table 5
resource "aws_route_table" "go_green_private_rt_5" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go_green_nat_1.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Private Route Table 5"
  }
}

## Private Route Table 2
resource "aws_route_table" "go_green_private_rt_2" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go_green_nat_2.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Private Route Table 2"
  }
}

## Private Route Table 4
resource "aws_route_table" "go_green_private_rt_4" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go_green_nat_2.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Private Route Table 4"
  }
}

## Private Route Table 6
resource "aws_route_table" "go_green_private_rt_6" {
  vpc_id = aws_vpc.go_green_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go_green_nat_2.id
  }
  tags = {
    "Name" = "${var.vpc_tag} Private Route Table 6"
  }
}

## Route Table ASS 1
resource "aws_route_table_association" "go_green_ass_1" {
  route_table_id = aws_route_table.go_green_rt.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

## Route Table ASS 2
resource "aws_route_table_association" "go_green_ass_2" {
  route_table_id = aws_route_table.go_green_rt.id
  subnet_id      = aws_subnet.public_subnet_2.id
}
## Private Route Table ASS 1
resource "aws_route_table_association" "go_green_ass_3" {
  route_table_id = aws_route_table.go_green_private_rt_1.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

## Route Table ASS4
resource "aws_route_table_association" "GoGreen_ass4" {
  route_table_id = aws_route_table.go_green_private_rt_2.id
  subnet_id      = aws_subnet.private_subnet_2.id
}

## Route Table ASS5
resource "aws_route_table_association" "GoGreen_ass5" {
  route_table_id = aws_route_table.go_green_private_rt_3.id
  subnet_id      = aws_subnet.private_subnet_3.id
}

## Route Table ASS6
resource "aws_route_table_association" "GoGreen_ass6" {
  route_table_id = aws_route_table.go_green_private_rt_4.id
  subnet_id      = aws_subnet.private_subnet_4.id
}

## Route Table ASS7
resource "aws_route_table_association" "GoGreen_ass7" {
  route_table_id = aws_route_table.go_green_private_rt_5.id
  subnet_id      = aws_subnet.private_subnet_5.id
}

## Route Table ASS8
resource "aws_route_table_association" "GoGreen_ass8" {
  route_table_id = aws_route_table.go_green_private_rt_6.id
  subnet_id      = aws_subnet.private_subnet_6.id
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
  subnet_id      = aws_subnet.private_subnet_1.id
  network_acl_id = aws_network_acl.web.id
}
resource "aws_network_acl_association" "web2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  network_acl_id = aws_network_acl.web.id
}
resource "aws_network_acl_association" "app" {
  subnet_id      = aws_subnet.private_subnet_3.id
  network_acl_id = aws_network_acl.app.id
}
resource "aws_network_acl_association" "app2" {
  subnet_id      = aws_subnet.private_subnet_4.id
  network_acl_id = aws_network_acl.app.id
}
resource "aws_network_acl_association" "db" {
  subnet_id      = aws_subnet.private_subnet_5.id
  network_acl_id = aws_network_acl.db.id
}
resource "aws_network_acl_association" "db2" {
  subnet_id      = aws_subnet.private_subnet_6.id
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
  cidr_block     = "10.10.5.0/23"
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
  cidr_block     = "10.10.3.0/23"
  from_port      = 0
  to_port        = 65535
}
resource "aws_network_acl_rule" "app_allow_db" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.10.7.0/23"
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
  cidr_block     = "10.10.5.0/23"
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