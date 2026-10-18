module "this" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.37"

  cluster_name    = "${var.name}-cluster"
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.public_access_cidrs

  # Without this, the IAM identity that creates the cluster cannot use kubectl
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = { before_compute = true }
    eks-pod-identity-agent = { before_compute = true }
  }

  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2023_x86_64_STANDARD" # AL2 is not supported on Kubernetes 1.33+
      instance_types = var.node_instance_types
      capacity_type  = var.node_capacity_type

      min_size     = var.node_min_size
      max_size     = var.node_max_size
      desired_size = var.node_desired_size
    }
  }
}
