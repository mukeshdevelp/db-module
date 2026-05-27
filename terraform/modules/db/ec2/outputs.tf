# --------------------------------------------------
# REDIS INSTANCE
# --------------------------------------------------

output "redis_id" {
  value = aws_instance.redis.id
}

output "redis_ip" {
  value = aws_instance.redis.private_ip
}

# --------------------------------------------------
# POSTGRES INSTANCE
# --------------------------------------------------

output "postgres_id" {
  value = aws_instance.postgres.id
}

output "postgres_ip" {
  value = aws_instance.postgres.private_ip
}

# --------------------------------------------------
# SCYLLA INSTANCE
# --------------------------------------------------

output "scylla_id" {
  value = aws_instance.scylla.id
}

output "scylla_ip" {
  value = aws_instance.scylla.private_ip
}
