terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_route53_zone" "private" {
  name = "internal.otms"

  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name        = "${var.environment}-${var.project}-private-hz"
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "Terraform"
    Owner       = "platform-team"
  }
}

resource "aws_route53_record" "redis_record" {
  zone_id = aws_route53_zone.private.zone_id

  name = "redis.internal.otms"

  type = "A"
  ttl  = 300

  records = [var.redis_ip]
}

resource "aws_route53_record" "postgres_record" {
  zone_id = aws_route53_zone.private.zone_id

  name = "postgres.internal.otms"

  type = "A"
  ttl  = 300

  records = [var.postgres_ip]
}

resource "aws_route53_record" "scylla_record" {
  zone_id = aws_route53_zone.private.zone_id

  name = "scylla.internal.otms"

  type = "A"
  ttl  = 300

  records = [var.scylla_ip]
}
