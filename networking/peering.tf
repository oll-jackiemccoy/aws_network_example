data "aws_vpc" "peer" {
  id = var.peer_vpc_id
}

# Create the peering connection (auto-accept if same account & region)
resource "aws_vpc_peering_connection" "jmccoytesting_peer" {
  vpc_id      = aws_vpc.jmccoytesting_opentofu_vpc.id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true

  tags = merge(var.tags, {
    Name = "peer-${aws_vpc.jmccoytesting_opentofu_vpc.id}->${var.peer_vpc_id}"
  })
}

# Enable DNS resolution across the peering (both directions)
resource "aws_vpc_peering_connection_options" "jmccoytesting_peer_opt" {
  vpc_peering_connection_id = aws_vpc_peering_connection.jmccoytesting_peer.id

  requester { allow_remote_vpc_dns_resolution = false }
  accepter { allow_remote_vpc_dns_resolution = false }
}
resource "aws_route" "to_peer_private_a" {
  route_table_id            = aws_route_table.jmccoytesting_private_a.id
  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.jmccoytesting_peer.id
}

resource "aws_route" "to_peer_private_b" {
  route_table_id            = aws_route_table.jmccoytesting_private_b.id
  destination_cidr_block    = data.aws_vpc.peer.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.jmccoytesting_peer.id
}
resource "aws_route" "peer_to_workspace" {
  route_table_id            = "rtb-077fd3a6105e4463e"
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.jmccoytesting_peer.id
}
output "vpc_peering_connection_id" {
  value       = aws_vpc_peering_connection.jmccoytesting_peer.id
  description = "Peering connection ID"
}
