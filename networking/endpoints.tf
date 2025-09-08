# Discover current region name for service endpoints
data "aws_region" "current" {}

locals {
  subnet_ids = [
    aws_subnet.jmccoytesting_privatesubnet_a.id,
    aws_subnet.jmccoytesting_privatesubnet_b.id
  ]
  sg_ids      = [aws_security_group.jmccoytesting_ssm_sg.id]
  region_name = data.aws_region.current.region
}

# SSM
resource "aws_vpc_endpoint" "jmccoytesting_ssm" {
  vpc_id              = aws_vpc.jmccoytesting_opentofu_vpc.id
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${local.region_name}.ssm"
  private_dns_enabled = true
  subnet_ids          = local.subnet_ids
  security_group_ids  = local.sg_ids
  tags                = merge(var.tags, { Name = "jmccoytesting-ssm" })
}

# SSM Messages
resource "aws_vpc_endpoint" "jmccoytesting_ssmmessages" {
  vpc_id              = aws_vpc.jmccoytesting_opentofu_vpc.id
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${local.region_name}.ssmmessages"
  private_dns_enabled = true
  subnet_ids          = local.subnet_ids
  security_group_ids  = local.sg_ids
  tags                = merge(var.tags, { Name = "jmccoytesting-ssmmessages" })
}

# EC2 Messages
resource "aws_vpc_endpoint" "jmccoytesting_ec2messages" {
  vpc_id              = aws_vpc.jmccoytesting_opentofu_vpc.id
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${local.region_name}.ec2messages"
  private_dns_enabled = true
  subnet_ids          = local.subnet_ids
  security_group_ids  = local.sg_ids
  tags                = merge(var.tags, { Name = "jmccoytesting-ec2messages" })
}
# S3 
data "aws_region" "current_s3" {}

resource "aws_vpc_endpoint" "jmccoytesting_s3" {
  vpc_id            = aws_vpc.jmccoytesting_opentofu_vpc.id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${local.region_name}.s3"

  route_table_ids = [
    aws_route_table.jmccoytesting_private_a.id,
    aws_route_table.jmccoytesting_private_b.id
  ]

  tags = merge(var.tags, { Name = "jmccoytesting-s3" })
}