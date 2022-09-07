resource "aws_vpc" "main" {
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
}

resource "aws_network_interface" "main" {
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.main.id]

  attachment {
    instance     = aws_instance.aws_linux.id
    device_index = 1
  }

  tags = {
    Name = "TF Main"
  }
}
