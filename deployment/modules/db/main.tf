resource "aws_db_instance" "mood_db" {
  allocated_storage    = 50
  identifier_prefix    = "mood-db"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  db_name              = "users"
  username             = var.db_username
  password             = random_password.mood_db_password.result
  parameter_group_name = "default.mysql8.0"
  apply_immediately    = true
  port                 = 3306
  publicly_accessible  = false
  skip_final_snapshot  = true

  tags = {
    Name = "mood_rds"
  }
}

resource "random_password" "mood_db_password" {
  length  = 16
  special = true
}

resource "aws_security_group" "mood_db_sg" {
  name = "mood-rds-sg"

  description = "RDS security group (terraform-managed)"
  vpc_id      = var.vpc_id

  # Only MySQL in
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.20.0/24"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.20.0/24"]
  }

  tags = {
    Name = "mood-db-sg"
  }
}