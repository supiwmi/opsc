# opsc - How to run jenkins with container

Pull jenkins image from docker hub


> docker run Jenkins


Create a new volume on docker host to keep jenkins configurations


> mkdir ~/myJenkinsVolume


Run jenkins container in detached mode


> docker run -d -p 8080:8080 -p 50000:50000 --restart=always --name devopsjenkins  -v ~/myJenkinsVolume:/var/jenkins_home -t -u root jenkins
