#!/bin/bash -e

NAME_TAG=$1

ip=$(aws ec2 describe-instances --filters "Name=tag:${NAME_TAG},Values=" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text)
if [ -z "${ip}" ]
then
  echo "Host not found"
else
  echo ssh ec2-user@"${ip}"
fi

