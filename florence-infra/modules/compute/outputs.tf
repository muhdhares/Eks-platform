output "launch_template" {
  value = {
    for name, lt in aws_launch_template.ec2 :
    name => {
      id      = lt.id
      arn     = lt.arn
      name    = lt.name
      version = lt.latest_version
    }
  }
}

output "autoscaling_group" {
  value = {
    for name, asg in aws_autoscaling_group.this :
    name => {
      id   = asg.id
      arn  = asg.arn
      name = asg.name
    }
  }
}

output "iam_role" {
  value = {
    id   = aws_iam_role.ec2_instance_role.id
    arn  = aws_iam_role.ec2_instance_role.arn
    name = aws_iam_role.ec2_instance_role.name
  }
}

output "instance_profile" {
  value = {
    id   = aws_iam_instance_profile.ec2.id
    arn  = aws_iam_instance_profile.ec2.arn
    name = aws_iam_instance_profile.ec2.name
  }
}
