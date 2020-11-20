#!/bin/bash

# This command will create jenkins user, specify the bash shell, and assing sudo group 
sudo useradd -s /bin/bash -m -G sudo jenkins


# This 3 commands will update the software on and install some tools e.g. curl, openssh-server and etc.
sudo apt update
sudo apt upgrade -y
sudo apt install curl openssh-server ca-certificates postfix -y

# This commaind will import gitlab repository to this server
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash


# Now we can install gitlab software on this server
sudo apt install gitlab-ce -y

# The command set below will generate the private key for our certificate using self-signed certificate
openssl genrsa -out key.pem 4096
openssl req -new -sha256 -key key.pem -out csr.csr
openssl req -x509 -sha256 -days 365 -key key.pem -in csr.csr -out certificate.pem
mkdir /etc/gitlab/ssl
chmod 700 /etc/gitlab/ssl
cp *.pem /etc/gitlab/ssl 

# This command will backup the original configuration file before changing
sudo cp /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.original


# This command will change the 'external_url' value with your own domain name.
# see http://netjunky.net/sed-replace-path-with-slash-separators/
sudo sed -i "s|external_url 'http://gitlab.example.com' *|external_url 'https://gitlabdocker.southeastasia.cloudapp.azure.com'|" /etc/gitlab/gitlab.rb


echo -e "nginx['ssl_certificate'] = "/etc/gitlab/ssl/certificate.pem" " | sudo tee -a /etc/gitlab/gitlab.rb
echo -e "nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/key.pem" " | sudo tee -a /etc/gitlab/gitlab.rb


# The command set below will reconigure the gitlab and start gitlab server  
gitlab-ctl reconfigure
gitlab-rake gitlab:env:info
gitlab-ctl start unicorn
gitlab-ctl start sidekiq
gitlab-ctl status
gitlab-ctl start

# The command below will check gitlab software
sudo apt-cache policy gitlab-ce | grep Installed
