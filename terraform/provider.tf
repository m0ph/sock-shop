provider "aws" {
  region = local.region
}

locals {
  name   = "sock-shop-cluster"
  region = "eu-west-3"

  vpc_cidr = "10.0.0.0/16"
  azs      = ["eu-west-3a", "eu-west-3b"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  intra_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]

  tags = {
    Example = local.name
  }
}