# --------------------------------------------------
# SCYLLA INSTANCE
# --------------------------------------------------

output "scylla_id" {
  value = aws_instance.scylla.id
}

output "scylla_ip" {
  value = aws_instance.scylla.private_ip
}

# --------------------------------------------------
# SCYLLA SECURITY GROUP
# --------------------------------------------------

output "scylla_security_group_id" {
  value = aws_security_group.scylla_sg.id
}
