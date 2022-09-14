resource "aws_key_pair" "aws_linux_public" {
  key_name   = "saa_aws_linux_public"
  public_key = local.common_tags["AWS_LINUX_PUBLIC_KEY"]
}

resource "aws_key_pair" "aws_linux_private" {
  key_name   = "saa_aws_linux_private"
  public_key = local.common_tags["AWS_LINUX_PRIVATE_KEY"]
}

/* resource "aws_instance" "aws_linux_public" {
  ami                    = local.linux_ami_id
  instance_type          = local.ec2_instance_type
  key_name               = aws_key_pair.aws_linux_public.key_name
  vpc_security_group_ids = [aws_security_group.web_access.id]
  subnet_id              = local.subnet_1a_id
  user_data              = filebase64("./user-data-app-group.sh")

  tags = {
    Name = "TF AWS Linux -- Public"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/mark/.ssh/saa_aws_linux_public")
    timeout     = "4m"
  }
}

resource "aws_instance" "aws_linux_private" {
  ami                    = local.linux_ami_id
  instance_type          = local.ec2_instance_type
  key_name               = aws_key_pair.aws_linux_private.key_name
  vpc_security_group_ids = [aws_security_group.web_access.id]
  subnet_id              = aws_subnet.private.id

  tags = {
    Name = "TF AWS Linux -- Private"
  }

  connection {
    type        = "ssh"
    host        = self.private_ip
    user        = "ec2-user"
    private_key = file("/home/mark/.ssh/saa_aws_linux_private")
    timeout     = "4m"
  }
} */

/*
 resource "aws_key_pair" "windows" {
  key_name   = "saa_windows"
  public_key = local.common_tags["WINDOWS_KEY"]
}

 resource "aws_instance" "windows" {
  ami                    = "ami-0c95d38b24a19de18"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_access.id]
  subnet_id              = local.subnet_1a_id

  tags = {
    Name = "TF Windows"
  }

  connection {
    type        = "ssh"
    host        = self.private_ip
    user        = "ec2-user"
    private_key = file("/home/mark/.ssh/saa_windows")
    timeout     = "4m"
  }
}
*/
