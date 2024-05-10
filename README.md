# mock-aws-infrastructure

## Overview

This repository consist of mock Infrasture as Code (IaC) of AWS environment. Currently IaC tool used in this repository is Terraform.

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
