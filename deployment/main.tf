module "vpc" {
  source = "./modules/vpc"

  region            = var.region
  vpc_cidr = "10.0.0.0/16"

  route = [
    {
      cidr_block     = "0.0.0.0/0"
      gateway_id     = module.vpc.gateway_id
      instance_id    = null
      nat_gateway_id = null
    }
  ]

  subnet_ids = module.subnet_ec2.ids
}

module "db" {
    source = "./modules/db"
}

module "app" {
  source = "./modules/app"

  region            = var.region
  ami           = "ami-07ebfd5b3428b6f4d" # Ubuntu Server 18.04 LTS
  key_name      = "mood-ec2-key"
  instance_type = var.instance_type
  subnet_id     = module.subnet_ec2.ids[0]

  vpc_security_group_ids = [aws_security_group.ec2.id]

  vpc_id = module.vpc.id
}

