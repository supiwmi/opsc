# opsc - How to run jenkins with container

<mark>Step 1:</mark>
Create a new volume on docker host to keep jenkins configurations

> mkdir ~/myJenkinsVolume

<mark>Step 2:</mark>
Run jenkins container in detached mode

> docker run -d -p 8080:8080 -p 50000:50000 --restart=always --name devopsjenkins  -v ~/myJenkinsVolume:/var/jenkins_home -t -u root jenkins

<mark>Step 3:</mark>
Navigate to your Web Browser 
