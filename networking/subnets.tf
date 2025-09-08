# Discover the first two AZs (portable across accounts)
data "aws_availability_zones" "standard" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"] # only regional AZs
  }
  filter {
    name   = "zone-type"
    values = ["availability-zone"] # exclude local / wavelength
  }
}

locals {
  az_ids   = slice(data.aws_availability_zones.standard.zone_ids, 0, 2)
  az_names = slice(data.aws_availability_zones.standard.names, 0, 2) # for tags/outputs
}

# Private subnets
resource "aws_subnet" "jmccoytesting_privatesubnet_a" {
  vpc_id               = aws_vpc.jmccoytesting_opentofu_vpc.id
  cidr_block           = var.private_subnet_cidrs[0]
  availability_zone_id = local.az_ids[0]
  tags = merge(var.tags, {
    Name = "jmccoytesting-privatesubnet-a"
    Tier = "private"
  })
  depends_on = [aws_vpc.jmccoytesting_opentofu_vpc]
}

resource "aws_subnet" "jmccoytesting_privatesubnet_b" {
  vpc_id               = aws_vpc.jmccoytesting_opentofu_vpc.id
  cidr_block           = var.private_subnet_cidrs[1]
  availability_zone_id = local.az_ids[1]
  tags = merge(var.tags, {
    Name = "jmccoytesting-privatesubnet-b"
    Tier = "private"
  })
  depends_on = [aws_vpc.jmccoytesting_opentofu_vpc]
}

# Public subnets
resource "aws_subnet" "jmccoytesting_publicsubnet_a" {
  vpc_id                  = aws_vpc.jmccoytesting_opentofu_vpc.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone_id    = local.az_ids[0]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "jmccoytesting-publicsubnet-a"
    Tier = "public"
  })
  depends_on = [aws_vpc.jmccoytesting_opentofu_vpc]
}

resource "aws_subnet" "jmccoytesting_publicsubnet_b" {
  vpc_id                  = aws_vpc.jmccoytesting_opentofu_vpc.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone_id    = local.az_ids[1]
  map_public_ip_on_launch = true
  tags = merge(var.tags, {
    Name = "jmccoytesting-publicsubnet-b"
    Tier = "public"
  })
  depends_on = [aws_vpc.jmccoytesting_opentofu_vpc]
}
