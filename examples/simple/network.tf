locals {

  ## EKS VPC and Subnet tagging requirement
  ## https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
  vpc_tags            = map(format("kubernetes.io/cluster/%s", var.eks_cluster_name), "shared")
  public_subnet_tags  = map(format("kubernetes.io/cluster/%s", var.eks_cluster_name), "shared")
  private_subnet_tags = map(format("kubernetes.io/cluster/%s", var.eks_cluster_name), "shared")

}

# Declare the data source
data "aws_availability_zones" "availability_zones" {
  state = "available"
}

## Create VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.9.0"

  name = "simple-cluster"
  cidr = "10.0.0.0/16"

  vpc_tags = local.vpc_tags

  azs = data.aws_availability_zones.availability_zones.names

  public_subnets = [
    "10.0.0.0/20",
    "10.0.16.0/20",
    "10.0.32.0/20"
  ]

  private_subnets = [
    "10.0.48.0/20",
    "10.0.64.0/20",
    "10.0.80.0/20"
  ]

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true

  public_subnet_tags = local.public_subnet_tags

  tags = var.default_tags
}

locals {
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
}