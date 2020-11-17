#!/bin/bash

sudo apt update
### Step 1 — Installing Java (prerequisite)

sudo apt install openjdk-8-jdk openjdk-8-jre

sudo cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
EOL

java -version

### Step 2 — Installing Jenkins

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt install jenkins

### Step 3 — Starting Jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

### Step 4 — Setting Up Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "Navigate to Web Broswer http://your_server_ip_or_domain:8080"
