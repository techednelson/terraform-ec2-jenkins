data "aws_availability_zones" "available" {}

locals {
  name     = "testing-environment"
  region   = "eu-central-1"
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 1)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.name}-vpc"
  cidr = "10.0.0.0/16"

  azs            = local.azs
  public_subnets = ["10.0.101.0/24"]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  tags = {
    Name        = "${local.name}-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "security_groups" {
  source = "./modules/security-groups"
  name   = local.name
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source              = "./modules/ec2"
  name                = local.name
  security_groups_ids = [module.security_groups.ec2_ssh_sg.id, module.security_groups.ec2_web_sg.id]
  subnet_id           = module.vpc.public_subnets[0]
}
