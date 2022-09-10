terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}

locals {
  common_tags            = { for tuple in regexall("([A-Z_]*)='?([^']*)", file("~/aws/saa/.env")) : tuple[0] => tuple[1] }
  default_vpc_id         = "vpc-065b05fa937fadb2d"
  default_route_table_id = "rtb-0b4fc959115e7226c"
  subnet_1a_id           = "subnet-06c734859e20adec2"
  internet_gateway_id    = "igw-0365ad552bcdc8cb8"
}
