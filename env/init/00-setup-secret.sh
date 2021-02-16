#!/bin/bash -e

DB_USER=""
DB_PASSWORD=""
DB_URL=""

aws configure
aws ssm put-parameter --name DB_USER --value $DB_USER --type String
aws ssm put-parameter --name DB_PASSWORD --value $DB_PASSWORD --type String
aws ssm put-parameter --name DB_URL --value $DB_URL --type String
