# --------------------------------------------------
# INSTANCE IPS
# --------------------------------------------------

output "redis_ip" {
  value = aws_instance.redis.private_ip
}

output "postgres_ip" {
  value = aws_instance.postgres.private_ip
}

output "scylla_ip" {
  value = aws_instance.scylla.private_ip
}

# --------------------------------------------------
# HOSTED ZONE
# --------------------------------------------------

output "hosted_zone_id" {
  value = data.aws_route53_zone.main.zone_id
}

output "hosted_zone_name" {
  value = data.aws_route53_zone.main.name
}

# --------------------------------------------------
# DNS RECORDS
# --------------------------------------------------

output "redis_dns" {
  value = aws_route53_record.redis_record.fqdn
}

output "postgres_dns" {
  value = aws_route53_record.postgres_record.fqdn
}

output "scylla_dns" {
  value = aws_route53_record.scylla_record.fqdn
}