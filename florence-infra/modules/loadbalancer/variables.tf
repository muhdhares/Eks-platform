variable "project_name" {
  description = "Name of the project goes here"
  type        = string
}

variable "environment" {
  description = "Environment of the project"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment can only be: dev, prod or staging"
  }
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB Security Group ID"
  type        = string
}

variable "autoscaling_groups" {
  description = "Auto scaling groups"
  type = map(object({
    name = string
    arn  = string
    id   = string
  }))
}

variable "target_groups" {
  description = "Target group Configuration"
  type = map(object({
    port     = number
    protocol = string
    health_check = object({
      path                = string
      protocol            = string
      matcher             = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
    })
    load_balancing_algorithm_type = string
  }))
}

variable "alb_config" {
  description = "Application Load Balancer configuration"

  type = object({
    idle_timeout               = number
    enable_deletion_protection = bool
    enable_http2               = bool
    drop_invalid_header_fields = bool
    desync_mitigation_mode     = string
    ip_address_type            = string
  })
}

variable "metadata" {
  description = "Metadata for the AWS resources"
  type = object({
    owner      = string
    repository = string
  })
}


variable "common_tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}
