variable "env_name" {
  type        = string
  description = "Name of sub environment"
  default     = "sbx0"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "public_subnet_id" {
  type        = list(string)
  description = "List of public subnet id in VPC"
}

variable "private_subnet_id" {
  type        = list(string)
  description = "List of private subnet id in VPC"
}

variable "default_route" {
  type        = string
  description = "All ipv4 from internet"
  default     = "0.0.0.0/0"
}

variable "egress_rules" {
  type        = list(string)
  description = "List of allowed rules for egress in security group"
}
