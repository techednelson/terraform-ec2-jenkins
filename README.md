# terraform-ec2-jenkins

This repository uses terraform to provision an ec2 instance on aws
and bootstrap on the instance user data jenkins along with docker
and git ready to set up and start creating CI/CD pipelines.

## Pre requisites

- aws account https://repost.aws/knowledge-center/create-and-activate-aws-account
- IAM user credentials configure with `aws configure` command https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
- Install aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Run the project

- `terraform init`
- `terraform apply` or `terraform apply -auto-approve`

## Setup Jenkins

- Once terraform apply has ended run `terraform state show module.ec2.aws_instance.ec2` and look for public_ip value
- Open in the web browser http://<public_ip>:8080 note: replace public_ip for the value found in the step before
- Once the jenkins ui appears, got to aws console and connect to the ec2 instance via ec2 connect to access from the web browser https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect.html
- Once you are inside the ec2 instance run `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` to get the admin password and type it on the web ui
- Create a new Jenkins user
- install recommended plugins & you are ready to start using jenkins and create pipelines

