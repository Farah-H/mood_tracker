resource "aws_db_instance" "mood_db" {
    allocated_storage = 50
    identifier = "mood_db"
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.m4.medium"
    name = "mood_db"
    username = var.db_username
    password = var.db_password
    parameter_group_name = "default.mysql5.7"
}

resource "aws_security_group" "mood_db_sg" {
  name = "mood-rds-sg"

  description = "RDS security group (terraform-managed)"
  vpc_id      = var.rds_vpc_id

  # Only MySQL in
  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_cidr_block
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.sg_egress_cidr_block
  }
}