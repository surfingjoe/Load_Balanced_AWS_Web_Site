variable "instances_per_subnet" {
  description = "Number of EC2 instances in each private subnet"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Type of EC2 instance to use"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "User selects environment"
  type = string
  default = "Test"
}

variable "key" {
  type    = string
}

variable "your_name" {
  description = "Your Name?"
  type        = string
}

variable "ssh_location" {
  type        = string
  description = "My Public IP Address"
}

variable "controller_sg" {
  type = string
}

variable "lb_sg" {
  type = string
}