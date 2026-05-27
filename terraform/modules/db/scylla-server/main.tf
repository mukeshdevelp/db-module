terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_security_group" "scylla_sg" {
  name   = "${var.project}-${var.environment}-scylla-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 9042
    to_port     = 9042
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "dev"
    Project     = "OTMS"
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "scylla" {
  ami                    = var.ami_id
  instance_type          = var.scylla_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.scylla_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-scylla"
    Environment = "dev"
    Project     = "OTMS"
    ManagedBy   = "Terraform"
  }
}
