resource "aws_security_group" "redis_sg" {
  name   = "${var.project}-${var.environment}-redis-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
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

resource "aws_instance" "redis" {
  ami                    = var.ami_id
  instance_type          = var.redis_instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.redis_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "${var.project}-${var.environment}-redis"
  }
}