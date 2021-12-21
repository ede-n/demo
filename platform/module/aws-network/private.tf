### Private subnets
locals {
  flat_private_subnets = toset(
    flatten([
      for az_subnet_config in var.az_config: [
        for idx, private_subnet in az_subnet_config["private_subnets"]: {
          cidr = private_subnet
          az   = az_subnet_config.az
          tag-Name = "${az_subnet_config.az}-private-${idx + 1}"
        }
      ]
    ])
  )
}

resource "aws_subnet" "private" {
  for_each = { for p in local.flat_private_subnets: p.tag-Name => p }

  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.az

  cidr_block = each.value.cidr

  # TODO: extract variable
  map_public_ip_on_launch = false

  tags = merge(local.tags, {
    Name = each.value.tag-Name
  })
}

resource "aws_route_table" "private" {
  for_each = { for p in local.flat_private_subnets: p.tag-Name => p }
  vpc_id = aws_vpc.this.id

  tags = merge(local.tags, {
    Name = each.value.tag-Name
  })
}

resource "aws_route_table_association" "private" {
  for_each = { for p in local.flat_private_subnets: p.tag-Name => p }  
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [for s in aws_subnet.private: s.id]

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = merge(local.tags, {
    Name = "private-acl"
  })
}
