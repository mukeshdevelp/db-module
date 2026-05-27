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
# POSTGRES SECURITY GROUP
# --------------------------------------------------

output "postgres_security_group_id" {
  value = aws_security_group.postgres_sg.id
}
