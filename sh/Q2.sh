#!/bin/bash -e

NAME_TAG=$1
TAG_VALUE=$2
ssh ec2-user@$(aws ec2 describe-instances --filters "Name=tag:${NAME_TAG},Values=${TAG_VALUE}" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text)
