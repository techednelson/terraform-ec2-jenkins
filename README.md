# terraform-ec2-jenkins

![jenkins.png](images%2Fjenkins.png)

This repository uses terraform to provision an ec2 instance on aws, installing only on the first boot  jenkins along with docker, git y maven. Once the instance is up you only need to follow a few simple steps once and start creating CI/CD pipelines.

If you are inside the AWS free tier, you can run this project practically for free, just remember to stop your instance once you are done with your tests to avoid bill surprises. next time you restart the instance, it will still have your previous configuration.

## Pre requisites

- aws account https://repost.aws/knowledge-center/create-and-activate-aws-account
- IAM user credentials configure with `aws configure` command https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
- Install aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Run the project

- `terraform init`
- `terraform apply` or `terraform apply -auto-approve`

## Setup Jenkins

- Once terraform apply has ended run `terraform state show module.ec2.aws_instance.ec2` and look for public_ip value.
- Open in the web browser `http://<public_ip>:8080` note: replace public_ip for the value found in the step before.
- Once the jenkins ui appears, got to aws console and connect to the ec2 instance via `ec2 connect` to access from the web browser https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect.html
- Once you are inside the ec2 instance run `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` to get the admin password and type it on the web ui.
- Create a new Jenkins user.
- install recommended plugins & you are ready to start using jenkins and create pipelines.
- (Optional) Inside module ec2, there is a bash script with a list of useful plugins to install:
  - performance@3.18
  - docker-workflow@1.26
  - dependency-check-jenkins-plugin@5.1.1
  - blueocean@1.24.7
  - jacoco@3.2.0
  - slack@2.4.8
  - sonar@2.13.1
  - pitmutation@1.0-18
  - ec2@2.0.7
  - docker-plugin@1.3.0
  - github-pullrequest@0.5.0
  - parameterized-trigger@2.45
  - kubernetes-cli@1.12.0

If you still have the `ec2 connect` browser window to access via command line to the ec2 instance do the following:
 - Run `vi plugins-installer.sh` + `i` key in keyboard & replace admin:admin for your just created `username:password` in lines 7, 9 and admin for your `username` in line 19 and save changes with `esc` + `:wq` + `Enter`.
 - Run `sh plugins-installer.sh`.
 - Run `sudo systemctl restart jenkins`.
 - Run wait a few seconds until you can run `sudo systemctl status jenkins`. Jenkins should be active & running.
 - Refresh the web browser `http://<public_ip>:8080` & enter again your username and password, you should see under Manage Jenkins > Plugin Manager > Installed Plugins, the list of plugins installed from `plugins.txt `

## Important Note
Everytime you stop & start the ec2 instance you need to run from ec2 connect or ssh form your local pc the command `sudo chmod 666 /var/run/docker.sock` to avoid issues with docker

Happy CI/CD pipelines!!!

