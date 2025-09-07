data "aws_partition" "current" {}

resource "aws_iam_role" "jmccoy_ssm_role" {
  name = "jmccoy-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Project = "tofu-learning"
  }
}
resource "aws_iam_role_policy_attachment" "ssm_core_attach" {
  role       = aws_iam_role.jmccoy_ssm_role.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = aws_iam_role.jmccoy_ssm_role.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_instance_profile" "jmccoy_ssm_profile" {
  name = "jmccoy-ssm-role"
  role = aws_iam_role.jmccoy_ssm_role.name
}