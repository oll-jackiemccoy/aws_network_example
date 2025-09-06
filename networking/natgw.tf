# One EIP per NAT
resource "aws_eip" "jmccoytesting_eip_a" {
  domain = "vpc"
  tags   = merge(var.tags, { Name = "jmccoytesting_eip_a" })
}

resource "aws_eip" "jmccoytesting_eip_b" {
  domain = "vpc"
  tags   = merge(var.tags, { Name = "jmccoytesting_eip_b" })
}

# One NAT per AZ, placed in the corresponding PUBLIC subnet
resource "aws_nat_gateway" "jmccoytesting_natgw_a" {
  allocation_id = aws_eip.jmccoytesting_eip_a.id
  subnet_id     = aws_subnet.jmccoytesting_publicsubnet_a.id
  tags          = merge(var.tags, { Name = "jmccoytesting_natgw_a" })

  # ensures IGW exists and the public subnet is truly public before NAT creation
  depends_on = [aws_internet_gateway.jmccoy_opentofu_igw]
}

resource "aws_nat_gateway" "jmccoytesting_natgw_b" {
  allocation_id = aws_eip.jmccoytesting_eip_b.id
  subnet_id     = aws_subnet.jmccoytesting_publicsubnet_b.id
  tags          = merge(var.tags, { Name = "jmccoytesting_natgw_b" })

  depends_on = [aws_internet_gateway.jmccoy_opentofu_igw]
}
