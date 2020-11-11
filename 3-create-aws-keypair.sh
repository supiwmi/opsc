#!/bin/bash
#
# This script will:
#
#
# Note:
#     you can check aws region wiht this commmand:
#     $ aws ec2 describe-regions --query 'Regions[].RegionName'
#
#
# Next, import the SSH public key to these regions, substituting your key’s name for <MyKey>:
# $ for each in ${AWS_REGION} ; do aws ec2 import-key-pair --key-name <MyKey> --public-key-material file://~/.ssh/aws.pub --region each ; done
#
# Also, if you want to display which SSH key is available in a region:
# $ aws ec2 describe-key-pairs --region ap-southeast-1
#
# To delete an SSH key from a region:
# $ aws ec2 delete-key-pair --key-name <MyKey> --region ap-southeast-1
#

mkdir -p ~/.secrets
KEYPATH=".secrets"
KEYNAME="deploy-aws"
openssl genrsa -out "$KEYPATH/aws.pem" 4096
ssh-keygen -y -f "$KEYPATH/aws.pem"  > "$KEYPATH/aws.pub"

#openssl rsa -in "$KEYPATH/aws.pem" -pubout > "$KEYPATH/aws.pub"
chmod 400 "$KEYPATH/aws.pem"


cp $KEYPATH/aws.pem $HOME/.ssh/$KEYNAME.pem
cp $KEYPATH/aws.pub $HOME/.ssh/$KEYNAME.pub

chmod -R 400 ~/.ssh/

aws ec2 import-key-pair --region ap-southeast-1 --key-name $KEYNAME --public-key-material fileb://~/.ssh/$KEYNAME.pub

#aws ec2 describe-key-pairs --region ap-southeast-1
#aws ec2 delete-key-pair --key-name deploy-aws
