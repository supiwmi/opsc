#!/bin/bash
#
# This script will
#   1. Install Ansible
#   2. Install common software for Linux
#   3. Install python-pip python-boto and python-boto3 for aws
#   4. Upgrade python-pip to the latest version
#   5. Install awscli using pip install command
#   6. Install Terrafrom (down load zipped binary and place in to /usr/local/bin)
#
# Note that this script is for RHEL/Centos/Fedora Linux only
#      - At the time of writing Ansible was at version 2.9.7
#      - At the time of writing AWS CLI was at version 2.0.10
#      - At the time of writing Terraform was at version 0.12.24
#      - At the bottom of scripts there are some optional command with the comment

yum update
yum install -y unzip wget git tree
yum install -y ansible
yum install -y software-properties-common
yum install -y python-pip python-boto python-boto3
pip install --upgrade pip
pip install awscli --upgrade

echo ">>>>>>>>>>>>>> AWS CLI version 2  <<<<<<<<<<<<<<<<<<"

#----  >>>Option 1<<<< - Installing from Downloaded Files
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

##---- Upgrading
## which aws
## you shoud see output like this ---> /usr/local/bin/aws
## ls -l /usr/local/bin/aws
## you shoud see output like this ---> lrwxrwxrwx 1 ec2-user ec2-user 49 Oct 22 09:49 /usr/local/bin/aws -> /usr/local/aws-cli/v2/current/bin/aws
## sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
##---- Uninstalling the AWS CLI
## sudo rm /usr/local/bin/aws
## sudo rm /usr/local/bin/aws2_completer
## sudo rm -rf /usr/local/aws-cli
#
##----  >>>Option 2<<< - Installing from pip command
## pip3 install awscli --upgrade --user
## aws --version
## pip3 list -o
## pip3 install --upgrade --user awscli
#
##---- Uninstalling the AWS CLI
## pip3 uninstall awscli

echo ">>>>>>>>>>>>>> Install Terraform <<<<<<<<<<<<<<<<<<"

# download terraform with curl

#curl -O https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
#mkdir /bin/terraform
#unzip -f terraform_0.12.24_linux_amd64.zip -d /bin/terraform
#unzip -f terraform_0.12.24_linux_amd64.zip -d /usr/local/bin
#export PATH=$PATH:/bin/terraform

# download terraform with wget

wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip
mv terraform /usr/local/bin/
chown -R root:root /usr/local/bin/terraform
rm -rf terraform_0.12.24_linux_amd64*

# Customize Ansible Configuration e.g. add localhost to inventory, add ansible to visudo, disable host_key_checking

echo "localhost"  | tee -a /etc/ansible/hosts >/dev/null
# Remark:Disable host_key_checking in /etc/ansible/ansible.cfg to prevent to first login to aws ec2
sed -i 's/#host_key_checking = False/host_key_checking = False/g' /etc/ansible/ansible.cfg
bash create_ansible_user.sh
echo "ansible        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# checking install software verion

echo "----------------------------------------------------------------------------------------------------------------"
echo "--------------------- Software Setup Complete, please check the installed software -----------------------------"
echo "----------------------------------------------------------------------------------------------------------------"
ansible  --version
aws --version
terraform --version
echo "----------------------------------------------------------------------------------------------------------------"

# **************************************************
# *****************   Optional  ********************
# **************************************************
#hostnamectl set-hostname terransible-centos
#exec $SHELL

