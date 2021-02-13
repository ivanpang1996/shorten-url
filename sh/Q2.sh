#!/bin/bash -e

NAME_TAG=$1

ssh ec2-user@$(aws ec2 describe-instances --filters "Name=tag:${NAME_TAG},Values=" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text)
