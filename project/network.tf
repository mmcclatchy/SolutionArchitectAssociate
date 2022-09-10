resource "aws_subnet" "private" {
  vpc_id            = local.default_vpc_id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "TF private-def-1a"
  }
}
