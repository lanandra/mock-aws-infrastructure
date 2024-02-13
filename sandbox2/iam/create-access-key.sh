#!/usr/bin/env bash

set -euo pipefail

IAM_USER=$IAM_USER

CREATE_KEY=$(aws iam create-access-key \
  --user-name $IAM_USER\
  --output text)

echo "Creating access key for user $IAM_USER"
echo "$CREATE_KEY" > ./access-key.csv
echo "Access key created. Please find the key values on access-key.csv"
