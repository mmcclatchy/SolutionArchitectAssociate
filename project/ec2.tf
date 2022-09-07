/* resource "aws_key_pair" "aws_linux" {
    key_name = "saa_aws_linux"
    public_key = local.common_tags["PUBLIC_KEY"]
} */

resource "aws_instance" "aws_linux" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  /* key_name = aws_key_pair.aws_linux.key_name */
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id

  tags = {
    Name = "TF AWS Linux"
  }
}

resource "aws_instance" "windows" {
  ami                    = "ami-0c95d38b24a19de18"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id

  tags = {
    Name = "TF Windows"
  }
}
