variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "ap-southeast-1"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN"
  default     = "arn:aws:iam::12digitsawsid:role/compute-admin-sbx"
}

variable "az" {
  type        = list(string)
  description = "AWS Availability Zone"
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "key_pair_name" {
  type        = string
  description = "Name of Lightsail key pair"
  default     = "my-key-pair"
}
