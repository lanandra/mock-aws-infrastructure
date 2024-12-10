# change vpc and subnets id with value from your vpc
vpc_id = "vpc-055a349eb91b25d83"

public_subnet_id = [
  "subnet-0832dd01a6766fd2e", # az-a
  "subnet-0448963134d325228", # az-b
  "subnet-0ea225fc3a90c694a"  # az-c
]

private_subnet_id = [
  "subnet-00fed1d890859a3c6", # az-a
  "subnet-06fb732e6fedd392b", # az-b
  "subnet-0c9737f46355494c8", # az-c
]

egress_rules = ["all-all"]