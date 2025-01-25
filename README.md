# mock-aws-infrastructure

## Overview

This repository consist of mock Infrasture as Code (IaC) of AWS environment. Currently IaC tool used in this repository is Terraform.

## Directory Structure

Directory structure for Terraform codes in this repository is divided by environment name, sub-environment name and resources.

```
.
└── environment-name/
    └── sub-environment-name/
        └── resource-name/
            └── terraform-file.tf
```

Example:

```
.
└── sandbox/
    └── sbx0/
        └── vpc/
            ├── backend.tf
            ├── main.tf
            ├── terraform.tfvars
            └── variables.tf
```

## Terraform Configuration

Terraform configuration in this repository is using S3 as a backend

For example:

 ```
 terraform {
   backend "s3" {
     bucket         = "my-tfbucket"
     key            = "path/to/terraform.tfstate"
     region         = "ap-southeast-1"
     dynamodb_table = "my-tflocks"
     encrypt        = true
   }
 }
 ```

Terraform filenames more likely will follow Terraform configuration language style guide as referred to this [terraform style guide](https://developer.hashicorp.com/terraform/language/style). Although not really similar and have some adjustments in some of the files
