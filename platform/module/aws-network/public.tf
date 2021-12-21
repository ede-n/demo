#### Public Subnets
locals {
  azs = [for o in var.az_config: o.az]  
  flat_public_subnets = toset(
    flatten([
      for az_subnet_config in var.az_config: [
        for idx, public_subnet in az_subnet_config["public_subnets"]: {
          cidr = public_subnet
          az   = az_subnet_config.az
          tag-Name = "${az_subnet_config.az}-public-${idx + 1}"
        }
      ]
    ])
  )
}

resource "aws_subnet" "public" {
  for_each = { for p in local.flat_public_subnets: p.tag-Name => p }

  vpc_id            = aws_vpc.this.id
  availability_zone = each.value.az

  cidr_block = each.value.cidr

  # TODO: extract variable
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = each.value.tag-Name
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.tags, {
    Name = "public"
  })
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = {for p in local.flat_public_subnets: p.tag-Name => p}
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.this.id 
  subnet_ids = [for s in aws_subnet.public: s.id]

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
    Name = "public-acl"
  })
}

