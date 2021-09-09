terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "S3 Bucket Name"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" { }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  cidr            = var.vpc_cidr_block
  azs             = data.aws_availability_zones.available.names
  private_subnets = slice(var.private_subnet_cidr_blocks, 0, 2)
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, 2)
  #database_subnets= slice(var.database_subnet_cidr_blocks, 0, 2)
  enable_dns_support = true
  enable_nat_gateway = true
  #enable_vpn_gateway = false
  single_nat_gateway = true
    tags = {
    Name          = "${var.environment}-VPC"
    Stage         = "${var.environment}"
    Owner         = "${var.your_name}"
  }
}