locals {
  name_prefix = "${var.project_name}-${var.environment}"

  names = {
    launch_template_name    = "${local.name_prefix}-lt"
    auto_scaling_group_name = "${local.name_prefix}-asg"
    ec2_role                = "${local.name_prefix}-ec2-role"
    ec2_instance_profile    = "${local.name_prefix}-ec2-profile"
  }
  policies = [
    "AmazonSSMManagedInstanceCore",
    "CloudWatchAgentServerPolicy",
    "AmazonEC2ContainerRegistryReadOnly"
  ]


  common_tags = merge(var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.metadata.owner
      Repository  = var.metadata.repository
    }
  )
}
