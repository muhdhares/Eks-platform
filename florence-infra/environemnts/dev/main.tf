module "vpc" {
  source = "../../modules/networking"
  providers = {
    aws = aws
  }
  project_name       = var.project_name
  environment        = var.environment
  aws_region         = var.aws_region
  vpc_cidr           = var.vpc_cidr_blocks
  subnets            = local.subnets
  metadata           = var.metadata
  db_port            = 3306
  availability_zones = local.availability_zone
  common_tags        = local.common_tags
}


module "compute" {
  source = "../../modules/compute"
  providers = {
    aws = aws
  }
  project_name    = var.project_name
  environment     = var.environment
  aws_region      = var.aws_region
  vpc_id          = module.vpc.vpc_id
  instance_config = local.instance_config
  app_sg_id       = module.vpc.security_groups_id.app
  app_subnet_ids  = values(module.vpc.app_subnet_ids)
  metadata        = var.metadata
  common_tags     = local.common_tags
}
