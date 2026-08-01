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

variable "app_subnet_ids" {
  description = "The IDs of the application subnets"
  type        = list(string)
}

variable "app_sg_id" {
  description = "Security group id of application"
  type        = string
}

variable "instance_config" {
  description = "Configuration for Instance"
  type = map(object({
    instance_type    = string
    root_volume_size = number
    root_volume_type = string
    desired_capacity = number
    min_size         = number
    max_size         = number
    application_port = number
    userdata         = string
  }))
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
