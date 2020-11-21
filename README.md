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


# PUSH EXISTING REPO FROM THE COMMAND LINE

git remote add origin https://github.com/your_username/your_new_repository_name.git

git branch -M master

git push -u origin master

เป็นการทำให้มีการ sync กันระหว่าง remote และ local

git push -u --set-upstream origin master

ลองแก้ไขไฟล์ README.md

แล้วสั่ง
git add .
git commit -m "second"

เราก็สามารถสั่งแค่ push ก็พอแล้ว
git push

ดูเพิ่มเติม
https://docs.github.com/en/free-pro-team@latest/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line
