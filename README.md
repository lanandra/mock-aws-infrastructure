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

Note: 
- You may see directory structure that does not follow pattern above. That being used by legacy pattern and haven't been changed and updated
- No solid plan when old pattern will be updated. Sorry :pray:

## Terraform Configuration

Terraform configuration in this repository is using Terraform Cloud and S3 as a backend. You can differentiate each backend by refer this configuration.

For example:

- Terraform Cloud
    ```
    terraform {
      backend "remote" {
        hostname     = "app.terraform.io"
        organization = "my-organization"

        workspaces {
          name = "my-workspace"
        }
      }
    }
    ```

- S3
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
