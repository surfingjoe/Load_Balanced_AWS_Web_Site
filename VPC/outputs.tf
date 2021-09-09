output "aws_region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}

output "vpc_id" {
  description = "Output VPC ID"
  value       = module.vpc.vpc_id
}


output "Controller-sg_id" {
  description = "Security group IDs for Controller"
  value       = [aws_security_group.controller-ssh.id]
}

output "lb_security_group_id" {
  description = "Security group IDs for load balancer"
  value       = [aws_security_group.lb-sg.id]
}


output "elb_web-sg_id" {
  description = "Security group IDs for elb-Web servers"
  value       = [aws_security_group.elb_web_sg.id]
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}
