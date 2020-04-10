# these resources are added to provide the vpc_id and subnets to the consul module
# aws* are resources that terraform doesn't creat, rather adopt
# See https://www.terraform.io/docs/providers/aws/r/matt_vpc.html for more info

#VPC
resource "aws_vpc" "matt" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "matt"
  }
}

###################################
# Public Subnets
###################################
resource "aws_subnet" "matt-pub-a" {
  vpc_id                  = aws_vpc.matt.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "mattPub ${var.AWS_REGION}a"
  }
}

resource "aws_subnet" "matt-pub-b" {
  vpc_id                  = aws_vpc.matt.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "mattPub ${var.AWS_REGION}b"
  }
}

resource "aws_subnet" "matt-pub-c" {
  vpc_id                  = aws_vpc.matt.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "mattPub ${var.AWS_REGION}c"
  }
}

########################################
# Private Subnets
########################################
resource "aws_subnet" "matt-pri-a" {
  vpc_id                  = aws_vpc.matt.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "mattPri ${var.AWS_REGION}a"
  }
}

resource "aws_subnet" "matt-pri-b" {
  vpc_id                  = aws_vpc.matt.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "mattPri ${var.AWS_REGION}b"
  }
}

resource "aws_subnet" "matt-pri-c" {
  vpc_id                  = aws_vpc.matt.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "mattPri ${var.AWS_REGION}c"
  }
}
####################
# Internet GW
####################
resource "aws_internet_gateway" "matt-gw" {
  vpc_id = aws_vpc.matt.id

  tags = {
    Name = "matt"
  }
}
#############################
# route tables 
#############################
resource "aws_route_table" "matt-public" {
  vpc_id = aws_vpc.matt.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.matt-gw.id
  }

  tags = {
    Name = "matt-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "matt-pub-a" {
  subnet_id      = aws_subnet.matt-pub-a.id
  route_table_id = aws_route_table.matt-public.id
}

resource "aws_route_table_association" "matt-pub-b" {
  subnet_id      = aws_subnet.matt-pub-b.id
  route_table_id = aws_route_table.matt-public.id
}

resource "aws_route_table_association" "matt-pub-c" {
  subnet_id      = aws_subnet.matt-pub-c.id
  route_table_id = aws_route_table.matt-public.id
}

# -----------------------------------------------------------
# lock off default Security Group, then add a new set
# -----------------------------------------------------------

resource "aws_default_security_group" "matt_default" {
  vpc_id = aws_vpc.matt.id
  ## tags   = "merge(map("Name","log-matt"), var.tags)"
  tags = { Name = "matt-default" }
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = aws_vpc.matt.id
}

##output "MattDefaultSG" {
##  value = data.aws_security_group.default.id
##}

#############################################################
# Open up to home SSH and http
#############################################################
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_inbound
  security_group_id = data.aws_security_group.default.id
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.http_inbound
  security_group_id = data.aws_security_group.default.id
}

