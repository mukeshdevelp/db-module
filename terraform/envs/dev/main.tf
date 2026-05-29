# --------------------------------------------------
# NETWORK REMOTE STATE
# --------------------------------------------------

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "otms-dev-state-sprint-05"
    key    = "env/dev/network/network.tfstate"
    region = "us-east-1"
  }
}

# --------------------------------------------------
# APPLICATION REMOTE STATE (to fetch backend API SG)
# --------------------------------------------------
data "terraform_remote_state" "application" {
  backend = "s3"

  config = {
    bucket = "otms-dev-state-sprint-05"
    key    = "env/dev/application/application.tfstate"
    region = "us-east-1"
  }
}

# --------------------------------------------------
# FETCH KEYPAIR
# --------------------------------------------------

data "aws_key_pair" "selected" {
  key_name = "${var.environment}-${var.application}-keypair"
}

# --------------------------------------------------
# FETCH UBUNTU AMI
# --------------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# --------------------------------------------------
# DB MODULE
# --------------------------------------------------

module "db" {
  source = "../../modules/db"

  project     = var.application
  environment = var.environment
  owner       = var.owner
  region      = var.region
  domain_name = var.domain_name
  tags        = var.tags

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  # choose the last available private subnet from remote state (safe when count varies)
  private_subnet_id = element(
    values(data.terraform_remote_state.network.outputs.private_subnet_ids),
    length(values(data.terraform_remote_state.network.outputs.private_subnet_ids)) - 1
  )

  key_name          = data.aws_key_pair.selected.key_name
  ami_id            = data.aws_ami.ubuntu.id
  backend_api_sg_id = data.terraform_remote_state.application.outputs.backend_api_sg_id

}       