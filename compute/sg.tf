# Linux instances — SSH from your IP only
resource "aws_security_group" "jmccoytesting_ec2_linux" {
  name        = "jmccoytesting_ec2_linux"
  description = "Linux EC2: SSH from admin IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags =  { Name = "jmccoytesting_ec2_linux" }
}

# Windows instances — RDP from your IP only
resource "aws_security_group" "jmccoytesting_ec2_windows" {
  name        = "jmccoytesting_ec2_windows"
  description = "Windows EC2: RDP from admin IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "RDP from admin IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    description = "All egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "jmccoytesting_ec2_windows" }
}
