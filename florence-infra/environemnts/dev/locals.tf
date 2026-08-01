locals {
  name_prefix = "${var.project_name}-${var.environment}"

  availability_zone = data.aws_availability_zones.available.names


  subnets = {

    public_a = {
      cidr_block    = "10.0.1.0/24"
      az_index      = 0
      type          = "public"
      map_public_ip = true
    }

    public_b = {
      cidr_block    = "10.0.2.0/24"
      az_index      = 1
      type          = "public"
      map_public_ip = true
    }

    app_a = {
      cidr_block    = "10.0.11.0/24"
      az_index      = 0
      type          = "app"
      map_public_ip = false
    }

    app_b = {
      cidr_block    = "10.0.12.0/24"
      az_index      = 1
      type          = "app"
      map_public_ip = false
    }

    database_a = {
      cidr_block    = "10.0.21.0/24"
      az_index      = 0
      type          = "database"
      map_public_ip = false
    }

    database_b = {
      cidr_block    = "10.0.22.0/24"
      az_index      = 1
      map_public_ip = false
      type          = "database"
    }

  }

  instance_config = {
    frontend = {
      instance_type    = "t3.micro"
      root_volume_size = 8
      root_volume_type = "gp3"
      desired_capacity = 2
      min_size         = 2
      max_size         = 2
      application_port = 3000
      userdata         = <<EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl start httpd
      systemctl enable httpd
    EOF
    }

    backend = {
      instance_type    = "t3.micro"
      root_volume_size = 8
      root_volume_type = "gp3"
      desired_capacity = 2
      min_size         = 2
      max_size         = 2
      application_port = 3000
      userdata         = <<EOF
      #!/bin/bash
      yum update -y
      yum install -y nginx
      systemctl start nginx
      systemctl enable nginx
    EOF
    }
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
