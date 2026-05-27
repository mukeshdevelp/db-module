variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "redis_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "postgres_instance_type" {
  type    = string
  default = "t3.small"
}

variable "scylla_instance_type" {
  type    = string
  default = "t3.large"
}

variable "redis_security_group_id" {
  type = string
}

variable "postgres_security_group_id" {
  type = string
}

variable "scylla_security_group_id" {
  type = string
}
