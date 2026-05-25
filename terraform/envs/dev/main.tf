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
  region      = var.region
  domain_name = var.domain_name

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  private_subnet_id = values(
    data.terraform_remote_state.network.outputs.private_subnet_ids
  )[0]

  key_name = data.aws_key_pair.selected.key_name
  ami_id   = data.aws_ami.ubuntu.id

  
}       