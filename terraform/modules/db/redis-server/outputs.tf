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
# REDIS SECURITY GROUP
# --------------------------------------------------

output "redis_security_group_id" {
  value = aws_security_group.redis_sg.id
}
