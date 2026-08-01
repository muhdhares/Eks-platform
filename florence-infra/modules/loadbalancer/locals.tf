locals {
  name_prefix = "${var.project_name}-${var.environment}"

  names = {
    alb = "${local.name_prefix}-alb"
    tg  = "${local.name_prefix}-tg"
  }

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
