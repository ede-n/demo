locals {
  long_name = "${var.stage}-aws-${var.region}-${var.app}"
}
module "aws_network" {
  source = "../module/aws-network"

  cidr_block = var.vpc_cidr
  stage      = var.stage
  az_config = var.az_config
  long_name  = local.long_name
  additional_tags = {
    Owners = "DevOps"
  }
}
