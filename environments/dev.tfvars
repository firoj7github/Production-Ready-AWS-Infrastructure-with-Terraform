project     = "myapp" # change to your project name
environment = "dev"

# ─── VPC ───
vpc_cidr           = "10.10.0.0/16"
azs                = ["ap-south-1a", "ap-south-1b"]
private_subnets    = ["10.10.0.0/20", "10.10.16.0/20"]  # nodes + pods (~4,000 IPs each)
public_subnets     = ["10.10.48.0/24", "10.10.49.0/24"] # NAT + load balancers
database_subnets   = ["10.10.56.0/24", "10.10.57.0/24"] # RDS
single_nat_gateway = true

# ─── EKS ───
kubernetes_version  = "1.34"
node_instance_types = ["t3.medium", "t3a.medium"]
node_capacity_type  = "SPOT" # ~60-70% cheaper, fine for dev
node_min_size       = 2
node_max_size       = 3
node_desired_size   = 2

# ─── ECR ───
ecr_repositories = ["app", "nginx"]
ecr_force_delete = true

# ─── RDS ───
db_name                = "app"
db_instance_class      = "db.t4g.micro"
db_multi_az            = false
db_deletion_protection = false # dev only; set true for prod
