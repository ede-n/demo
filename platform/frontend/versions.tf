terraform {
  required_version = ">= 1.1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket               = "terraform-state-nede-demo"
    key                  = "terraform.state"
    region               = "us-west-1"
    encrypt              = true
    workspace_key_prefix = "demo"
  }
}
