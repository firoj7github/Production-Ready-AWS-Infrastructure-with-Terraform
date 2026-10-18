output "vpc_id" {
  value = module.this.vpc_id
}

output "private_subnet_ids" {
  value = module.this.private_subnets
}

output "database_subnet_group_name" {
  value = module.this.database_subnet_group_name
}
