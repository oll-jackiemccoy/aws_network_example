resource "aws_instance" "jmccoytesting_ec2_linux" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = "t3.medium"
  subnet_id                   = var.private_subnet_id_a
  vpc_security_group_ids      = [aws_security_group.jmccoytesting_ec2_linux.id]
  iam_instance_profile        = var.ssm_instance_profile_name
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = { Name = "jmccoytesting_ec2_linux" }

}
resource "aws_instance" "jmccoytesting_ec2_windows" {
  ami                         = data.aws_ssm_parameter.win2019.value
  instance_type               = "t3.medium"
  subnet_id                   = var.private_subnet_id_b
  vpc_security_group_ids      = [aws_security_group.jmccoytesting_ec2_windows.id]
  iam_instance_profile        = var.ssm_instance_profile_name
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = { Name = "jmccoytesting-ec2-windows" }

}