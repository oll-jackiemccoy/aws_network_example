output "vpc_id" { value = module.networking.vpc_id }
output "azs_used" { value = module.networking.azs_used }
output "private_subnet" { value = module.networking.private_subnet_ids }
output "ssm_instance_profile_name" { value = aws_iam_instance_profile.jmccoy_ssm_profile.name }
output "ssm_role_name" { value = aws_iam_role.jmccoy_ssm_role.name }