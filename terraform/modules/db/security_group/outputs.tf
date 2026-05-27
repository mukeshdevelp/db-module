# --------------------------------------------------
# REDIS SECURITY GROUP
# --------------------------------------------------

output "redis_security_group_id" {
  value = aws_security_group.redis_sg.id
}

# --------------------------------------------------
# POSTGRES SECURITY GROUP
# --------------------------------------------------

output "postgres_security_group_id" {
  value = aws_security_group.postgres_sg.id
}

# --------------------------------------------------
# SCYLLA SECURITY GROUP
# --------------------------------------------------

output "scylla_security_group_id" {
  value = aws_security_group.scylla_sg.id
}
