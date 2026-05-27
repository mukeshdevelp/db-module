# LOGIC MOVED TO: modules/db/security_group/main.tf and modules/db/ec2/main.tf
# resource "aws_security_group" "scylla_sg" {
#   name   = "${var.project}-${var.environment}-scylla-sg"
#   vpc_id = var.vpc_id
#
#   ingress {
#     from_port   = 9042
#     to_port     = 9042
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 7000
#     to_port     = 7000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
#
# resource "aws_instance" "scylla" {
#   ami                    = var.ami_id
#   instance_type          = var.scylla_instance_type
#   subnet_id              = var.private_subnet_id
#   vpc_security_group_ids = [aws_security_group.scylla_sg.id]
#   key_name               = var.key_name
#
#   root_block_device {
#     volume_size = 16
#     volume_type = "gp3"
#   }
#
#   tags = {
#     Name = "${var.project}-${var.environment}-scylla"
#   }
# }