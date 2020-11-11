#!/bin/bash

touch ~/.aws/credentials
touch ~/.aws/config
cat /root/helper/.sensitive/credentials  >  ~/.aws/credentials
cat /root/helper/.sensitive/config  >  ~/.aws/config

aws sts get-caller-identity
aws ec2 describe-instances

