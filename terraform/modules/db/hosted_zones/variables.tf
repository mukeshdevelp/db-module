variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "domain_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "redis_ip" {
  type = string
}

variable "postgres_ip" {
  type = string
}

variable "scylla_ip" {
  type = string
}
