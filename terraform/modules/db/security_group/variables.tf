variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "backend_api_sg_id" {
  type    = string
  default = ""
}
