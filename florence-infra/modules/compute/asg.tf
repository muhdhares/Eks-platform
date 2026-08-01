resource "aws_autoscaling_group" "this" {
  for_each = var.instance_config
  name     = "${local.name_prefix}-${each.key}-asg"

  desired_capacity = each.value.desired_capacity
  min_size         = each.value.min_size
  max_size         = each.value.max_size

  vpc_zone_identifier = var.app_subnet_ids

  launch_template {
    id      = aws_launch_template.ec2.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300


  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
    }
    triggers = [
      "launch_template"
    ]
  }

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  protect_from_scale_in = false
  termination_policies = [
    "OldestLaunchTemplate"
  ]

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-${each.key}-asg"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

