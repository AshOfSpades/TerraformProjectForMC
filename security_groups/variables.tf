variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create security group"
}

variable "lb_ingress" {
  type        = list(string)
  description = "Public CIDR range"
}