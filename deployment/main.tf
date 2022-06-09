provider "aws" {}

module "myip" {
  source  = "4ops/myip/http"
  version = "1.0.0"
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
  db_password = var.db_password
  vpc_id      = module.vpc.vpc_id
}

module "app" {
  source = "./modules/app"

  public_subnet_id = module.subnets.public_subnet_id
  vpc_id           = module.vpc.vpc_id
}
