# --------------------------------------------------
# FETCH EXISTING HOSTED ZONE USING TAGS
# --------------------------------------------------

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false

  tags = {
    Application = "otms"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Name        = "dev-otms-hz"
    Owner       = "platform-team"
    Project     = "OTMS"
    Sprint      = "1"
    CostCenter  = "dev-infra"
  }
}

# --------------------------------------------------
# REDIS RECORD
# --------------------------------------------------

resource "aws_route53_record" "redis_record" {
  zone_id = data.aws_route53_zone.main.zone_id

  name = "redis.${var.domain_name}"

  type = "A"
  ttl  = 300

  records = [aws_instance.redis.private_ip]
}

# --------------------------------------------------
# POSTGRES RECORD
# --------------------------------------------------

resource "aws_route53_record" "postgres_record" {
  zone_id = data.aws_route53_zone.main.zone_id

  name = "postgres.${var.domain_name}"

  type = "A"
  ttl  = 300

  records = [aws_instance.postgres.private_ip]
}

# --------------------------------------------------
# SCYLLA RECORD
# --------------------------------------------------

resource "aws_route53_record" "scylla_record" {
  zone_id = data.aws_route53_zone.main.zone_id

  name = "scylla.${var.domain_name}"

  type = "A"
  ttl  = 300

  records = [aws_instance.scylla.private_ip]
}