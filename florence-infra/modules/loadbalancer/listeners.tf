resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = HTTP
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["frontend"].arn
  }
  tags = merge(local.common_tags, {
    Name = "${local.names.alb}-frontend"
  })
}


resource "aws_lb_listener_rule" "backend_api" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this["backend"].arn
  }
  condition {
    path_pattern {
      values = [
        "/api/*"
      ]
    }
  }
  tags = merge(local.common_tags, {
    Name = "${local.names.alb}-backend"
  })
}
