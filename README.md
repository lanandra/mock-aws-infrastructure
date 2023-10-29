# mock-aws-infrastructure

## Overview

This repository consist of mock Infrasture as Code (IaC) of AWS environment. Currently IaC tool used in this repository is Terraform.

## Directory Structure

Directory structure in this repository is divided by environment name, service name, region name and then terraform files will be under the region directory. But if in any case the service is global service, then terraform files will be under service name.

```
.
└── environment-name/
    ├── regional-service-name/
    │   └── region-name/
    │       └── file.tf
    └── global-service-name/
        └── file.tf
```

For example:

```
.
└── sandbox2/
    ├── vpc/
    │   └── ap-southeast-1/
    │       └── file.tf
    └── iam/
        └── file.tf
```

In case the environment has resources that used S3 as a backend, there is a directory that specified to define needed resources for backend, for example s3 to storing terraform state and dynamo db for terraform locks.

For example:

```
.
└── sandbox2/
    └── tf-backend/
        └── file.tf
```

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


## Example

I created some blogpost which contain example of usage about codes in this repository. Please check examples directory and you will find link to blogpost
