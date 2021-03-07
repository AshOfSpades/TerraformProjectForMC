#Variable definition

variable "aws_region" {
  type        = string
  description = "AWS region where all resources are going to be provisioned"
  default     = "eu-west-1"
}

variable "aws_cred_file_path" {
  description = "AWS credentials or configuration file to specify your credentials"
  default     = "%USERPROFILE%\\.aws\\credentials"
}

variable "instance_type" {
  type        = string
  description = "AWS EC2 instance type for web servers"
  default     = "t2.micro"
}

variable "lb_ingress" {
  type        = list(string)
  description = "Public CIDR range"
  default     = ["0.0.0.0/0"]
}

variable "password" {
  type        = string
  description = "Password for userlogin to webservers. This MUST NOT BE hardcoded in code, rather should be fetched from a secret store like Hashicorp Vault or AWS Secret manager."
  default     = "password123"
}