# --------------------------------------------------
# INSTANCE IPS
# --------------------------------------------------

output "redis_ip" {
  value = module.ec2.redis_ip
}

output "postgres_ip" {
  value = module.ec2.postgres_ip
}

output "scylla_ip" {
  value = module.ec2.scylla_ip
}

# --------------------------------------------------
# PRIVATE DNS
# --------------------------------------------------

output "redis_dns" {
  value = module.route53.redis_dns
}

output "postgres_dns" {
  value = module.route53.postgres_dns
}

output "scylla_dns" {
  value = module.route53.scylla_dns
}

# --------------------------------------------------
# HOSTED ZONE
# --------------------------------------------------

output "private_hosted_zone_id" {
  value = module.route53.private_hosted_zone_id
}

output "private_hosted_zone_name" {
  value = module.route53.private_hosted_zone_name
}