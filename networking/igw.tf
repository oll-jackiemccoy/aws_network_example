resource "aws_internet_gateway" "jmccoy_opentofu_igw" {
  vpc_id = aws_vpc.jmccoytesting_opentofu_vpc.id
  
  tags = merge(var.tags, {
    Name    = "jmccoy_opentofu_igw"
  })
}
