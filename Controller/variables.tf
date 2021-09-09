variable "key" {
  type    = string
  default = "EC2 key pair name"  #be sure to update with the name of your EC2 Key pair for your region
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
variable "your_name" {
  description = "Your Name?"
  type = string
  default = "Your Name"
}