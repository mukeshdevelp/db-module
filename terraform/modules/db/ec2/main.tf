terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_instance" "redis" {
  ami                    = var.ami_id
  instance_type          = var.redis_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.redis_security_group_id]
  key_name               = var.key_name

  tags = {
    Name = "${var.project}-${var.environment}-redis"
  }
}

resource "aws_instance" "postgres" {
  ami                    = var.ami_id
  instance_type          = var.postgres_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.postgres_security_group_id]
  key_name               = var.key_name

  tags = {
    Name = "${var.project}-${var.environment}-postgres"
  }
}

resource "aws_instance" "scylla" {
  ami                    = var.ami_id
  instance_type          = var.scylla_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.scylla_security_group_id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project}-${var.environment}-scylla"
  }
}
