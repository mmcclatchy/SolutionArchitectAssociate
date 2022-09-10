/* resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "TF Main"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/16"
  availability_zone = "us-east-1b"

  tags = {
    Name = "TF Main"
  }
} */

resource "aws_subnet" "private" {
  vpc_id            = local.default_vpc_id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "TF private-def-1a"
  }
}

/* resource "aws_network_interface" "main" {
  subnet_id       = local.subnet_1a_id
  security_groups = [aws_security_group.main.id]

  attachment {
    instance     = aws_instance.aws_linux_public.id
    device_index = 1
  }

  tags = {
    Name = "TF Main"
  }
}

resource "aws_route_table" "private" {
  vpc_id = local.default_vpc_id
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
} */
