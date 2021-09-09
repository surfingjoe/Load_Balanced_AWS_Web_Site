# -------------- Security Group for bastion host -----------------------
resource "aws_security_group" "controller-ssh" {
  name        = "ssh"
  description = "allow SSH from MyIP"
  vpc_id      = module.vpc.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.ssh_location}"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
    Name          = "${var.environment}-Controller-SG"
    Stage         = "${var.environment}"
    Owner         = "${var.your_name}"
  }
}
# -------------- Security Group for ELB Web Servers -----------------------
resource "aws_security_group" "elb_web_sg" {
  name        = "${var.environment}-elb_web_sg"
  description = "allow SSH from Controller and HTTP from my IP"
  vpc_id      = module.vpc.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    security_groups  = ["${aws_security_group.controller-ssh.id}"]
    }
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.lb-sg.id}"]
    }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
    Name          = "${var.environment}-elb_web_sg"
    Stage         = "${var.environment}"
    Owner         = "${var.your_name}"
  }
}

# -------------- Security Group for Load Balancer -----------------------
resource "aws_security_group" "lb-sg" {
  name        = "${var.environment}-lb-SG"
  description = "allow HTTP and HTTPS"
  vpc_id      = module.vpc.vpc_id
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
    Name          = "${var.environment}-lb-SG"
    Stage         = "${var.environment}"
    Owner         = "${var.your_name}"
  }
}

