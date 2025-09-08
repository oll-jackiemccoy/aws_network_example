resource "aws_vpc_dhcp_options" "jmccoytesting_dhcp" {
  domain_name         = "internal.testing.com"
  domain_name_servers = var.dhcp_domain_name_servers

  tags = merge(var.tags, {
    Name = "jmccoytesting-dhcp"
  })
}
resource "aws_vpc_dhcp_options_association" "jmccoytesting_dhcp_assoc" {
  vpc_id          = aws_vpc.jmccoytesting_opentofu_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.jmccoytesting_dhcp.id

  depends_on = [aws_vpc.jmccoytesting_opentofu_vpc]
}
