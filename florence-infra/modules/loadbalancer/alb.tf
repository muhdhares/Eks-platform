resource "aws_lb" "app" {
  name                       = local.names.alb
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_security_group_id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = var.alb_config.enable_deletion_protection
  idle_timeout               = var.alb_config.idle_timeout
  enable_http2               = var.alb_config.enable_http2
  drop_invalid_header_fields = var.alb_config.drop_invalid_header_fields
  desync_mitigation_mode     = var.alb_config.desync_mitigation_mode
  ip_address_type            = var.alb_config.ip_address_type
  tags = merge(local.common_tags, {
    Name = local.names.alb
  })
}
