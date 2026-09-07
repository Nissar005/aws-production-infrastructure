locals {
  name = "${var.project_name}-${var.environment}"
}

module "networking" {
  source = "./modules/networking"

  name       = local.name
  vpc_cidr   = var.vpc_cidr
  aws_region = var.aws_region
}
