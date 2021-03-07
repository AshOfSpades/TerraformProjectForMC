![enter image description here](https://www.datocms-assets.com/2885/1506457071-blog-terraform-list.svg)

# **MC - Take Home Assignment**

This repository holds the code for the 'take home assignment' project,
The terraform project deploys a web application and creates following resources -
- Load balancer with an autoscaling group
- Elasctic file system
- VPC along with private and public subnets


## Requirements
Name | Version
---------|-------
Terraform | v0.12 or above
AWS Provider	| v2.42 or above

## Design requirments
Using Terraform V12, build a module meant to deploy a web application that supports the following design:

- It must include a VPC which enables future growth / scale

- It must include both a public and private subnet – where the private subnet is used for compute and the public is used for the load balancers

- Assuming that the end-users only contact the load balancers and the underlying instance are accessed for management purposes, design a security group scheme which supports the minimal set of ports required for communication.

- The AWS generated load balancer hostname with be used for request to the public facing web application.

- An autoscaling group should be created which utilizes the latest AWS AMI

- The instance in the ASG

	 - Must contain both a root volume to store the application / services

	- Must contain a secondary volume meant to store any log data bound from / var/log

	- Must include a web server of your choice.

- All requirements in this task of configuring the operating system should be defined in the launch configuration and/or the user data script (no external config tools like chef, puppet, etc)
- Your module should not be tightly coupled to your AWS account – it should be designed to that it can be deployed to any arbitrary AWS account



## How to use this code

Follow the below instructiosn to deploy infrastructure using this code:

- Clone the code using following:
 `git clone https://github.com/AshOfSpades/TerraformProjects.git`
- Make sure you have installed AWS CLI on your PC. If not, download from the following link:
    https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html
- Configure AWS credentials by opening cmd and running following command:
 `aws configure`
 - Code uses AWS cred file so make sure you have AWS cred file stored in following windows path:
  `%USERPROFILE%\.aws\credentials`
  - Open CMD, go to the path where the main.tf file is stored and run following command to initialise and download Terraform module and plugins
   `terraform init`
   - Run following commands to see the deployment plan and to deploy infrastructure respectively
    `terraform plan` (Verify the plan)
    `terraform apply` (Enter yes when asked whether to deploy or not)

## Code directory structure
![enter image description here](https://i.imgur.com/mQK62pp.jpg)

## Areas of improvement
- This code uses a hardcoded password which should be fetched from a credentials manager like Hashicord Vault or AWS secret manager
- A map can be used to bind the region and the AZs which is then can be fed to the module that creates vpc.
- Cloudwatch alarms can be created monitoring CPU utlisation, responses from the web server etc.
- Based of the cloudwatch alarms autoscaling policies can be set to increase and decrease the number of servers.
- AMI can be created to decrease the startup time of the webservers.
- At the moment userdata uses shell scripts however using something like cloud-init would be better.

## Changelog
Version | Comment
---------|-------
1.0 | Initial commit