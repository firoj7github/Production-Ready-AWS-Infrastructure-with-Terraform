variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_subnet_group_name" {
  type = string
}

variable "allowed_security_group" {
  description = "Security group allowed to connect (EKS nodes)"
  type        = string
}

variable "db_name" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}
