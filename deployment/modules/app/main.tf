resource "tls_private_key" "mood_tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "mood_key_pair" {
  key_name   = "mood-app-key-v2"
  public_key = tls_private_key.mood_tls_private_key.public_key_openssh
}

resource "local_file" "pem_file" {
  filename = pathexpand("~/.ssh/${aws_key_pair.mood_key_pair.key_name}.pem")
  file_permission = "400"
  sensitive_content = tls_private_key.mood_tls_private_key.private_key_pem
}

resource "aws_instance" "mood_app" {
  ami                         = "ami-00c90dbdc12232b58"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_id
  security_groups             = [aws_security_group.mood_app_sg.id]
  key_name = aws_key_pair.mood_key_pair.key_name
  
  tags = {
    Name = "mood-app-instance"
  }
}

resource "aws_eip" "mood_eip" {
  vpc      = true
  instance = aws_instance.mood_app.id

  tags = {
    Name = "mood-eip"
  }
}

resource "aws_security_group" "mood_app_sg" {
  name = "mood-app-ec2-sg"

  description = "EC2 security group (terraform-managed)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    description = "MySQL"
    cidr_blocks = ["10.0.10.0/24"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mood-app-sg"
  }
}