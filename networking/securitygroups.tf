# SG for Interface VPC Endpoints (allow HTTPS from private subnets)
resource "aws_security_group" "jmccoytesting_ssm_sg" {
  name        = "jmccoytesting-ssm-sg"
  description = "Allow 443 from private subnets to SSM interface endpoints"
  vpc_id      = aws_vpc.jmccoytesting_opentofu_vpc.id

  ingress {
    description = "HTTPS from private subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.jmccoytesting_opentofu_vpc.cidr_block]
  }

  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "jmccoytesting-ssm-sg" })
}
