variable "subnet1_id" {
  type        = string
  description = "Subnet ID for efs mount 1"
}
variable "efs-mt1-sg" {
  type        = string
  description = "Security group ID for efs mount 1"
}
variable "subnet2_id" {
  type        = string
  description = "Subnet ID for efs mount 2"
}
variable "efs-mt2-sg" {
  type        = string
  description = "Security group ID for efs mount 2"
}
variable "subnet3_id" {
  type        = string
  description = "Subnet ID for efs mount 3"
}
variable "efs-mt3-sg" {
  type        = string
  description = "Security group ID for efs mount 3"
}