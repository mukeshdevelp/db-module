terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# --------------------------------------------------
# SECURITY GROUPS MODULE
# --------------------------------------------------

module "security_group" {
  source = "./security_group"

  project     = var.project
  environment = var.environment
  vpc_id      = var.vpc_id
  backend_api_sg_id = var.backend_api_sg_id
}

# --------------------------------------------------
# EC2 INSTANCES MODULE
# --------------------------------------------------

module "ec2" {
  source = "./ec2"

  project                    = var.project
  environment                = var.environment
  vpc_id                     = var.vpc_id
  private_subnet_id          = var.private_subnet_id
  key_name                   = var.key_name
  ami_id                     = var.ami_id
  redis_instance_type        = var.redis_instance_type
  postgres_instance_type     = var.postgres_instance_type
  scylla_instance_type       = var.scylla_instance_type
  redis_security_group_id    = module.security_group.redis_security_group_id
  postgres_security_group_id = module.security_group.postgres_security_group_id
  scylla_security_group_id   = module.security_group.scylla_security_group_id
}

# --------------------------------------------------
# ROUTE53 MODULE
# --------------------------------------------------

module "route53" {
  source = "./route53"

  project     = var.project
  environment = var.environment
  vpc_id      = var.vpc_id
  redis_ip    = module.ec2.redis_ip
  postgres_ip = module.ec2.postgres_ip
  scylla_ip   = module.ec2.scylla_ip
}

# --------------------------------------------------
# REDIS SERVER MODULE (Alternative: Standalone)
# --------------------------------------------------

# Uncomment to use redis-server module instead of ec2 submodule
# module "redis_server" {
#   source = "./redis-server"
#
#   project                 = var.project
#   environment             = var.environment
#   vpc_id                  = var.vpc_id
#   private_subnet_id       = var.private_subnet_id
#   key_name                = var.key_name
#   ami_id                  = var.ami_id
#   redis_instance_type     = var.redis_instance_type
#   redis_security_group_id = module.security_group.redis_security_group_id
# }

# --------------------------------------------------
# POSTGRES SERVER MODULE (Alternative: Standalone)
# --------------------------------------------------

# Uncomment to use postgres-server module instead of ec2 submodule
# module "postgres_server" {
#   source = "./postgres-server"
#
#   project                   = var.project
#   environment               = var.environment
#   vpc_id                    = var.vpc_id
#   private_subnet_id         = var.private_subnet_id
#   key_name                  = var.key_name
#   ami_id                    = var.ami_id
#   postgres_instance_type    = var.postgres_instance_type
#   postgres_security_group_id = module.security_group.postgres_security_group_id
# }

# --------------------------------------------------
# SCYLLA SERVER MODULE (Alternative: Standalone)
# --------------------------------------------------

# Uncomment to use scylla-server module instead of ec2 submodule
# module "scylla_server" {
#   source = "./scylla-server"
#
#   project                 = var.project
#   environment             = var.environment
#   vpc_id                  = var.vpc_id
#   private_subnet_id       = var.private_subnet_id
#   key_name                = var.key_name
#   ami_id                  = var.ami_id
#   scylla_instance_type    = var.scylla_instance_type
#   scylla_security_group_id = module.security_group.scylla_security_group_id
# }