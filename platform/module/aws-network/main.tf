locals {
  default_tags = {
    "Stage" = var.stage
    "Name"  = var.long_name
  }
  tags = merge(local.default_tags, var.additional_tags)
}
resource "aws_vpc" "this" {
  count = var.enabled ? 1 : 0

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
  count = var.enabled && var.default_security_group_deny_all ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags = merge(local.tags, {
    "Name" = "${var.long_name}-sg"
  })
}

resource "aws_internet_gateway" "this" {
  count = var.enabled && var.internet_gateway_enabled ? 1 : 0

  vpc_id = aws_vpc.this[0].id
  tags = merge(local.tags, {
    "Name" = "${var.long_name}-ig"
  })
}
