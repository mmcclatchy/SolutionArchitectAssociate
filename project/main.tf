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
  common_tags = { for tuple in regexall("([A-Z_]*)='?([^']*)", file("~/aws/saa/.env")) : tuple[0] => tuple[1] }
}
