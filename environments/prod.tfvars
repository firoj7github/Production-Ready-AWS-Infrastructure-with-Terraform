project     = "myapp" # change to your project name
environment = "prod"

# ─── VPC ───
vpc_cidr           = "10.30.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b"]
private_subnets    = ["10.30.0.0/20", "10.30.16.0/20"]  # nodes + pods (~4,000 IPs each)
public_subnets     = ["10.30.48.0/24", "10.30.49.0/24"] # NAT + load balancers
database_subnets   = ["10.30.56.0/24", "10.30.57.0/24"] # RDS
single_nat_gateway = false                              # one NAT per AZ, no single point of failure

# ─── EKS ───
kubernetes_version      = "1.34"
eks_public_access_cidrs = ["CHANGE-ME/32"] # your office / VPN IP, e.g. "203.0.113.10/32"
node_instance_types     = ["t3.medium"]
node_capacity_type      = "ON_DEMAND"
node_min_size           = 2
node_max_size           = 4
node_desired_size       = 2

# ─── ECR ───
ecr_repositories = ["app", "nginx"]
ecr_force_delete = false

# ─── RDS ───
db_name                = "app"
db_instance_class      = "db.t4g.small"
db_multi_az            = true
db_deletion_protection = true
