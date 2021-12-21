locals {
  default_tags = {
    "Stage" = var.stage
    "Name"  = var.long_name
  }
  tags = merge(local.default_tags, var.additional_tags)
}

data "aws_availability_zones" "available" {
}

resource "aws_vpc" "this" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.dns_hostnames_enabled
  enable_dns_support               = var.dns_support_enabled
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = false
  tags = merge(local.tags, {
    "Name" = "${var.long_name}-vpc"
  })
}

# Avoids implicitly created SG with access `0.0.0.0/0`. 
resource "aws_default_security_group" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.tags, {
    "Name" = "${var.long_name}-sg"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.tags, {
    "Name" = "${var.long_name}-ig"
  })
}
