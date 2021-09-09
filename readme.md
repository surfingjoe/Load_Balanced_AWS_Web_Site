# Creating load balancer for static website

<img src="Load Balanced Static Websites.jpg">

## Features

- The ability to provision resources into AWS using "modular code."
- Using a community module to create the VPC, public and private subnets
- Four EC2 Web Servers behind a Classic load balancer
- Ability to launch or destroy bastion host (jump server) only when needed
  - Can add/remove controller at any time without impact to other resources
    Allows administrator access and operation only when required

## Requirements

- Must have an AWS account
- Install AWS CLI, Configure AWS CLI, Install Terraform
- AWS Administrator account or an account with the following permissions:
  - Privilege to create, read & write an S3 bucket
  - Privilege to create an IAM profile
  - Privilege to create VPC, subnets, and security groups
  - Privilege to create security groups
  - Privilege to create a load balancer, internet gateway, and NAT gateway
  - Privilege to create EC2 images and manage EC2 resources
- Ec2 Key Pair for the region
- Creation of an S3 Bucket to store backend Terraform State
- Create an EC2 Instance as a web server configured as a static website and save image as an AMI. 

## Infrastructure

<img src="Load Balanced Static Websites-infrastructure.png">

## Installation

1. Clone this repository

2. Be sure to change the S3 Bucket name in S3_policy.tf (lines 16 & 17)

3. Be sure to change the test.tfvars in the VPC folder, to variable (answers) of your choice

4. Be sure to change the test.tfvars in the ELB-WEB folder, to variable (answers) of your choice

5. Be sure to change main.tf lines 11-13 with the configuration for your S3 bucket to store terraform backend state

6. In your terminal, goto the VPC folder and execute the following commands:

   1. `Terraform init`
   2. `terraform validate`
   3. `Terraform apply -var-file=test.tfvars`

7. In your terminal goto the elb-web folder and execute the following commands:

   1. `Terraform init`
   2. `terraform validate`
   3. `Terraform apply -var-file=test.tfvars`

   **That's it, you have launched and should now have a load balanced static web site with resilience across availability zones and within each zone have at least two web servers for high availability** 



The jump server (I call it the controller) can be launched and/or destroyed at any time without impact to the load balancers or web servers.  If you want to launch the jump server, simply perform the following:

1. `Terraform init`
2. `terraform validate`
3. `Terraform apply`

