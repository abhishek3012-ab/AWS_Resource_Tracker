#!/bin/bash

#################################################

# Author: Abhishek
# Date: 18/10/2026
#
# version: v1
#
# This script will report the AWS recource usage.

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

#################################################

set -exo pipefail

# list AWS S3 buckets
aws s3 ls

# list AWS EC2 instances
# aws ec2 describe-instances

# list AWS EC2 instanceIds
aws ec2 describe-instances | jq '.Reservations\[].Instances\[].InstanceId'

# list AWS lambda functions
aws lambda list-functions

# list AWS iam users
aws iam list-users
