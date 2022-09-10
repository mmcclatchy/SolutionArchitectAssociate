resource "aws_subnet" "private" {
  vpc_id            = local.default_vpc_id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "TF private-def-1a"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  subnet_id         = local.subnet_1a_id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_gateway.id


  tags = {
    Name = "TF gw NAT"
  }
}

resource "aws_route_table" "private" {
  vpc_id = local.default_vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "TF private-RT"
  }
}

resource "aws_route_table_association" "nat_gateway" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
