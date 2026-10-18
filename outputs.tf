output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "rds_password_secret_arn" {
  description = "Secrets Manager secret holding the DB master password"
  value       = module.rds.password_secret_arn
}
