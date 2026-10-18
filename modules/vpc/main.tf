module "this" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.21"

  name = "${var.name}-vpc"
  cidr = var.cidr
  azs  = var.azs

  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets

  create_database_subnet_group = true

  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true

  # Required for AWS Load Balancer Controller subnet discovery
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
