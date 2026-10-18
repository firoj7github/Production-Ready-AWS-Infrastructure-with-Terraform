variable "name" {
  type = string
}

variable "repositories" {
  type = list(string)
}

variable "force_delete" {
  type = bool
}
