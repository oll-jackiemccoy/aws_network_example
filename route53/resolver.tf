resource "aws_route53_resolver_endpoint" "jmccoytesting_outbound" {
  name               = "jmccoytesting-outbound-resolver"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.resolver_outbound_sg.id]

  dynamic "ip_address" {
    for_each = var.private_subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }
}

resource "aws_security_group" "resolver_outbound_sg" {
  name        = "resolver_outbound_sg"
  description = "SG for Route 53 OUTBOUND resolver endpoint"
  vpc_id      = var.vpc_id

  # Outbound DNS (stateful SG means replies are allowed automatically)
  egress {
    description = "Allow UDP 53 to allowed destinations"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = var.egress_cidrs
  }
  egress {
    description = "Allow TCP 53 to allowed destinations"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = var.egress_cidrs
  }
}
resource "aws_route53_resolver_rule" "jmccoytesting_rslvrRule" {
  domain_name          = "internal.jmccoy.com"                  # <-- hard-coded domain
  name                 = "jmccoytesting_rslvrRule"                           # friendly name
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.jmccoytesting_outbound.id

  dynamic "target_ip" {
    for_each = var.forward_target_ips
    content {
      ip   = target_ip.value
      port = 53
    }
  }
}
resource "aws_route53_resolver_rule_association" "fwd_assoc" {
  resolver_rule_id = aws_route53_resolver_rule.jmccoytesting_rslvrRule.id
  vpc_id           = var.vpc_id
}