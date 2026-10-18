locals {
  name = "${var.project}-${var.environment}"
}

# ─── 1. VPC ────────────────────────────────────────────────────────────
module "vpc" {
  source = "./modules/vpc"

  name               = local.name
  cidr               = var.vpc_cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  database_subnets   = var.database_subnets
  single_nat_gateway = var.single_nat_gateway
}

# ─── 2. EKS (needs VPC) ────────────────────────────────────────────────
module "eks" {
  source = "./modules/eks"

  name                = local.name
  kubernetes_version  = var.kubernetes_version
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  public_access_cidrs = var.eks_public_access_cidrs
  node_instance_types = var.node_instance_types
  node_capacity_type  = var.node_capacity_type
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  node_desired_size   = var.node_desired_size
}

# ─── 3. ECR ────────────────────────────────────────────────────────────
module "ecr" {
  source = "./modules/ecr"

  name         = local.name
  repositories = var.ecr_repositories
  force_delete = var.ecr_force_delete
}

# ─── 4. RDS (needs VPC + EKS) ──────────────────────────────────────────
module "rds" {
  source = "./modules/rds"

  name                   = local.name
  vpc_id                 = module.vpc.vpc_id
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  allowed_security_group = module.eks.node_security_group_id
  db_name                = var.db_name
  instance_class         = var.db_instance_class
  multi_az               = var.db_multi_az
  deletion_protection    = var.db_deletion_protection
}
