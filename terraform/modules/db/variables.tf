variable "project" {}
variable "environment" {}
variable "region" {}

variable "vpc_id" {}
variable "private_subnet_id" {}

variable "key_name" {}

variable "redis_instance_type" {
  default = "t3.micro"
}

variable "postgres_instance_type" {
  default = "t3.small"
}

variable "scylla_instance_type" {
  default = "t3.large"
}

variable "ami_id" {}

variable "domain_name" {}