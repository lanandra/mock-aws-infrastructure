variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "my-region-code"
}

variable "waiting_deletion_period" {
  type        = number
  description = "Waiting period in days before secret deleted. Set to 0 for force destroy"
  default     = 0
}

variable "my_machine_credentials" {
  type        = map(string)
  description = "Key value pairs consist of AWS credentials used by my machine user"
  default = {
    "AWS_ACCESS_KEY_ID"     = "AKIAWE1AB2CD34FG5I767"
    "AWS_SECRET_ACCESS_KEY" = "change_me"
  }
}
