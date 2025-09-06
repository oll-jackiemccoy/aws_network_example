output "vpc_id" {
  value       = aws_vpc.jmccoytesting_opentofu_vpc.id
  description = "VPC ID"
}
output "azs_used" { value = { a = local.az_names[0], b = local.az_names[1] } }
