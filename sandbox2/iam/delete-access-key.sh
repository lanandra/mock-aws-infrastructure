#!/usr/bin/env bash

set -euo pipefail

IAM_USER=$IAM_USER

ACCESS_KEY=$(aws iam list-access-keys \
  --user-name $IAM_USER \
  --query 'AccessKeyMetadata[].AccessKeyId' \
  --output text \
  --no-cli-pager)

if [ -z "$ACCESS_KEY" ]; then
  echo "No access key found on user $IAM_USER"
else  
  echo "Found access key $ACCESS_KEY on user $IAM_USER"

  DELETE_KEY=$(aws iam delete-access-key \
    --user-name $IAM_USER \
    --access-key-id $ACCESS_KEY)

  echo "Access key $ACCESS_KEY deleted"
fi
