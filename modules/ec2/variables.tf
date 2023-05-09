variable "name" {
  type        = string
  description = "name of the installation"
}

variable "subnet_id" {
  type        = any
  description = "subnet id where the ec2 instance will be provisioned"
}

variable "security_groups_ids" {
  type        = list(string)
  description = "security groups for the ec2 instance"
}