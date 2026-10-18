# ─── General ───────────────────────────────────────────────────────────
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "project" {
  description = "Project name, used as a prefix for every resource (e.g. myapp-dev-cluster)"
  type        = string
}

variable "environment" {
  type = string
}

# ─── VPC ───────────────────────────────────────────────────────────────
variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "database_subnets" {
  type = list(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

# ─── EKS ───────────────────────────────────────────────────────────────
variable "kubernetes_version" {
  type = string
}

variable "eks_public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "node_instance_types" {
  type = list(string)
}

variable "node_capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"
}

variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "node_desired_size" {
  type = number
}

# ─── ECR ───────────────────────────────────────────────────────────────
variable "ecr_repositories" {
  type = list(string)
}

variable "ecr_force_delete" {
  type    = bool
  default = false
}

# ─── RDS ───────────────────────────────────────────────────────────────
variable "db_name" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_deletion_protection" {
  type    = bool
  default = true
}
