provider "aws" {
  profile = "rds_project"
  region  = "eu-west-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"

  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
}

module "db" {
  source = "./modules/db"

  db_username = var.db_username
  vpc_id      = module.vpc.vpc_id
}

module "app" {
  source = "./modules/app"

  public_subnet_id = module.subnets.public_subnet_id
  vpc_id           = module.vpc.vpc_id
}

module "scaling" {
  source = "./modules/scaling"

  app_instance_id  = module.app.app_instance_id
  public_subnet_id = module.subnets.public_subnet_id
}
