┌─────────────────────────────────────────────────────────────────┐
│ ENVS/DEV (Root Level)                                           │
├─────────────────────────────────────────────────────────────────┤
│ terraform.tfvars:                                               │
│   region      = "us-east-1"                                     │
│   environment = "dev"                                           │
│   application = "otms"                                          │
│   domain_name = "dev.otms.internal"                             │
│                                                                 │
│ variables.tf declares:                                          │
│   variable "region" {}                                          │
│   variable "environment" {}                                     │
│   variable "application" {}                                     │
│   variable "domain_name" {}                                     │
│                                                                 │
│ DATA BLOCKS (fetches existing infra):                          │
│   data "terraform_remote_state" "network" → vpc_id             │
│   data "terraform_remote_state" "network" → private_subnet_ids │
│   data "aws_key_pair" "selected" → key_name                    │
│   data "aws_ami" "ubuntu" → ami_id                             │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           │ PASSES TO DB MODULE
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│ MODULES/DB (Parent Module - main.tf)                            │
├─────────────────────────────────────────────────────────────────┤
│ module "db" receives:                                           │
│   project              = var.application                        │
│   environment          = var.environment                        │
│   region               = var.region                             │
│   domain_name          = var.domain_name                        │
│   vpc_id               = data.terraform_remote_state.network... │
│   private_subnet_id    = data.terraform_remote_state.network... │
│   key_name             = data.aws_key_pair.selected.key_name    │
│   ami_id               = data.aws_ami.ubuntu.id                 │
│   redis_instance_type  = var.redis_instance_type               │
│   postgres_instance_type = var.postgres_instance_type          │
│   scylla_instance_type  = var.scylla_instance_type             │
└──────────────────────────┬──────────────────────────────────────┘
                           │
           ┌───────────────┼───────────────┐
           │               │               │
           ▼               ▼               ▼
┌──────────────────┐ ┌──────────────┐ ┌───────────────┐
│ SECURITY_GROUP   │ │ EC2          │ │ ROUTE53       │
│ SUBMODULE        │ │ SUBMODULE    │ │ SUBMODULE     │
├──────────────────┤ ├──────────────┤ ├───────────────┤
│ Receives:        │ │ Receives:    │ │ Receives:     │
│ • project        │ │ • project    │ │ • project     │
│ • environment    │ │ • environment│ │ • environment │
│ • vpc_id         │ │ • vpc_id     │ │ • vpc_id      │
│                  │ │ • private_   │ │ • redis_ip    │
│ Creates:         │ │   subnet_id  │ │ • postgres_ip │
│ • redis_sg       │ │ • key_name   │ │ • scylla_ip   │
│ • postgres_sg    │ │ • ami_id     │ │               │
│ • scylla_sg      │ │ • instance   │ │ Creates:      │
│                  │ │   types      │ │ • Private     │
│ Outputs:         │ │              │ │   Hosted Zone │
│ • redis_sg_id    │ │ Creates:     │ │ • DNS Records │
│ • postgres_sg_id │ │ • redis      │ │               │
│ • scylla_sg_id   │ │   instance   │ │ Outputs:      │
│                  │ │ • postgres   │ │ • hz_id       │
│                  │ │   instance   │ │ • redis_dns   │
│                  │ │ • scylla     │ │ • postgres_dns│
│                  │ │   instance   │ │ • scylla_dns  │
│                  │ │              │ │               │
│                  │ │ Outputs:     │ │               │
│                  │ │ • redis_ip   │ │               │
│                  │ │ • postgres_ip│ │               │
│                  │ • scylla_ip   │ │               │
└──────────────────┴──────────────┘ └───────────────┘
           │               │               │
           └───────────────┼───────────────┘
                           │
                           │ Outputs back to DB Module
                           ▼
         ┌─────────────────────────────────┐
         │ DB Module outputs to Root       │
         │ ├─ redis_ip                     │
         │ ├─ postgres_ip                  │
         │ ├─ scylla_ip                    │
         │ ├─ redis_dns                    │
         │ ├─ postgres_dns                 │
         │ ├─ scylla_dns                   │
         │ ├─ private_hosted_zone_id       │
         │ └─ private_hosted_zone_name     │
         └─────────────────────────────────┘