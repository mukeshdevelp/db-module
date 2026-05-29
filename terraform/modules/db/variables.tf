variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "region" {
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

variable "ami_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "backend_api_sg_id" {
  type    = string
  default = ""
}

