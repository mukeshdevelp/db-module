resource "aws_security_group" "postgres_sg" {
  name   = "${var.project}-${var.environment}-postgres-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "postgres" {
  ami                    = var.ami_id
  instance_type          = var.postgres_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "${var.project}-${var.environment}-postgres"
  }
}