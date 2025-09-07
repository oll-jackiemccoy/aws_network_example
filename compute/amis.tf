# Region-aware AMI IDs from AWS public SSM params
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

data "aws_ssm_parameter" "win2019" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base"
}

locals {
  linux_ami_id   = data.aws_ssm_parameter.al2023.value
  windows_ami_id = data.aws_ssm_parameter.win2019.value
}
