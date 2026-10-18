output "endpoint" {
  value = module.this.db_instance_address
}

output "password_secret_arn" {
  value = module.this.db_instance_master_user_secret_arn
}
