variable "region" {}
variable "environment" {
  type = string
}

variable "application" {
  type = string
}

variable "owner" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "security_groups" {
  type = map(object({
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    tags = map(string)
  }))
}
