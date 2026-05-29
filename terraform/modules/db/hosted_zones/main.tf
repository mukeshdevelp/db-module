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
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.project}-private-hz"
  })
}

resource "aws_route53_record" "redis_record" {
  zone_id = aws_route53_zone.private.zone_id

  name = "redis.${var.domain_name}"

  type = "A"
  ttl  = 300

  records = [var.redis_ip]
}

resource "aws_route53_record" "postgres_record" {
  zone_id = aws_route53_zone.private.zone_id

  name = "postgres.${var.domain_name}"

  type = "A"
  ttl  = 300

  records = [var.postgres_ip]
}

resource "aws_route53_record" "scylla_record" {
  zone_id = aws_route53_zone.private.zone_id

  name = "scylla.${var.domain_name}"

  type = "A"
  ttl  = 300

  records = [var.scylla_ip]
}
