#!/bin/bash

sudo apt update
### Step 1 — Installing Java (prerequisite)

sudo apt install -y openjdk-8-jdk openjdk-8-jre

sudo cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
EOL

java -version

### Step 2 — Installing Jenkins

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y


### Step 3 — Starting Jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins
#sudo systemctl status jenkins

### Step 4 — Setting Up Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Navigate to Web Broswer http://xxxxxxx.southeastasia.cloudapp.azure.com:8080"
