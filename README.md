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
