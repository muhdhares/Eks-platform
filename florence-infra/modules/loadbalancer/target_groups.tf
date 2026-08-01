resource "aws_lb_target_group" "this" {
  for_each = var.target_groups
  name     = "${local.names.tg}-${each.key}"

  vpc_id      = var.vpc_id
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = "instance"

  health_check {
    enabled             = true
    protocol            = each.value.health_check.protocol
    path                = each.value.health_check.path
    matcher             = each.value.health_check.matcher
    interval            = each.value.health_check.interval
    timeout             = each.value.health_check.timeout
    healthy_threshold   = each.value.health_check.healthy_threshold
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
  }
  stickiness {
    enabled = false
    type    = "lb_cookie"
  }
  protocol_version              = "HTTP1"
  load_balancing_algorithm_type = each.value.load_balancing_algorithm_type
  tags = merge(local.common_tags, {
    Name = "${local.names.tg}-${each.key}"
  })
}
