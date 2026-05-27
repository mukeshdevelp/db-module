# --------------------------------------------------
# HOSTED ZONE
# --------------------------------------------------

output "private_hosted_zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "private_hosted_zone_name" {
  value = aws_route53_zone.private.name
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
