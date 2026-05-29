region      = "us-east-1"
environment = "dev"
application = "otms"
owner       = "platform-team"
domain_name = "dev.otms.internal"

tags = {
  Environment = "dev"
  Project     = "OTMS"
  ManagedBy   = "Terraform"
}

security_groups = {
  redis = {
    ingress = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    tags = {
      Environment = "dev"
      Project     = "OTMS"
      ManagedBy   = "Terraform"
    }
  }

  postgres = {
    ingress = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    tags = {
      Environment = "dev"
      Project     = "OTMS"
      ManagedBy   = "Terraform"
    }
  }

  scylla = {
    ingress = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    tags = {
      Environment = "dev"
      Project     = "OTMS"
      ManagedBy   = "Terraform"
    }
  }
}
