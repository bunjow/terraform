###########################################################
# NAT to open up matt-priv-* subnets to outbound internet trafic
###########################################################

# nat gw
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.matt-pub-a.id
  depends_on    = [aws_internet_gateway.matt-gw]
}

# VPC setup for NAT
resource "aws_route_table" "matt-pri" {
  vpc_id = aws_vpc.matt.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "matt-priv-ate-1"
  }
}

# route associations private
resource "aws_route_table_association" "matt-priv-1-a" {
  subnet_id      = aws_subnet.matt-priv-a.id
  route_table_id = aws_route_table.matt-pri.id
}

resource "aws_route_table_association" "matt-priv-2-a" {
  subnet_id      = aws_subnet.matt-priv-b.id
  route_table_id = aws_route_table.matt-pri.id
}

resource "aws_route_table_association" "matt-priv-3-a" {
  subnet_id      = aws_subnet.matt-priv-c.id
  route_table_id = aws_route_table.matt-pri.id
}

