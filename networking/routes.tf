# Public route table -> Internet via IGW
resource "aws_route_table" "jmccoytesting_public" {
  vpc_id = aws_vpc.jmccoytesting_opentofu_vpc.id
  tags = merge(var.tags, {
    Name = "jmccoytesting-rt-public"
    Tier = "public"
  })
}

resource "aws_route" "jmccoytesting_public_default" {
  route_table_id         = aws_route_table.jmccoytesting_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.jmccoy_opentofu_igw.id
}

# Associate public subnets with the public RT
resource "aws_route_table_association" "jmccoytesting_public_a" {
  subnet_id      = aws_subnet.jmccoytesting_publicsubnet_a.id
  route_table_id = aws_route_table.jmccoytesting_public.id
}

resource "aws_route_table_association" "jmccoytesting_public_b" {
  subnet_id      = aws_subnet.jmccoytesting_publicsubnet_b.id
  route_table_id = aws_route_table.jmccoytesting_public.id
}


# Private route table for AZ A -> NAT A
resource "aws_route_table" "jmccoytesting_private_a" {
  vpc_id = aws_vpc.jmccoytesting_opentofu_vpc.id
  tags   = merge(var.tags, { Name = "jmccoytesting-rt-private-a", Tier = "private" })
}

resource "aws_route" "jmccoytesting_private_a_default" {
  route_table_id         = aws_route_table.jmccoytesting_private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.jmccoytesting_natgw_a.id
}

resource "aws_route_table_association" "jmccoytesting_private_assoc_a" {
  subnet_id      = aws_subnet.jmccoytesting_privatesubnet_a.id
  route_table_id = aws_route_table.jmccoytesting_private_a.id
}

# Private route table for AZ B -> NAT B
resource "aws_route_table" "jmccoytesting_private_b" {
  vpc_id = aws_vpc.jmccoytesting_opentofu_vpc.id
  tags   = merge(var.tags, { Name = "jmccoytesting-rt-private-b", Tier = "private" })
}

resource "aws_route" "jmccoytesting_private_b_default" {
  route_table_id         = aws_route_table.jmccoytesting_private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.jmccoytesting_natgw_b.id
}

resource "aws_route_table_association" "jmccoytesting_private_assoc_b" {
  subnet_id      = aws_subnet.jmccoytesting_privatesubnet_b.id
  route_table_id = aws_route_table.jmccoytesting_private_b.id
}
