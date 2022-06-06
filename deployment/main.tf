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
  my_ip  = "${module.myip.address}/32"
}

module "db" {
  source = "./modules/db"

  db_username = var.db_username
  db_password = var.db_password
  vpc_id = module.vpc.vpc_id
}

# module "app" {
#   source = "./modules/app"

#   region            = var.region
#   ami           = "ami-07ebfd5b3428b6f4d" # Ubuntu Server 18.04 LTS
#   key_name      = "mood-ec2-key"
#   instance_type = var.instance_type
#   subnet_id     = module.subnet_ec2.ids[0]

#   vpc_security_group_ids = [aws_security_group.ec2.id]

#   vpc_id = module.vpc.id
# }

