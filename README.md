# mock-aws-infrastructure

## Overview

This repository consist of mock Infrasture as Code (IaC) of AWS environment. Currently IaC tool used in this repository is Terraform.

## Directory Structure

Directory structure in this repository is divided by environment name, service name, region name and then terraform files will be under the region directory. But if in any case the service is global service, then terraform files will be under service name.

For example:

```
.
└── environment-name/
    ├── regional-service-name/
    │   └── region-name/
    │       └── file.tf
    └── global-service-name/
        └── file.tf
```

## Terraform Configuration

Terraform configuration in this repository is using Terraform Cloud as a backend

## Example

I created some blogpost which contain example of usage about codes in this repository. Please check examples directory and you will find link to blogpost
