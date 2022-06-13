output "vpc_id" {
  value = module.vpc.vpc_id
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "public_subnet_id" {
  value = module.subnets.public_subnet_id
}

output "private_subnet_id" {
  value = module.subnets.private_subnet_id
}

output "db_hostname" {
  value = module.db.db_host
}

output "db_credentials" {
  value = {
    db_username = module.db.db_username,
    db_password = module.db.db_password
  }
  sensitive = true
}

output "app_dns" {
  value = module.app.app_instance_dns
}

output "app_id" {
  value = module.app.app_instance_id
}

output "elb_id" {
  value = module.scaling.elb_id
}

output "elb_dns" {
  value = module.scaling.elb_dns
}
