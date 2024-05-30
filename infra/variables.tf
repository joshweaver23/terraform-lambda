variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

locals {
  ns   = "example"

  envs = {
    dev = "dev"
    prod  = "prod"
  }

  env = lookup(local.envs, terraform.workspace, local.envs.dev)

  tags = {
    Terraform = "true"
    Environment = local.env
  }
}