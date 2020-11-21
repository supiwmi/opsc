# opsc - How to run jenkins with container gitty
# https://tpit-band-live.web.app/

# *Step 1:*

Create a new volume on docker host to keep jenkins configurations

> mkdir ~/myJenkinsVolume

# *Step 2:*

Run jenkins container in detached mode

> docker run -d -p 8888:8080 -p 50000:50000 --restart=always --name devopsjenkins  -v ~/myJenkinsVolume:/var/jenkins_home -t -u root jenkins

# *Step 3:*

Navigate to your Web Browser 

http://your_server_ip_or_domain:8888
