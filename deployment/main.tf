provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

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
  my_ip  = "${module.myip.address}/32"
}

module "db" {
  source = "./modules/db"

  db_username = var.db_username
  db_password = var.db_password
  vpc_id = module.vpc.vpc_id
}
