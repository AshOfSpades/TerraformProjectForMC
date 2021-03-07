variable "ami_id" {
  type        = string
  description = "AMI ID for webservers"
}

variable "instance_type" {
  type        = string
  description = "The size of instance to launch"
}

variable "web_sg_id" {
  type        = string
  description = "Security group ID for webservers"
}

variable "subnet_webservers" {
  type        = list(string)
  description = "A list of subnet IDs to launch resources in"
}

variable "vpc_id" {
  type        = string
  description = "VPC id where the load balancer and other resources will be deployed"
}

variable "subnet_loadbalancer" {
  type        = list(string)
  description = "A list of subnets to associate with the load balancer"
}

variable "lb_sg_id" {
  type        = string
  description = "The security groups to attach to the load balancer"
}

variable "efs_id" {
  type        = string
  description = "ID of EFS to mount on webservers"
}

variable "jumpbox_subnet" {
  type        = string
  description = "Subnet ID for jumpbox instance"
}

variable "jumpbox_sg" {
  type        = string
  description = "Security group ID for jumpbox instance"
}

variable "password" {
  type        = string
  description = "Password for authentication"
}