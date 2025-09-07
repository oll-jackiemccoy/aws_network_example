output "vpc_id" {
  value       = aws_vpc.jmccoytesting_opentofu_vpc.id
}
output "azs_used" { value = { a = local.az_names[0], b = local.az_names[1] } }

output "private_subnet_ids" {
  value = [
    aws_subnet.jmccoytesting_privatesubnet_a.id,
    aws_subnet.jmccoytesting_privatesubnet_b.id
  ]
}
output "private_subnet_id_a" { value = aws_subnet.jmccoytesting_privatesubnet_a.id }
output "private_subnet_id_b" { value = aws_subnet.jmccoytesting_privatesubnet_b.id }