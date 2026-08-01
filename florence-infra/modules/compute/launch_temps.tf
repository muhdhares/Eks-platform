resource "aws_launch_template" "ec2" {
  for_each               = var.instance_config
  description            = "launch template for ${each.key} instance"
  name                   = "${local.name_prefix}-${each.key}-lt"
  image_id               = data.aws_ami.amazon_linux_2023.id
  instance_type          = each.value.instance_type
  update_default_version = true
  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2.arn
  }

  vpc_security_group_ids = [var.app_sg_id]
  user_data              = base64encode(each.value.userdata)
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = each.value.root_volume_size
      volume_type           = each.value.root_volume_type
      encrypted             = true
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"

  }
  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${local.name_prefix}-${each.key}"
    })
  }

  tag_specifications {

    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.name_prefix}-${each.key}-volume"
      }
    )

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}-lt"
    }
  )
}
