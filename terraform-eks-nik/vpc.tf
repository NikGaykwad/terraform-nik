data "aws_availability_zones" "available" {
  
}

locals {
  cluster_name = var.cluster_name
  vpc_name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name

  azs = local.azs
  cidr = local.cidr
  private_subnets = local.private_subnets
  public_subnets = local.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true


tags = {
    Name = "eks-vpc"
  }
}