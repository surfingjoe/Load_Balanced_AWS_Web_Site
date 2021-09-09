terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# ------------- Configure the S3 backend for Terraform State -----------
data "terraform_remote_state" "vpc" {
  backend = "s3" 
  config = {
    bucket = "surfingjoes-terraform-states"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {

  region = data.terraform_remote_state.vpc.outputs.aws_region
}

resource "random_string" "lb_id" {
  length  = 3
  special = false
}

module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "3.0.0"

  # Ensure load balancer name is unique
  name = "lb-${random_string.lb_id.result}-${var.environment}-lb"

  internal = false

  security_groups = data.terraform_remote_state.vpc.outputs.lb_security_group_id
  subnets         = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  number_of_instances = length(aws_instance.app)
  instances           = aws_instance.app.*.id

  listener = [{
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }]

  health_check = {
    target              = "HTTP:80/index.html"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
  }
}

resource "aws_instance" "app" {
  ami = "ami-045428be34c3889f0"  # Private AMI (you will need to create your own Static Website Server and create the image as an AMI)
  count = var.instances_per_subnet * length(data.terraform_remote_state.vpc.outputs.private_subnet_ids)
  instance_type = var.instance_type
  key_name               = var.key
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[count.index % length(data.terraform_remote_state.vpc.outputs.private_subnet_ids)]
  vpc_security_group_ids = data.terraform_remote_state.vpc.outputs.elb_web-sg_id
  tags = {
    Name          = "${var.environment}-Static_Web_Server"
    Stage         = "${var.environment}"
    Owner         = "${var.your_name}"
  }
}

output "lb_url" {
  description = "URL of load balancer"
  value       = "http://${module.elb_http.elb_dns_name}/"
}

output "web_instance_count" {
  description = "Number of EC2 instances"
  value       = length(aws_instance.app)
}