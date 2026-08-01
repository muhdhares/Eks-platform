resource "aws_iam_role" "ec2_instance_role" {
  name               = local.names.ec2_role
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = merge(local.common_tags, {
    Name = local.names.ec2_role
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = local.names.ec2_instance_profile
  role = aws_iam_role.ec2_instance_role.name

  tags = merge(local.common_tags, {
    Name = local.names.ec2_instance_profile
  })
}


resource "aws_iam_role_policy_attachment" "ec2" {
  for_each   = local.policies
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:${data.aws_partition.partition.partition}:iam::aws:policy/${each.value}"
}
